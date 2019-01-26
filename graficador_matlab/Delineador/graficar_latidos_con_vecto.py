#! /usr/bin/python3

from IPython.display import display
import numpy as np

import importlib

import matplotlib
matplotlib.use('Agg') #Cambio el backend para que no me muestre las imágenes y las guarde directamente
import matplotlib.pyplot as plt
import matplotlib.cm as cm
import matplotlib.ticker as ticker #Para poder cambiar la escala de los ejes
from itertools import cycle

#from sklearn.decomposition import PCA
#from sklearn.preprocessing import StandardScaler
#from sklearn.cluster import KMeans

import pickle #Para persistencia de objetos

class Paciente(object):
    def __init__(self, nombre=None, matriz_latidos_c1=None, matriz_latidos_c2=None, largo_latidos=None, patologia=None):
        self.nombre=nombre
        self.matriz_latidos_c1=matriz_latidos_c1
        self.matriz_latidos_c2=matriz_latidos_c2
        self.largo_latidos=largo_latidos
        self.patologia=patologia

    
for pos in range(1,19):
#for pos in range(16,17):
    lista_control=[]
    lista_bloqueo=[]
    lista_pacientes=[]

    posicion=str(pos).zfill(2) #Lo paso a cadena y le agrego ceros hasta completar 2 dígitos

    nombre_archivo = "paciente_pos"+posicion+".obj"
    archivo_pacientes = open(nombre_archivo, "rb")
    lista_pacientes=pickle.load(archivo_pacientes)
    archivo_pacientes.close()

    #paciente=[paciente for paciente in lista_pacientes if "C12" in paciente.nombre]
    for paciente in lista_pacientes:
        ##Calculo el latido promedio en cada canal
    #latido_promedio_c1=np.mean(paciente[0].matriz_latidos_c1, axis=0)
    #latido_promedio_c2=np.mean(paciente[0].matriz_latidos_c2, axis=0)
        latido_promedio_c1=np.mean(paciente.matriz_latidos_c1, axis=0)
        latido_promedio_c2=np.mean(paciente.matriz_latidos_c2, axis=0)

        lim=np.max([np.max(np.abs(latido_promedio_c1)),np.max(np.abs(latido_promedio_c2))])
        lim=lim*1.1;
        ## Vecto
        #Calculo el latido promedio en cada canal
        #latidos_promedio_c1=[np.mean(paciente.matriz_latidos_c1, axis=0) for paciente in lista_pacientes]
        #latidos_promedio_c2=[np.mean(paciente.matriz_latidos_c2, axis=0) for paciente in lista_pacientes]
        c1d=np.diff(latido_promedio_c1)
        c1d=np.append(c1d,latido_promedio_c1[-1]-latido_promedio_c1[0])
        ##c1d=latido_promedio_c1[1:]-latido_promedio_c1[:-1]
        c2d=np.diff(latido_promedio_c2)
        c2d=np.append(c2d,latido_promedio_c2[-1]-latido_promedio_c2[0])
        ##c2d=latido_promedio_c2[1:]-latido_promedio_c2[:-1]
        # Set up the axes with gridspec

        fig = plt.figure(figsize=(6, 6))
        grid = plt.GridSpec(4, 4, hspace=0.2, wspace=0.2)
        vecto = fig.add_subplot(grid[:-1, 1:])
        canal1 = fig.add_subplot(grid[-1, 1:], sharex=vecto)
        canal2 = fig.add_subplot(grid[:-1, 0], sharey=vecto)
        
        vecto.axis(xmin=-lim, xmax=lim, ymin=lim, ymax=-lim) #Pone los límites
        plt.setp(vecto.get_xticklabels(), visible=False) #Saca los xtickslabels del gráfico de vecto
        plt.setp(vecto.get_yticklabels(), visible=False) #Saca los ytickslabels del gráfico de vecto
        vecto.tick_params(axis='both', which='both', bottom=False, top=False, labelbottom=False, right=False, left=False, labelleft=False) #Saca los xtics e yticks del gráfico de vecto

        plt.subplots_adjust(hspace=0)
        plt.suptitle(paciente.nombre.split('_')[0]+' Pos:'+posicion)
