#! /usr/bin/python3

from IPython.display import display
import numpy as np

import importlib

import matplotlib
matplotlib.use('Agg') #Cambio el backend para que no me muestre las imágenes y las guarde directamente
import matplotlib.pyplot as plt
import matplotlib.cm as cm
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

    
for pos in range(1,2):
    lista_control=[]
    lista_bloqueo=[]
    lista_pacientes=[]

    posicion=str(pos).zfill(2) #Lo paso a cadena y le agrego ceros hasta completar 2 dígitos

    nombre_archivo = "paciente_pos"+posicion+".obj"
    archivo_pacientes = open(nombre_archivo, "rb")
    lista_pacientes=pickle.load(archivo_pacientes)
    archivo_pacientes.close()

    for paciente in lista_pacientes: #Si es control lo pone en negro, si no en rojo
        if any ("control" in patologias for patologias in paciente.patologia):
             lista_control.append(paciente)
        elif any ("bloqueo" in patologias for patologias in paciente.patologia):
             lista_bloqueo.append(paciente)

    lista_pacientes = lista_control + lista_bloqueo

    ##def pca_latidos_promedio(lista_pacientes):
    latido_min=min(paciente.largo_latidos for paciente in lista_pacientes) #Latido más corto entre todos los pacientes
    latido_max=max(paciente.largo_latidos for paciente in lista_pacientes) #Latido más largo entre todos los pacientes
    #Calculo el latido promedio en cada canal
    latidos_promedio_c1=[np.mean(paciente.matriz_latidos_c1, axis=0) for paciente in lista_pacientes]
    latidos_promedio_c2=[np.mean(paciente.matriz_latidos_c2, axis=0) for paciente in lista_pacientes]

    #Recorto las matrices a la cantidad menor de columnas
    for i, mat in enumerate(latidos_promedio_c1):
        dif=(len(mat)-latido_min)//2
        latidos_promedio_c1[i]=mat[dif:(len(mat)-dif)]
        
    for i, mat in enumerate(latidos_promedio_c2):
        dif=(len(mat)-latido_min)//2
        latidos_promedio_c2[i]=mat[dif:(len(mat)-dif)]


    ###PCA
    #http://scikit-learn.org/stable/modules/generated/sklearn.decomposition.PCA.html
    #http://scikit-learn.org/stable/modules/generated/sklearn.cluster.KMeans.html

    pca = PCA(n_components=2)
    scaler = StandardScaler()

    pca_c1=pca.fit_transform(scaler.fit_transform(latidos_promedio_c1))
    pca_c2=pca.fit_transform(scaler.fit_transform(latidos_promedio_c2))

    cant_pacientes=len(latidos_promedio_c1)
    rango_colores=np.cumsum(cant_pacientes)

    colores=[]
    for paciente in lista_pacientes: #Si es control lo pone en negro, si no en rojo
        if any ("control" in patologias for patologias in paciente.patologia):
             colores.append('k')
        elif any ("bloqueo" in patologias for patologias in paciente.patologia):
             colores.append('r')
        else:
             colores.append('b')

    #plot es más eficiente que scatter para muchos datos
    #https://jakevdp.github.io/PythonDataScienceHandbook/04.02-simple-scatter-plots.html#plot-Versus-scatter:-A-Note-on-Efficiency
    plt.figure()
    plt.suptitle('Pos '+posicion)
    ### PCA_c1 vs PCA_c2 componente 1
    plt.subplot(221)
    marcadores = ['o', 'x', '+', 'v', '^', '<', '>', 's', 'D']
    ciclo_marcadores = cycle(marcadores)
    #colors = iter(cm.rainbow(np.linspace(0, 1, cant_pacientes)))
    #plt.figure()
    plt.title('PCA_canal1: comp 1 vs comp 2')
    plt.xlabel('Componente 1')
    plt.ylabel('Componente 2')
    for i, paciente in enumerate(pca_c1):
        plt.plot(paciente[0], paciente[1], marker=next(ciclo_marcadores), linestyle="None", color=colores[i], label=lista_pacientes[i].nombre)
    #plt.legend()

    ### PCA_c1 vs PCA_c2 componente 2
    plt.subplot(222)
    marcadores = ['o', 'x', '+', 'v', '^', '<', '>', 's', 'D']
    ciclo_marcadores = cycle(marcadores)
    #colors = iter(cm.rainbow(np.linspace(0, 1, cant_pacientes)))
    #plt.figure()
    plt.title('PCA_canal2: comp 1 vs comp 2')
    plt.xlabel('Componente 1')
    plt.ylabel('Componente 2')
    for i, paciente in enumerate(pca_c2):
        plt.plot(paciente[0], paciente[1], marker=next(ciclo_marcadores), linestyle="None", color=colores[i], label=lista_pacientes[i].nombre.split("_")[0])
    plt.legend(loc="upper left", bbox_to_anchor=(1,1)) #Pone la leyenda fuera del gráfico

    ### PCA_c1 vs PCA_c2 componente 1
    plt.subplot(223)
    marcadores = ['o', 'x', '+', 'v', '^', '<', '>', 's', 'D']
    ciclo_marcadores = cycle(marcadores)
    #plt.figure()
    plt.title('PCA_c1 vs PCA_c2: comp 1')
    plt.xlabel('PCA_c1')
    plt.ylabel('PCA_c2')
    for i, paciente in enumerate(pca_c1):
        plt.plot(pca_c1[i,0], pca_c2[i,0], marker=next(ciclo_marcadores), linestyle="None", color=colores[i], label=lista_pacientes[i].nombre)
    #plt.legend()

    ### PCA_c1 vs PCA_c2 componente 2
    plt.subplot(224)
    marcadores = ['o', 'x', '+', 'v', '^', '<', '>', 's', 'D']
    ciclo_marcadores = cycle(marcadores)
    #plt.figure()
    plt.title('PCA_c1 vs PCA_c2: comp 1')
    plt.xlabel('PCA_c1')
    plt.ylabel('PCA_c2')
    for i, paciente in enumerate(pca_c1):
        plt.plot(pca_c1[i,1], pca_c2[i,1], marker=next(ciclo_marcadores), linestyle="None", color=colores[i], label=lista_pacientes[i].nombre)
    #plt.legend()

    
    plt.tight_layout()
    plt.savefig("Graficos/PCA_pos_"+posicion, format="pdf", bbox_inches='tight')
    #plt.ion()
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
#
###PCA
###http://scikit-learn.org/stable/modules/generated/sklearn.decomposition.PCA.html
###http://scikit-learn.org/stable/modules/generated/sklearn.preprocessing.StandardScaler.html
###http://scikit-learn.org/stable/modules/generated/sklearn.cluster.KMeans.html
###http://scikit-learn.org/stable/auto_examples/preprocessing/plot_scaling_importance.html
#
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
#
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

