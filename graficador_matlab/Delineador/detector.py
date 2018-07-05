#! /usr/bin/python3

import sys, os

import importlib

from IPython.display import display
import matplotlib.pyplot as plt
#matplotlib inline
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

yourpath = 'path'

import os
#for root, dirs, files in os.walk(yourpath, topdown=False):
#    for name in files: #Lista todos los archivos dentro de los directorios dentro de root
#        print(os.path.join(root, name))
#    for name in dirs: #Lista los directorios dentro de root
#        print(os.path.join(root, name))

#for nombre in glob.glob(os.path.join(directorio_datos+'**/*01*'), recursive=True):
#    print (nombre)

registro = np.genfromtxt(sys.argv[1], delimiter=',') # Cargo el archivo con los registros de una posición
#registro = np.genfromtxt(sys.argv[1], delimiter=',',skip_header=20) # Para algunos registros hay que borrar unos datos más
registro=registro*1000
canal = int(sys.argv[2]) # Cargo el canal que voy a detectar

#registro = np.genfromtxt('../Datos/Martín-Mello-Teggia/filt/Martín-Mello-Teggia_01_filt.txt', delimiter=',') # Cargo el archivo con los registros de una posición
#canal = 0 # Cargo el canal que voy a detectar

ecg, qrs_inds = detectar_qrs(registro, canal)

matriz_latidos_c1 = separar_latidos(ecg.p_signal[:,0], qrs_inds)
matriz_latidos_c2 = separar_latidos(ecg.p_signal[:,1], qrs_inds)

#Corrijo la escala
matriz_latidos_c1=matriz_latidos_c1/1000
matriz_latidos_c2=matriz_latidos_c2/1000

#Calculo el latido promedio en cada canal
latido_promedio_c1=np.mean(matriz_latidos_c1, axis=0)
latido_promedio_c2=np.mean(matriz_latidos_c2, axis=0)
