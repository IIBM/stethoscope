#! /usr/bin/python3

import sys, os

import imp

from IPython.display import display
import matplotlib.pyplot as plt
#matplotlib inline
import numpy as np
import shutil

import wfdb
from wfdb import processing

from sklearn.decomposition import PCA
from sklearn.cluster import KMeans

from funciones_detector import detectar_qrs, separar_latidos
#if is_changed(funciones_detector):
funciones_detector = imp.reload(funciones_detector)

registro = np.genfromtxt(sys.argv[1], delimiter=',') # Cargo el archivo con los registros de una posición
#registro = np.genfromtxt(sys.argv[1], delimiter=',',skip_header=20) # Para algunos registros hay que borrar unos datos más
registro=registro*1000
canal = int(sys.argv[2]) # Cargo el canal que voy a detectar

#registro = np.genfromtxt('../Datos/Martín-Mello-Teggia/filt/Martín-Mello-Teggia_01_filt.txt', delimiter=',') # Cargo el archivo con los registros de una posición
#canal = 0 # Cargo el canal que voy a detectar

ecg, qrs_inds = detectar_qrs(registro, canal)


