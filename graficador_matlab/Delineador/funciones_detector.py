import sys, os

import importlib

from IPython.display import display
import matplotlib.pyplot as plt
#matplotlib inline
import numpy as np
import shutil

import wfdb
from wfdb import processing

def detectar_qrs(archivo, directorio_registros_procesados, umbral=None):
    #ganancia=(2.42/3/((2^23)-1))
    if umbral == None:
        umbral = 2
    Fs = 250 #Frecuencia de muestreo

    registro = np.genfromtxt(archivo, delimiter=',') # Cargo el archivo con los registros de una posición
    #registro = np.genfromtxt(sys.argv[1], delimiter=',',skip_header=20) # Para algunos registros hay que borrar más datos
    registro=registro*1000
    
    nombre=archivo.split("/")[2] # Saco el nombre del paciente del nombre de archivo
    posicion=archivo.split("/")[-1].split("_")[1] #Saco el la posición de la medición del nombre de archivo
   
    archivo_wfdb= nombre + "_" + posicion #El nombre del archivo para guardar las anotaciones
    
    wfdb.wrsamp(archivo_wfdb, fs = Fs, units = ['V','V'], sig_name = ['C1', 'C2'], p_signal=registro, fmt=['16', '16'], write_dir=directorio_registros_procesados) #

    ecg = wfdb.rdrecord(directorio_registros_procesados+archivo_wfdb)

    #config=wfdb.processing.XQRS.Conf(hr_init=75, hr_max=200, hr_min=25, qrs_width=0.1, qrs_thr_init=umbral, qrs_thr_min=0, ref_period=0.2, t_inspect_period=0.36)
    #config = wfdb.processing.XQRS.Conf(hr_init=75, hr_max=200, hr_min=25, qrs_width=0.1, qrs_thr_init=0.13, qrs_thr_min=0, ref_period=0.2, t_inspect_period=0.36)

    #Detecta las posiciones de las r
    #Primero intenta en el canal 0, si no encuentra nada pasa al 1
    canal=0
    qrs_inds_aux=[]
    sig_aux=[]
    fields_aux=[]
    #while len(qrs_inds)==0 and canal<2:
    while canal<2:
        sig, fields = wfdb.rdsamp(directorio_registros_procesados+archivo_wfdb, channels=[canal], sampfrom=50) # (*)ver la corrección de los índices
        sig_aux.append(sig)
        fields_aux.append(fields)
        n_sig=wfdb.processing.normalize_bound(sig, lb=0, ub=1) #Normalizo la señal entre 0 y 1
 
        umbral=np.median(np.absolute(n_sig))/0.6745
        config=wfdb.processing.XQRS.Conf(hr_init=75, hr_max=200, hr_min=25, qrs_width=0.1, qrs_thr_init=umbral, qrs_thr_min=0, ref_period=0.2, t_inspect_period=0.36)
        
        #qrs_inds = processing.xqrs_detect(sig=sig[:,0], fs=fields['fs'],sampfrom=50,conf=config)
        qrs_inds_aux.append(processing.xqrs_detect(sig=n_sig[:,0], fs=fields['fs'], conf=config))
        
        canal=canal+1
    
    # Tomo los qrs del canal donde haya detectado más
    if len(qrs_inds_aux[0]) > len(qrs_inds_aux[1]):
        qrs_inds = qrs_inds_aux[0]
        sig=sig_aux[0]
        fields=fields_aux[0]
        canal=1
        #sig, fields = wfdb.rdsamp(directorio_registros_procesados+archivo_wfdb, channels=[canal], sampfrom=50) # (*)ver la corrección de los índices
    else:
        qrs_inds = qrs_inds_aux[1]
        sig=sig_aux[1]
        fields=fields_aux[1]
        canal=2

    #Si no se detectan r sale de la función
    if qrs_inds.size==0:
        return ecg, qrs_inds, nombre

    print(canal)
    #Corrijo los qrs detectados para que coincidan con los picos
    search_radius = int(fields['fs'] * 60 / config.hr_max)
    corrected_peak_inds = processing.correct_peaks(sig[:, 0], peak_inds=qrs_inds, search_radius=search_radius, smooth_window_size=150)
    corrected_peak_inds= corrected_peak_inds+50 #Corrijo los índices porque no leo las primeras 50 muestras (*)
    
    #Si encontró picos los guardo en el archivo de anotaciones .ann
    wfdb.wrann(archivo_wfdb, 'ann', corrected_peak_inds, symbol=['N']*len(qrs_inds), chan=np.array([canal]*len(qrs_inds)), write_dir=directorio_registros_procesados)
    
    return ecg, corrected_peak_inds, nombre