#    plt.suptitle(paciente[0].nombre+' Pos:'+posicion)
        vecto.set_title('Vectocardiograma')
        canal1.text(0.1, 0.85, 'Canal 1', horizontalalignment='center', transform=canal1.transAxes) #Defino así los títulos para
        canal2.text(0.5, 0.96, 'Canal 2', horizontalalignment='center', transform=canal2.transAxes) #que queden dentro del graf.
        canal1.set_xlabel('Tensión [mV]')
        canal1.set_ylabel('Seg.')
        canal2.set_xlabel('Seg.')
        canal2.set_ylabel('Tensión [mV]')
        canal1.yaxis.set_major_locator(plt.MaxNLocator(3))
        canal2.xaxis.set_major_locator(plt.MaxNLocator(3))
        ##plt.plot(latido_promedio_c1,latido_promedio_c2)
        #wfdb.plot_wfdb(registro)
        #plt.show()

        vecto.quiver(latido_promedio_c1,latido_promedio_c2, c1d, c2d, scale_units='xy', angles='xy', scale=1)
        canal1.plot(latido_promedio_c1, np.asarray(range(0, len(latido_promedio_c1))))
        canal2.plot(latido_promedio_c2)
        
        m=np.argmin(latido_promedio_c1)
        vecto.plot(latido_promedio_c1[m],latido_promedio_c2[m], 'r.')
        canal1.plot(latido_promedio_c1[m], m, 'r.')
        canal2.plot(m, latido_promedio_c2[m], 'r.')
        ##Escalo los ejes
        escalado_tension = 1e-3
        ticks_v = ticker.FuncFormatter(lambda x, pos: '{0:g}'.format(x/escalado_tension))
        canal1.xaxis.set_major_formatter(ticks_v)
        canal2.yaxis.set_major_formatter(ticks_v)

        escalado_tiempo = 250
        ticks_t = ticker.FuncFormatter(lambda x, pos: '{0:g}'.format(x/escalado_tiempo))
        canal1.yaxis.set_major_formatter(ticks_t)
        canal2.xaxis.set_major_formatter(ticks_t)

        vecto.grid(True)
        canal1.grid(True)
        canal2.grid(True)
        
        plt.savefig("Graficos/lat_vecto_"+paciente.nombre.split('_')[0]+"_"+posicion, format="pdf")

    print(pos)
    plt.close("all")
    #plt.ion()
    #plt.show()


#paciente=[paciente for paciente in lista_pacientes if "18" in paciente.nombre]
##Calculo el latido promedio en cada canal
#latido_promedio_c1=np.mean(paciente[0].matriz_latidos_c1, axis=0)
#latido_promedio_c2=np.mean(paciente[0].matriz_latidos_c2, axis=0)
##Límite para los ejes
#lim=np.max([np.max(np.abs(latido_promedio_c1)),np.max(np.abs(latido_promedio_c2))])
#lim=lim*1.1;
#
#### Latidos cortados superpuestos y promedio
#plt.figure()
#plt.plot(paciente[0].matriz_latidos_c1.T,'--')
##plt.plot(lista_pacientes[0].matriz_latidos_c1.T,'--')
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
#plt.plot(paciente[0].matriz_latidos_c2.T,'--')
##plt.plot(lista_pacientes[0].matriz_latidos_c2.T,'--')
#plt.plot(latido_promedio_c2,'k')
#plt.title('Canal 2')
#plt.xlabel('Muestras')
#plt.ylabel('Tensión [V]')
#plt.ylim(-lim, lim)
#plt.grid(True)
##ax.set(ylim=[-lim, lim], xlabel='Muestras', ylabel='Tensión[V]', title='Canal1')
##plt.axvline(x=matriz_latidos_c2.shape[1]//2, color='r')
#plt.ion()
#plt.show()



