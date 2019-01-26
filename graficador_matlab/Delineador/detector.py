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
import pickle #Para persistencia de objetos

import wfdb
from wfdb import processing

from sklearn.decomposition import PCA
from sklearn.preprocessing import StandardScaler
from sklearn.cluster import KMeans

import funciones_detector
importlib.reload(funciones_detector) #Recargo el módulo para que si cambio algo se actualice
from funciones_detector import detectar_qrs, separar_latidos, analizar_registros_procesados, guardar_no_detectado, graficar_registro, modificar_anotacion

directorio_origen_datos = '../Datos_filtrados/'
directorio_registros_procesados = './Registros/'
directorio_registros_procesados_ok = './Registros/ok/'

class Paciente(object):
    def __init__(self, nombre=None, matriz_latidos_c1=None, matriz_latidos_c2=None, largo_latidos=None):
        self.nombre=nombre
        self.matriz_latidos_c1=matriz_latidos_c1
        self.matriz_latidos_c2=matriz_latidos_c2
        self.largo_latidos=largo_latidos

lista_pacientes=[]

###Detectar desde el directorio de datos filtrados
#archivos=[arch for arch in glob.glob(os.path.join(directorio_origen_datos+'*/*.txt'), recursive=True)]
#archivos.sort()
#for archivo in archivos:
#for archivo in glob.glob(os.path.join(directorio_origen_datos+'*/*03*.txt'), recursive=True):
#    print("\n"+archivo)
#    
#    detectar_qrs(archivo, directorio_registros_procesados)

###Detectar del archivo de "no_detectados"
#aux_arch = open("no_detectados.txt", "r")
#no_detectados = aux_arch.read().splitlines()
#aux_arch.close()
#open("no_detectados.txt", "w").close() #Borro el contenido del archivo
#for archivo in no_detectados:
#    print("\n"+archivo)
#    
#    #detectar_qrs(archivo, directorio_registros_procesados, canal=1, umbral=0.1)
#    detectar_qrs(archivo, directorio_registros_procesados, umbral=0.01)
#    #detectar_qrs(archivo, directorio_registros_procesados)

###Separo latidos de los archivos procesados

for i in range(1, 19):
    
    #print(i)
    posicion=str(i).zfill(2) #Lo paso a cadena y le agrego ceros hasta completar 2 dígitos
    archivos = [arch for arch in os.listdir(directorio_registros_procesados_ok)]
    archivos = [os.path.splitext(aux)[0] for aux in archivos if posicion+".ann" in aux]
    archivos.sort()

    for archivo in archivos:
        print("\n"+archivo)
        sig, fields = wfdb.rdsamp(os.path.join(directorio_registros_procesados_ok, archivo))
        anotaciones=wfdb.rdann(os.path.join(directorio_registros_procesados_ok, archivo),"ann")
        matriz_latidos_c1, largo_latidos = separar_latidos(sig[:,0], anotaciones.sample)
        matriz_latidos_c2, largo_latidos = separar_latidos(sig[:,1], anotaciones.sample)

        #Corrijo la escala que cambié en "detectar_qrs" 
        matriz_latidos_c1=matriz_latidos_c1/1000
        matriz_latidos_c2=matriz_latidos_c2/1000
            
        nombre=archivo.split("_")[0]
        nombre=nombre.replace("-"," ")
        #pos_r=matriz_latidos_c1.shape[1]//2#calculo pos_r
        lista_pacientes.append(Paciente(nombre, matriz_latidos_c1, matriz_latidos_c2, largo_latidos))

    nombre_archivo = "paciente_pos"+posicion+".obj"
    archivo_pacientes = open(nombre_archivo, "wb")
    pickle.dump(lista_pacientes, archivo_pacientes)
    
    lista_pacientes=[]


#
#kmeans_c1 = KMeans(n_clusters=3, random_state=0).fit(c1_pca)
#kmeans_c2 = KMeans(n_clusters=3, random_state=0).fit(c2_pca)