#paciente=[paciente for paciente in lista_pacientes if "18" in paciente.nombre]
##Calculo el latido promedio en cada canal
#latido_promedio_c1=np.mean(paciente[0].matriz_latidos_c1, axis=0)
#latido_promedio_c2=np.mean(paciente[0].matriz_latidos_c2, axis=0)
##Límite para los ejes
#lim=np.max([np.max(np.abs(latido_promedio_c1)),np.max(np.abs(latido_promedio_c2))])
#lim=lim*1.1;
#
#### Latidos cortados superpuestos y promedio
#plt.figure()
#plt.plot(paciente[0].matriz_latidos_c1.T,'--')
##plt.plot(lista_pacientes[0].matriz_latidos_c1.T,'--')
#plt.plot(latido_promedio_c1,'k')
#plt.title('Canal 1')
#plt.xlabel('Muestras')
#plt.ylabel('Tensión [V]')
#plt.ylim(-lim, lim)
#plt.grid(True)
##ax.set(ylim=[-lim, lim], xlabel='Muestras', ylabel='Tensión[V]', title='Canal1')
##plt.axvline(x=matriz_latidos_c2.shape[1]//2, color='r')
#
#plt.figure()
#plt.plot(paciente[0].matriz_latidos_c2.T,'--')
##plt.plot(lista_pacientes[0].matriz_latidos_c2.T,'--')
#plt.plot(latido_promedio_c2,'k')
#plt.title('Canal 2')
#plt.xlabel('Muestras')
#plt.ylabel('Tensión [V]')
#plt.ylim(-lim, lim)
#plt.grid(True)
##ax.set(ylim=[-lim, lim], xlabel='Muestras', ylabel='Tensión[V]', title='Canal1')
##plt.axvline(x=matriz_latidos_c2.shape[1]//2, color='r')
#plt.ion()
#plt.show()



### Vecto
#c1d=np.diff(latido_promedio_c1)
#c1d=np.append(c1d,latido_promedio_c1[-1]-latido_promedio_c1[0])
##c1d=latido_promedio_c1[1:]-latido_promedio_c1[:-1]
#c2d=np.diff(latido_promedio_c2)
#c2d=np.append(c2d,latido_promedio_c2[-1]-latido_promedio_c2[0])
##c2d=latido_promedio_c2[1:]-latido_promedio_c2[:-1]
##
#plt.figure()
#plt.title('Vecto')
#plt.xlabel('Tensión [V]')
#plt.ylabel('Tensión [V]')
##plt.plot(latido_promedio_c1,latido_promedio_c2)
#plt.quiver(latido_promedio_c1,latido_promedio_c2, c1d, c2d, scale_units='xy', angles='xy', scale=1)
#plt.xlim(-lim, lim)
#plt.ylim(lim, -lim)
#plt.grid(True)
#wfdb.plot_wfdb(registro)
#plt.show()