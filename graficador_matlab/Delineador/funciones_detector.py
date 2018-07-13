import sys, os

import importlib

from IPython.display import display
import matplotlib.pyplot as plt
#matplotlib inline
import numpy as np
import shutil

import wfdb
from wfdb import processing

def detectar_qrs(registro, canal):
    #ganancia=(2.42/3/((2^23)-1))
    Fs = 250 #Frecuencia de muestreo
    wfdb.wrsamp('prueba', fs = Fs, units = ['V','V'], sig_name = ['C1', 'C2'], p_signal=registro, fmt=['16', '16']) #

    ecg = wfdb.rdrecord('prueba')

    config=wfdb.processing.XQRS.Conf(hr_init=75, hr_max=200, hr_min=25, qrs_width=0.1, qrs_thr_init=2, qrs_thr_min=0, ref_period=0.2, t_inspect_period=0.36)
    #config = wfdb.processing.XQRS.Conf(hr_init=75, hr_max=200, hr_min=25, qrs_width=0.1, qrs_thr_init=0.13, qrs_thr_min=0, ref_period=0.2, t_inspect_period=0.36)

    sig, fields = wfdb.rdsamp('prueba', channels=[canal], sampfrom=50) # (*)ver la corrección de los índices

    n_sig=wfdb.processing.normalize_bound(sig, lb=0, ub=1) #Normalizo la señal entre 0 y 1

    qrs_inds = processing.xqrs_detect(sig=n_sig[:,0], fs=fields['fs'], conf=config)
    #qrs_inds = processing.xqrs_detect(sig=sig[:,0], fs=fields['fs'],sampfrom=50,conf=config)

    #Corrijo los qrs detectados para que coincidan con los picos
    search_radius = int(fields['fs'] * 60 / config.hr_max)
    corrected_peak_inds = processing.correct_peaks(sig[:, 0], peak_inds=qrs_inds, search_radius=search_radius, smooth_window_size=150)
    corrected_peak_inds= corrected_peak_inds+50 #Corrijo los índices porque no leo las primeras 50 muestras (*)
    
    return ecg, corrected_peak_inds


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

    return matriz_latidos, min_RR# pos_r


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
#
#plt.figure()
##plt.plot(latido_promedio_c1,latido_promedio_c2)
#plt.quiver(latido_promedio_c1,latido_promedio_c2, c1d, c2d, scale_units='xy', angles='xy', scale=1)
#plt.xlim(-lim, lim)
#plt.ylim(lim, -lim)
#plt.grid(True)
##wfdb.plot_wfdb(registro)
##plt.show()
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


###PCA
#http://scikit-learn.org/stable/modules/generated/sklearn.decomposition.PCA.html
#http://scikit-learn.org/stable/modules/generated/sklearn.cluster.KMeans.html

#pca = PCA(n_components=2)
#
#c1_pca=pca.fit_transform(matriz_latidos_c1)
#c2_pca=pca.fit_transform(matriz_latidos_c2)
#
#kmeans_c1 = KMeans(n_clusters=3, random_state=0).fit(c1_pca)
#kmeans_c2 = KMeans(n_clusters=3, random_state=0).fit(c2_pca)
#
#plt.figure()
#plt.scatter(c1_pca[:,0],c1_pca[:,1])
#plt.scatter(kmeans_c1.cluster_centers_[:,0],kmeans_c1.cluster_centers_[:,1], c='r')
#
#plt.figure()
#plt.scatter(c2_pca[:,0],c2_pca[:,1])
#plt.scatter(kmeans_c2.cluster_centers_[:,0],kmeans_c2.cluster_centers_[:,1], c='r')
#
#plt.show()
