#! /usr/bin/python3

from IPython.display import display
import numpy as np

import pickle #Para persistencia de objetos

class Paciente(object):
    def __init__(self, nombre=None, matriz_latidos_c1=None, matriz_latidos_c2=None, largo_latidos=None, patologia=None):
        self.nombre=nombre
        self.matriz_latidos_c1=matriz_latidos_c1
        self.matriz_latidos_c2=matriz_latidos_c2
        self.largo_latidos=largo_latidos
        self.patologia=patologia

lista_pacientes=[]


nombres = {
    'Javier Puenzo': ["C1_Javier Puenzo"],
    'Fabricio Alcalde': ["C2_Fabricio Alcalde"],
    'Matias Stingl': ["C3_Matias Stingl"],
    'Ezequiel Pecker': ["C4_Ezequiel Pecker"],
    'Roger Mion': ["C5_Roger Mion"],
    'Maximiliano Torre': ["C6_Maximiliano Torre"],
    'Martín Mello Teggia': ["C7_Martín Mello Teggia"],
    'Federico Nuñez': ["C8_Federico Nuñez"],
    'Mateo Martinez': ["C9_Mateo Martinez"],
    'Joaquín Ulloa': ["C10_Joaquín Ulloa"],
    'control 12': ["C12"],
    '1': ["P1"],
    '2': ["P2"],
    '3': ["P3"],
    '4': ["P4"],
    '5': ["P5"],
    '6': ["P6"],
    '7': ["P7"],
    '8': ["P8"],
    '9': ["P9"],
    '10': ["P10"],
    '11': ["P11"],
    '12': ["P12"],
    '13': ["P13"],
    '14': ["P14"],
    '15': ["P15"],
    '16': ["P16"],
    '17': ["P17"],
    '18': ["P18"]
}

#posicion = 1
for i in range(1,19):
    print(i)
    posicion=str(i).zfill(2) #Lo paso a cadena y le agrego ceros hasta completar 2 dígitos

    nombre_archivo = "paciente_pos"+posicion+".obj"
    archivo_pacientes = open(nombre_archivo, "rb")
    lista_pacientes=pickle.load(archivo_pacientes)
    archivo_pacientes.close()

    for paciente in lista_pacientes:
        paciente.nombre = ''.join(nombres.get(paciente.nombre)) #Para que me quede un string

    archivo_pacientes = open(nombre_archivo, "wb")
    pickle.dump(lista_pacientes, archivo_pacientes)
