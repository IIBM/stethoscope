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
    'Javier Puenzo': ["V1_Javier Puenzo"],
    'Matías Stingl': ["V2_Matías Stingl"],
    'Fabricio Alcalde': ["V3_Fabricio Alcalde"],
    'Ezequiel Pecker': ["V4_Ezequiel Pecker"],
    'Roger Mion': ["V5_Roger Mion"],
    'Maximiliano Torre': ["V6_Maximiliano Torre"],
    'Martín Mello Teggia': ["V7_Martín Mello Teggia"],
    'Federico Nuñez': ["V8_Federico Nuñez"],
    'Joaquín Ulloa': ["V9_Joaquín Ulloa"],
    'Mateo Martinez': ["V10_Mateo Martinez"],
    '1': ["H1"],
    '2': ["H2"],
    '3': ["H3"],
    '4': ["H4"],
    '5': ["H5"],
    '6': ["H6"],
    '7': ["H7"],
    '8': ["H8"],
    '9': ["H9"],
    '10': ["H10"],
    '11': ["H11"],
    '12': ["H12"],
    '13': ["H13"],
    '14': ["H14"],
    '15': ["H15"],
    '16': ["H16"],
    '17': ["H17"],
    '18': ["H18"]
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
