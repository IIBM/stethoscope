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

from sklearn.decomposition import PCA
from sklearn.preprocessing import StandardScaler
from sklearn.cluster import KMeans

import pickle #Para persistencia de objetos

class Paciente(object):
    def __init__(self, nombre=None, matriz_latidos_c1=None, matriz_latidos_c2=None, largo_latidos=None, patologia=None):
        self.nombre=nombre
        self.matriz_latidos_c1=matriz_latidos_c1
        self.matriz_latidos_c2=matriz_latidos_c2
        self.largo_latidos=largo_latidos
        self.patologia=patologia

    
#for pos in range(6,7):
for pos in range(1,19):
    lista_control=[]
    lista_bloqueo=[]
    lista_pacientes=[]
    lim=[]

    posicion=str(pos).zfill(2) #Lo paso a cadena y le agrego ceros hasta completar 2 dígitos

    nombre_archivo = "paciente_pos"+posicion+".obj"
    archivo_pacientes = open(nombre_archivo, "rb")
    lista_pacientes=pickle.load(archivo_pacientes)
    archivo_pacientes.close()

    paciente=[paciente for paciente in lista_pacientes if "control" in paciente.patologia]
    
    fig, ax = plt.subplots(3, 3, sharex='col', sharey='row') 
   
    cont_paciente=0

    for i in range(3):
        for j in range(3):
            #Calculo el latido promedio en cada canal
            latido_promedio_c1=np.mean(paciente[cont_paciente].matriz_latidos_c1, axis=0)
            latido_promedio_c2=np.mean(paciente[cont_paciente].matriz_latidos_c2, axis=0)
        
            lim.append(np.max([np.max(np.abs(latido_promedio_c1)),np.max(np.abs(latido_promedio_c2))]))
            
            c1d=np.diff(latido_promedio_c1)
            c1d=np.append(c1d,latido_promedio_c1[-1]-latido_promedio_c1[0])
            
            c2d=np.diff(latido_promedio_c2)
            c2d=np.append(c2d,latido_promedio_c2[-1]-latido_promedio_c2[0])
            
            #plt.subplot(3, 3, i)
            ax[i,j].quiver(latido_promedio_c1,latido_promedio_c2, c1d, c2d, scale_units='xy', angles='xy', scale=1)
            ax[i,j].set_title(paciente[cont_paciente].nombre)

            cont_paciente=cont_paciente+1

    lim=np.max(lim)*1.1

    for i in range(3):
        for j in range(3):
            ax[i,j].axis([-lim, lim, lim, -lim]) #Pone los límites
            escalado_tension = 1e-3
            ticks_v = ticker.FuncFormatter(lambda x, pos: '{0:g}'.format(x/escalado_tension))
            ax[i,j].xaxis.set_major_formatter(ticks_v)
            ax[i,j].yaxis.set_major_formatter(ticks_v)
    
    plt.suptitle("Posicion "+posicion)
    
    plt.savefig("Graficos/Vectos_controles_pos_"+posicion, format="pdf")

#plt.ion()
#plt.show()


