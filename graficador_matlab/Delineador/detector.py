#! /usr/bin/python3

import sys, os
import glob

import importlib

from IPython.display import display
import matplotlib.pyplot as plt
import matplotlib.cm as cm
from itertools import cycle
import numpy as np
import shutil

import wfdb
from wfdb import processing

from sklearn.decomposition import PCA
from sklearn.cluster import KMeans

import funciones_detector
importlib.reload(funciones_detector) #Recargo el módulo para que si cambio algo se actualice
from funciones_detector import detectar_qrs, separar_latidos

directorio_datos = '../Datos_filtrados/'

#yourpath = 'path'
#for root, dirs, files in os.walk(yourpath, topdown=False):
#    for name in files: #Lista todos los archivos dentro de los directorios dentro de root
#        print(os.path.join(root, name))
#    for name in dirs: #Lista los directorios dentro de root
#        print(os.path.join(root, name))

#for nombre in glob.glob(os.path.join(directorio_datos+'**/*01*'), recursive=True):
#    print (nombre)

#registro = np.genfromtxt(sys.argv[1], delimiter=',') # Cargo el archivo con los registros de una posición
#registro = np.genfromtxt(sys.argv[1], delimiter=',',skip_header=20) # Para algunos registros hay que borrar unos datos más
#registro=registro*1000
#canal = int(sys.argv[2]) # Cargo el canal que voy a detectar

#registro = np.genfromtxt('../Datos/Martín-Mello-Teggia/filt/Martín-Mello-Teggia_01_filt.txt', delimiter=',') # Cargo el archivo con los registros de una posición
#canal = 0 # Cargo el canal que voy a detectar

class Paciente(object):
    def __init__(self, nombre=None, matriz_latidos_c1=None, matriz_latidos_c2=None, largo_latidos=None):
        self.nombre=nombre
        self.matriz_latidos_c1=matriz_latidos_c1
        self.matriz_latidos_c2=matriz_latidos_c2
        self.largo_latidos=largo_latidos

lista_pacientes=[]

for archivo in glob.glob(os.path.join(directorio_datos+'**/*03*'), recursive=True):
    print("\n"+archivo)
    registro = np.genfromtxt(archivo, delimiter=',') # Cargo el archivo con los registros de una posición
    #registro = np.genfromtxt(sys.argv[1], delimiter=',',skip_header=20) # Para algunos registros hay que borrar más datos
    registro=registro*1000
    canal = 0 # Cargo el canal que voy a detectar desde el archivo de canales
    
    ecg, qrs_inds = detectar_qrs(registro, canal)
    
    if qrs_inds.size!=0:
        matriz_latidos_c1, largo_latidos = separar_latidos(ecg.p_signal[:,0], qrs_inds)
        matriz_latidos_c2, largo_latidos = separar_latidos(ecg.p_signal[:,1], qrs_inds)

        #Corrijo la escala
        matriz_latidos_c1=matriz_latidos_c1/1000
        matriz_latidos_c2=matriz_latidos_c2/1000
        
        nombre=archivo.split("/")[2]
        nombre=nombre.replace("-"," ")
        #pos_r=matriz_latidos_c1.shape[1]//2#calculo pos_r

        lista_pacientes.append(Paciente(nombre, matriz_latidos_c1, matriz_latidos_c2, largo_latidos))
    else:
        print("No se detectaron ondas R")

#Calculo el latido promedio en cada canal
#latido_promedio_c1=np.mean(matriz_latidos_c1, axis=0)
#latido_promedio_c2=np.mean(matriz_latidos_c2, axis=0)

latido_min=min(paciente.largo_latidos for paciente in lista_pacientes) #Latido más corto entre todos los pacientes
latido_max=max(paciente.largo_latidos for paciente in lista_pacientes) #Latido más largo entre todos los pacientes
cant_total_latidos=sum(paciente.matriz_latidos_c1.shape[0] for paciente in lista_pacientes)

#Hago una lista con las matrices para alinearlas juntas
matrices_c1=[paciente.matriz_latidos_c1 for paciente in lista_pacientes]
matrices_c2=[paciente.matriz_latidos_c2 for paciente in lista_pacientes]

#Recorto las matrices a la cantidad menor de columnas
for i, mat in enumerate(matrices_c1):
    dif=(mat.shape[1]-latido_min)//2
    matrices_c1[i]=mat[:,dif:(mat.shape[1]-dif)]
    
for i, mat in enumerate(matrices_c2):
    dif=(mat.shape[1]-latido_min)//2
    matrices_c2[i]=mat[:,dif:(mat.shape[1]-dif)]

#Hago una matriz por canal con los latidos de todos los pacientes
latidos_c1=np.concatenate(matrices_c1, axis=0)
latidos_c2=np.concatenate(matrices_c2, axis=0)

###PCA
#http://scikit-learn.org/stable/modules/generated/sklearn.decomposition.PCA.html
#http://scikit-learn.org/stable/modules/generated/sklearn.cluster.KMeans.html

pca = PCA(n_components=2)

pca_c1=pca.fit_transform(latidos_c1)
pca_c2=pca.fit_transform(latidos_c2)

cant_latidos=[len(paciente.matriz_latidos_c1) for paciente in lista_pacientes]
rango_colores=np.cumsum(cant_latidos)

#Divido el arreglo en arreglos por cada paciente para graficar
pca_c1_por_paciente=np.split(pca_c1, rango_colores[0:-1])
pca_c2_por_paciente=np.split(pca_c2, rango_colores[0:-1])

#plot es más eficiente que scatter para muchos datos
#https://jakevdp.github.io/PythonDataScienceHandbook/04.02-simple-scatter-plots.html#plot-Versus-scatter:-A-Note-on-Efficiency
marcadores = ['o', 'x', '+', 'v', '^', '<', '>', 's', 'D']
ciclo_marcadores = cycle(marcadores)
colors = iter(cm.rainbow(np.linspace(0, 1, len(pca_c1_por_paciente))))
plt.figure()
for i, paciente in enumerate(pca_c1_por_paciente):
    plt.plot(paciente[:,0], paciente[:,1], marker=next(ciclo_marcadores), linestyle="None", color=next(colors), label=lista_pacientes[i].nombre)
plt.legend()

ciclo_marcadores = cycle(marcadores)
plt.figure()
colors = iter(cm.rainbow(np.linspace(0, 1, len(pca_c1_por_paciente))))
for i, paciente in enumerate(pca_c2_por_paciente):
    plt.plot(paciente[:,0], paciente[:,1], marker=next(ciclo_marcadores), linestyle="None", color=next(colors), label=lista_pacientes[i].nombre)
plt.legend()

plt.show()
#
#kmeans_c1 = KMeans(n_clusters=3, random_state=0).fit(c1_pca)
#kmeans_c2 = KMeans(n_clusters=3, random_state=0).fit(c2_pca)
