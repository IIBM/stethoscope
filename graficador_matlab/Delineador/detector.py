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
from sklearn.preprocessing import StandardScaler
from sklearn.cluster import KMeans

import funciones_detector
importlib.reload(funciones_detector) #Recargo el módulo para que si cambio algo se actualice
from funciones_detector import detectar_qrs, separar_latidos, analizar_registros_procesados, guardar_no_detectado

directorio_origen_datos = '../Datos_filtrados/'
directorio_registros_procesados = './Registros/'

#class Paciente(object):
#    def __init__(self, nombre=None, matriz_latidos_c1=None, matriz_latidos_c2=None, largo_latidos=None):
#        self.nombre=nombre
#        self.matriz_latidos_c1=matriz_latidos_c1
#        self.matriz_latidos_c2=matriz_latidos_c2
#        self.largo_latidos=largo_latidos
#
#lista_pacientes=[]

#archivos=[arch for arch in glob.glob(os.path.join(directorio_origen_datos+'*/*.txt'), recursive=True)]
#archivos.sort()
#for archivo in archivos:
#for archivo in glob.glob(os.path.join(directorio_origen_datos+'*/*03*.txt'), recursive=True):
#    print("\n"+archivo)
#    
#    detectar_qrs(archivo, directorio_registros_procesados)


aux_arch = open("no_detectados.txt", "r")
no_detectados = aux_arch.read().splitlines()
aux_arch.close()
open("no_detectados.txt", "w").close() #Borro el contenido del archivo
for archivo in no_detectados:
    print("\n"+archivo)
    
    #detectar_qrs(archivo, directorio_registros_procesados, umbral=2)
    #detectar_qrs(archivo, directorio_registros_procesados, umbral=0.13)
    detectar_qrs(archivo, directorio_registros_procesados)

#    if qrs_inds.size!=0:
#        matriz_latidos_c1, largo_latidos = separar_latidos(ecg.p_signal[:,0], qrs_inds)
#        matriz_latidos_c2, largo_latidos = separar_latidos(ecg.p_signal[:,1], qrs_inds)
#
#        #Corrijo la escala
#        matriz_latidos_c1=matriz_latidos_c1/1000
#        matriz_latidos_c2=matriz_latidos_c2/1000
#        
#        nombre=nombre.replace("-"," ")
#        #pos_r=matriz_latidos_c1.shape[1]//2#calculo pos_r
#
#        lista_pacientes.append(Paciente(nombre, matriz_latidos_c1, matriz_latidos_c2, largo_latidos))
#    else:
#        print("No se detectaron ondas R")
#        guardar_no_detectado("no_detectados.txt", archivo)


#latido_min=min(paciente.largo_latidos for paciente in lista_pacientes) #Latido más corto entre todos los pacientes
#latido_max=max(paciente.largo_latidos for paciente in lista_pacientes) #Latido más largo entre todos los pacientes

###Para hacer PCA de los latidos promedio
##Calculo el latido promedio en cada canal
#latidos_promedio_c1=[np.mean(paciente.matriz_latidos_c1, axis=0) for paciente in lista_pacientes]
#latidos_promedio_c2=[np.mean(paciente.matriz_latidos_c2, axis=0) for paciente in lista_pacientes]
#
##Recorto las matrices a la cantidad menor de columnas
#for i, mat in enumerate(latidos_promedio_c1):
#    dif=(len(mat)-latido_min)//2
#    latidos_promedio_c1[i]=mat[dif:(len(mat)-dif)]
#    
#for i, mat in enumerate(latidos_promedio_c2):
#    dif=(len(mat)-latido_min)//2
#    latidos_promedio_c2[i]=mat[dif:(len(mat)-dif)]
#
#
####PCA
##http://scikit-learn.org/stable/modules/generated/sklearn.decomposition.PCA.html
##http://scikit-learn.org/stable/modules/generated/sklearn.cluster.KMeans.html
#
#pca = PCA(n_components=2)
#
#pca_c1=pca.fit_transform(latidos_promedio_c1)
#pca_c2=pca.fit_transform(latidos_promedio_c2)
#
#cant_pacientes=len(latidos_promedio_c1)
#rango_colores=np.cumsum(cant_pacientes)
#
#colores=[]
#for paciente in lista_pacientes:
#     try:
#         float(paciente.nombre)
#         colores.append('r')
#     except ValueError:
#         colores.append('k')
#
##plot es más eficiente que scatter para muchos datos
##https://jakevdp.github.io/PythonDataScienceHandbook/04.02-simple-scatter-plots.html#plot-Versus-scatter:-A-Note-on-Efficiency
#marcadores = ['o', 'x', '+', 'v', '^', '<', '>', 's', 'D']
#ciclo_marcadores = cycle(marcadores)
##colors = iter(cm.rainbow(np.linspace(0, 1, cant_pacientes)))
#plt.figure()
#for i, paciente in enumerate(pca_c1):
#    plt.plot(paciente[0], paciente[1], marker=next(ciclo_marcadores), linestyle="None", color=colores[i], label=lista_pacientes[i].nombre)
#plt.legend()
#
#marcadores = ['o', 'x', '+', 'v', '^', '<', '>', 's', 'D']
#ciclo_marcadores = cycle(marcadores)
##colors = iter(cm.rainbow(np.linspace(0, 1, cant_pacientes)))
#plt.figure()
#for i, paciente in enumerate(pca_c2):
#    plt.plot(paciente[0], paciente[1], marker=next(ciclo_marcadores), linestyle="None", color=colores[i], label=lista_pacientes[i].nombre)
#plt.legend()
#
#plt.show()