def separar_latidos(ecg, qrs_inds):
    ##Separa los latidos y los guarda por filas en una matriz.
    #ecg = wfdb.rdrecord('record')
    Fs = 250 #Frecuencia de muestreo
    #delay = round(0.1/(1/Fs))
    delay = 1
    M = qrs_inds.size
    RR = np.diff(qrs_inds) #Vector de intervalos RR
    min_RR=np.min(RR) #Latido más corto
    matriz_latidos = np.zeros((M,((min_RR//2)-delay)*2))*np.nan #Matriz para guardar los latidos por filas.
                                                                #Divido y multiplico x2 min_RR por si es impar
    cortes=[]
    
    for m in range(0,M):
        # Uso un aux porque necesito saber el largo de los latidos para que si uno
        # queda más corto me deje guardarlo en la matriz. 
        a = np.max([0, qrs_inds[m]-((min_RR//2)-delay)])
        b = qrs_inds[m]+(min_RR//2)-delay
        #cortes.append(a)
        #cortes.append(b)
        aux = ecg[a:b]
        pos_inicial = np.int(np.abs(np.min(np.array([0, qrs_inds[m]-(np.floor(min_RR/2)-delay)]))))
        matriz_latidos[m,pos_inicial:aux.size+pos_inicial] = aux

    ##Completo los latidos que quedaron cortados con el promedio de los anteriores en ese sector
    pos_datos_faltantes=np.where(np.isnan(matriz_latidos))
    col_mean = np.nanmean(matriz_latidos, axis=0)
   
    #pos_r=min_RR//2-delay
    #agregado=np.mean(matriz_latidos[0:M-2,-pos_datos_faltantes.shape[0]:], axis=0)
    
    #a=matriz_latidos[0:M-2,-pos_datos_faltantes.shape[0]:] #Matriz auxiliar para calcular la potencia
    #potencia_agregado=np.mean(np.sqrt(np.sum(np.square(a),axis=1)/a.shape[1])) #Calculo el promedio de la potencia
    #agregado2=agregado*potencia_agregado
    
    matriz_latidos[pos_datos_faltantes]=np.take(col_mean, pos_datos_faltantes[1])
    min_RR=matriz_latidos.shape[1]

    return matriz_latidos, min_RR# pos_r


def analizar_registros_procesados(directorio_registros_procesados):
    """
    Grafica los registros con anotaciones de un directorio
    Si la detección no resultó correcta, se guarda el nombre del archivo para procesarlo después
    """
    registros_wfdb = [arch for arch in os.listdir(directorio_registros_procesados)]
    registros_wfdb = [aux.split('.ann')[0] for aux in registros_wfdb if aux.endswith('.ann')]
    registros_wfdb.sort()

    for arch in registros_wfdb:
        print("Analizando registro "+arch)
        #registro = wfdb.rdrecord(os.path.join(directorio_registros_procesados, arch))
        sig, fields = wfdb.rdsamp(os.path.join(directorio_registros_procesados, arch))
        anotaciones = wfdb.rdann(os.path.join(directorio_registros_procesados, arch), 'ann')
        #wfdb.plot_wfdb(registro, annotation=anotaciones, title='Registro - %s' % registro.record_name)

        #Grafico los 2 canales y los qrs detectados en el canal correspondiente
        plt.figure()
        plt.subplot(2, 1, 1)
        plt.title('Registro '+arch)
        plt.plot(sig[:,0])
        plt.ylabel('C1')

        plt.subplot(2, 1, 2)
        plt.plot(sig[:,1])
        plt.xlabel('Muestras')
        plt.ylabel('C2')

        plt.subplot(2, 1, anotaciones.chan[0])
        plt.plot(anotaciones.sample, sig[anotaciones.sample,anotaciones.chan[0]-1], 'rx')

        plt.ion()
        plt.show()
        input("Presione enter")

        #bien_detectado=[]
        #while bien_detectado != 's' and bien_detectado != 'n':
        #    bien_detectado = str.lower(input("¿Registro " + arch + " bien detectado? [s/n]: "))

        #if bien_detectado == 'n':
        #    #Si no está bien detectado guarda el nombre del archivo original
        #    directorio=arch.split('_')[0]
        #    guardar_no_detectado("no_detectados.txt","../Datos_filtrados/"+directorio+"/"+arch+"_filt.txt")
        #    os.remove(os.path.join(directorio_registros_procesados+arch+".ann"))
        #elif bien_detectado == 's':
        #    #Si está bien detectado mueve los archivos al directorio 'ok'
        #    os.rename(directorio_registros_procesados+"/"+arch+".dat", directorio_registros_procesados+"/ok/"+arch+".dat")
        #    os.rename(directorio_registros_procesados+"/"+arch+".hea", directorio_registros_procesados+"/ok/"+arch+".hea")
        #    os.rename(directorio_registros_procesados+"/"+arch+".ann", directorio_registros_procesados+"/ok/"+arch+".ann")

def guardar_no_detectado(nombre_archivo, registro_no_detectado):
    """
    Guarda en 'nombre_archivo' la ruta del 'registro_no_detectado' en el que no se detectaron r para procesarlo después
    """
    archivo_no_detectados = open(nombre_archivo, "a")
    archivo_no_detectados.write(registro_no_detectado+"\n")
    archivo_no_detectados.close()

#Límite para los ejes
#lim=np.max([np.max(np.abs(latido_promedio_c1)),np.max(np.abs(latido_promedio_c2))])
#lim=lim*1.1;


#wfdb.plot_wfdb(ecg)
#wfdb.plot_items(signal=n_sig, ann_samp=[qrs_inds])
#wfdb.plot_items(signal=sig, ann_samp=[qrs_inds])
#
##Grafico el vecto
#c1d=np.diff(latido_promedio_c1)
#c1d=np.append(c1d,latido_promedio_c1[-1]-latido_promedio_c1[0])
##c1d=latido_promedio_c1[1:]-latido_promedio_c1[:-1]
#c2d=np.diff(latido_promedio_c2)
#c2d=np.append(c2d,latido_promedio_c2[-1]-latido_promedio_c2[0])
##c2d=latido_promedio_c2[1:]-latido_promedio_c2[:-1]
##
#plt.figure()
#plt.title('Vecto')
#plt.xlabel('Tensión [V]')
#plt.ylabel('Tensión [V]')
##plt.plot(latido_promedio_c1,latido_promedio_c2)
#plt.quiver(latido_promedio_c1,latido_promedio_c2, c1d, c2d, scale_units='xy', angles='xy', scale=1)
#plt.xlim(-lim, lim)
#plt.ylim(lim, -lim)
#plt.grid(True)
#wfdb.plot_wfdb(registro)
#plt.show()
#
#plt.figure()
#plt.plot(matriz_latidos_c1.T,'--')
#plt.plot(latido_promedio_c1,'k')
##plt.show()
#
#plt.figure()
#plt.plot(matriz_latidos_c2.T,'--')
#plt.plot(latido_promedio_c2,'k')
#plt.show()

#plt.figure()
#plt.plot(lista_pacientes[0].matriz_latidos_c1.T,'--')
#plt.plot(latido_promedio_c1,'k')
#plt.title('Canal 1')
#plt.xlabel('Muestras')
#plt.ylabel('Tensión [V]')
#plt.ylim(-lim, lim)
#plt.grid(True)
##ax.set(ylim=[-lim, lim], xlabel='Muestras', ylabel='Tensión[V]', title='Canal1')
##plt.axvline(x=matriz_latidos_c2.shape[1]//2, color='r')
#
#plt.figure()
#plt.plot(lista_pacientes[0].matriz_latidos_c2.T,'--')
#plt.plot(latido_promedio_c2,'k')
#plt.title('Canal 2')
#plt.xlabel('Muestras')
#plt.ylabel('Tensión [V]')
#plt.ylim(-lim, lim)
#plt.grid(True)
##ax.set(ylim=[-lim, lim], xlabel='Muestras', ylabel='Tensión[V]', title='Canal1')
##plt.axvline(x=matriz_latidos_c2.shape[1]//2, color='r')
#plt.show()



#plt.figure()
#plt.scatter(c1_pca[:,0],c1_pca[:,1])
#plt.scatter(kmeans_c1.cluster_centers_[:,0],kmeans_c1.cluster_centers_[:,1], c='r')
#
#plt.figure()
#plt.scatter(c2_pca[:,0],c2_pca[:,1])
#plt.scatter(kmeans_c2.cluster_centers_[:,0],kmeans_c2.cluster_centers_[:,1], c='r')
#
#plt.show()
