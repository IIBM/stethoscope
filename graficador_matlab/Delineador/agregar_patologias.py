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


patologias = {
    'Ezequiel Pecker': ["control"],
    'Fabricio Alcalde': ["control"],
    'Federico Nuñez': ["control"],
    'Javier Puenzo': ["control"],
    'Joaquín Ulloa': ["control"],
    'Martín Mello Teggia': ["control"],
    'Mateo Martinez': ["control"],
    'Matias Stingl': ["control"],
    'Maximiliano Torre': ["control"],
    'Roger Mion': ["control"],
    'control 12': ["control"],
    '1': ["insuficiencia cardíaca", "bloqueo de rama derecha", "hemibloqueo anterior externo"],
    '2': ["enfermedad de nodo sinusal", "marcapasos implantado"],
    '3': ["hipertrofia ventricular", "miocardio trabiculado", "insuficiencia cardíaca", "signo de sobrecarga ventricular izquierda"],
    '4': ["taquicardia ventricular", "infarto previo", "coronaria derecha y descendiente anterior", "fibrilación auricular", "bloqueo de rama derecha"],
    '5': ["enfermedad de sistema de conducción", "marcapasos implantado", "bloqueo de rama izquierda", "fibrilación auricular"],
    '6': ["síncope", "bloqueo completo de rama derecha"],
    '7': ["embarazada 32 semanas"],
    '8': ["bloqueo completo rama derecha", "patología renal", "antecedentes coronarios (2iam)"],
    '9': ["taquicardia ventricular", "bloqueo completo de rama derecha", "secuela septal", "miocardiopatía dilatada"],
    '10': ["iam de cara anterior", "cest (con st elevado)", "bloqueo completo de rama derecha"],
    '11': ["diagnóstico de sindrome de bayes"],
    '12': ["bloqueo completo de rama izquierda", "bloqueo ab de 1er grado", "4 episodios de síncope"],
    '13': ["iam diafragmático de 5 días de evolución", "enfermedad de 3 vasos csg"],
    '14': ["epoc", "bcri", "aleteo auricular", "secuela en cara anterior"],
    '15': ["endocarditis protesica de un mes de evolucion al año de la cirugía eco t esof sin vegetaciones"],
    '16': ["secuela anteroseptal", "insuficiencia cardíaca isquémica o valvular", "estenosis aórtica", "antecedentes de arritmia"],
    '17': ["falta de progresión de r en cara anterior", "p negetiva en v1", "insuficiencia cardíaca isquémica"],
    '18': ["insuficiencia cardíaca con FEY conservada isquemiconecrotica y valvular", "estenosis aortica severa"]
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
        paciente.patologia = patologias.get(paciente.nombre)

    archivo_pacientes = open(nombre_archivo, "wb")
    pickle.dump(lista_pacientes, archivo_pacientes)