###Para hacer PCA de todos los latidos
#cant_total_latidos=sum(paciente.matriz_latidos_c1.shape[0] for paciente in lista_pacientes)
#
##Hago una lista con las matrices para alinearlas juntas
#matrices_c1=[paciente.matriz_latidos_c1 for paciente in lista_pacientes]
#matrices_c2=[paciente.matriz_latidos_c2 for paciente in lista_pacientes]
#
##Recorto las matrices a la cantidad menor de columnas
#for i, mat in enumerate(matrices_c1):
#    dif=(mat.shape[1]-latido_min)//2
#    matrices_c1[i]=mat[:,dif:(mat.shape[1]-dif)]
#    
#for i, mat in enumerate(matrices_c2):
#    dif=(mat.shape[1]-latido_min)//2
#    matrices_c2[i]=mat[:,dif:(mat.shape[1]-dif)]
#
##Hago una matriz por canal con los latidos de todos los pacientes
#latidos_c1=np.concatenate(matrices_c1, axis=0)
#latidos_c2=np.concatenate(matrices_c2, axis=0)

###PCA
#http://scikit-learn.org/stable/modules/generated/sklearn.decomposition.PCA.html
#http://scikit-learn.org/stable/modules/generated/sklearn.preprocessing.StandardScaler.html
#http://scikit-learn.org/stable/modules/generated/sklearn.cluster.KMeans.html
#http://scikit-learn.org/stable/auto_examples/preprocessing/plot_scaling_importance.html

#pca = PCA(n_components=2)
#scaler = StandardScaler()
#
#pca_c1=pca.fit_transform(scaler.fit_transform(latidos_c1))
#pca_c2=pca.fit_transform(scaler.fit_transform(latidos_c2))
#
#cant_latidos=[len(paciente.matriz_latidos_c1) for paciente in lista_pacientes]
#rango_colores=np.cumsum(cant_latidos)
#
##Divido el arreglo en arreglos por cada paciente para graficar
#pca_c1_por_paciente=np.split(pca_c1, rango_colores[0:-1])
#pca_c2_por_paciente=np.split(pca_c2, rango_colores[0:-1])
#
#colores=[]
#for paciente in lista_pacientes:
#     try:
#         float(paciente.nombre)
#         colores.append('r')
#     except ValueError:
#         colores.append('k')
#
###plot es más eficiente que scatter para muchos datos
###https://jakevdp.github.io/PythonDataScienceHandbook/04.02-simple-scatter-plots.html#plot-Versus-scatter:-A-Note-on-Efficiency
#marcadores = ['o', 'x', '+', 'v', '^', '<', '>', 's', 'D']
#ciclo_marcadores = cycle(marcadores)
##colors = iter(cm.rainbow(np.linspace(0, 1, len(pca_c1_por_paciente))))
#plt.figure()
#plt.title('PCA_c1 componente 1 vs componente 2')
#plt.xlabel('Componente 1')
#plt.ylabel('Componente 2')
#for i, paciente in enumerate(pca_c1_por_paciente):
#    plt.plot(paciente[:,0], paciente[:,1], marker=next(ciclo_marcadores), linestyle="None", color=colores[i], label=lista_pacientes[i].nombre)
#    #plt.plot(paciente[:,0], paciente[:,1], marker="o", linestyle="None", color=colores[i], label=lista_pacientes[i].nombre)
##plt.legend()
#plt.show()

#ciclo_marcadores = cycle(marcadores)
#plt.figure()
#plt.title('PCA_c2 componente 1 vs componente 2')
#plt.xlabel('Componente 1')
#plt.ylabel('Componente 2')
##colors = iter(cm.rainbow(np.linspace(0, 1, len(pca_c1_por_paciente))))
#for i, paciente in enumerate(pca_c2_por_paciente):
#    plt.plot(paciente[:,0], paciente[:,1], marker=next(ciclo_marcadores), linestyle="None", color=colores[i], label=lista_pacientes[i].nombre)
#plt.legend()
#
#
### PCA_c1 vs PCA_c2 componente 1
#marcadores = ['o', 'x', '+', 'v', '^', '<', '>', 's', 'D']
#ciclo_marcadores = cycle(marcadores)
#plt.figure()
#plt.title('PCA_c1 vs PCA_c2 componente 1')
#plt.xlabel('PCA_c1')
#plt.ylabel('PCA_c2')
#for i, paciente in enumerate(pca_c1_por_paciente):
#    plt.plot(pca_c1_por_paciente[i][:,0], pca_c2_por_paciente[i][:,0], marker=next(ciclo_marcadores), linestyle="None", color=colores[i], label=lista_pacientes[i].nombre)
#plt.legend()
##plt.show()
#
### PCA_c1 vs PCA_c2 componente 2
#marcadores = ['o', 'x', '+', 'v', '^', '<', '>', 's', 'D']
#ciclo_marcadores = cycle(marcadores)
#plt.figure()
#plt.title('PCA_c1 vs PCA_c2 componente 2')
#plt.xlabel('PCA_c1')
#plt.ylabel('PCA_c2')
#for i, paciente in enumerate(pca_c1_por_paciente):
#    plt.plot(pca_c1_por_paciente[i][:,1], pca_c2_por_paciente[i][:,1], marker=next(ciclo_marcadores), linestyle="None", color=colores[i], label=lista_pacientes[i].nombre)
#plt.legend()
#plt.show()

#
#kmeans_c1 = KMeans(n_clusters=3, random_state=0).fit(c1_pca)
#kmeans_c2 = KMeans(n_clusters=3, random_state=0).fit(c2_pca)
