#! /usr/bin/python3

import sys, os

from IPython.display import display
import matplotlib.pyplot as plt
#matplotlib inline
import numpy as np
import shutil

import wfdb
from wfdb import processing

registro = np.genfromtxt(sys.argv[1], delimiter=',') # Cargo el archivo con los registros de una posición
canal = int(sys.argv[2]) # Cargo el canal que voy a detectar

#registro = np.genfromtxt('../Datos/Martín-Mello-Teggia/filt/Martín-Mello-Teggia_01_filt.txt', delimiter=',') # Cargo el archivo con los registros de una posición
#canal = 0 # Cargo el canal que voy a detectar

#ganancia=(2.42/3/((2^23)-1))
Fs=250 #Frecuencia de muestreo

wfdb.wrsamp('prueba', fs = Fs, units = ['V','V'], sig_name = ['C1', 'C2'], p_signal=registro, fmt=['16', '16']) #

ecg = wfdb.rdrecord('prueba')
#wfdb.plot_wfdb(ecg)

config=wfdb.processing.XQRS.Conf(hr_init=75, hr_max=200, hr_min=25, qrs_width=0.1, qrs_thr_init=2, qrs_thr_min=0, ref_period=0.2, t_inspect_period=0.36)

sig, fields = wfdb.rdsamp('prueba', channels=[canal])

n_sig=wfdb.processing.normalize_bound(sig, lb=0, ub=1) #Normalizo la señal entre 0 y 1

qrs_inds = processing.xqrs_detect(sig=n_sig[:,0], fs=fields['fs'],sampfrom=50,conf=config)
#qrs_inds = processing.xqrs_detect(sig=sig[:,0], fs=fields['fs'],sampfrom=50,conf=config)

#Corrijo los qrs detectados para que coincidan con los picos
search_radius = int(fields['fs'] * 60 / config.hr_max)
corrected_peak_inds = processing.correct_peaks(sig[:, 0], peak_inds=qrs_inds, search_radius=search_radius, smooth_window_size=150)

#wfdb.plot_items(signal=n_sig, ann_samp=[qrs_inds])
wfdb.plot_items(signal=sig, ann_samp=[qrs_inds])
wfdb.plot_items(signal=sig, ann_samp=[corrected_peak_inds])

##Separo los latidos
delay = round(0.1/(1/Fs))
M = corrected_peak_inds.size
RR = np.diff(corrected_peak_inds) #Vector de intervalos RR
min_RR=np.min(RR) #Latido más corto
matriz_latidos_c1 = np.zeros((M,min_RR)) #Matriz para guardar los latidos por filas
matriz_latidos_c2= np.zeros((M,min_RR)) #Matriz para guardar los latidos por filas

for m in range(0,M):
    matriz_latidos_c1[m]=ecg.p_signal[:,0][corrected_peak_inds[0]-delay:corrected_peak_inds[0]+min_RR-delay]
    matriz_latidos_c2[m]=ecg.p_signal[:,1][corrected_peak_inds[0]-delay:corrected_peak_inds[0]+min_RR-delay]

latido_promedio_c1=np.mean(matriz_latidos_c1, axis=0)
latido_promedio_c2=np.mean(matriz_latidos_c2, axis=0)
#wfdb.plot_wfdb(registro)
