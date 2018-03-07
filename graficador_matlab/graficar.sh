#!/bin/bash

#funcion para mostrar el uso del script
function mostrar_uso {
    echo "USO:"
    echo "    ./graficar.sh directorio"
    echo "      -h muestra la ayuda"
}

#funcion para mostrar la ayuda del script
function mostrar_ayuda {
    echo "Realiza los gráficos de los trazados y vectocardiogramas a partir de los archivos guardados por la interfaz gráfica en un directorio."
    echo "Los gráficos se guardan en /Img/directorio."
    echo "El script graficar_datos.m debe estar en el mismo directorio que este."
    echo ""
    mostrar_uso
}

#verifico que no tenga mas de un argumento, o ninguno
if [ $# -gt 1 ]
then
    echo "Exceso de argumentos"
    mostrar_uso
    exit 1
elif [ $# -eq 0 ]
then
    echo "Faltan argumentos"
    mostrar_uso
    exit 1
fi

#verifico que si tiene un argumento sea el valido
if [ $# -eq 1 ]
then
    if [[ -d $1  ]]
    then
        #leer nombres de archivo
        directorio=$1
        directorio=${directorio%/*} #Le saco la / del final
    elif [ $1 == "-h" ]
    then
        mostrar_ayuda
        exit 0
    else
        echo "Argumento invalido"
        mostrar_uso
        exit 1
    fi
fi

directorio_graficos="Img/$directorio"
mkdir $directorio_graficos

#for archivo in $(find $directorio -type f -name "*c1*")
for archivo in "${directorio}/*c1*"
do
    archivo_c1=${archivo}
    #archivo_c2=${archivo_c1/c1/c2} #Search and replace (http://wiki.bash-hackers.org/syntax/pe#search_and_replace)
    echo $archivo_c1
    #echo $archivo_c2
    
    #Indica la posición que se está graficando
    posicion=${archivo##*_}
    echo "Graficando posicion ${posicion%.*}."
    
    #Llama al script de octave que realiza los gráficos
    ./graficar_datos.m $archivo_c1 $archivo_c2 $directorio_graficos
done

#Genero un pdf con todos los vectos, y otro con todos los trazados
#cd $directorio_graficos
#
#archivo_vectos="vectos_$directorio.pdf"
#archivo_trazados="trazados_$directorio.pdf"
#
#if [ -e $archivo_vectos ]
#then
#    rm $archivo_vectos
#fi
#
#if [ -e $archivo_trazados ]
#then
#    rm $archivo_trazados
#fi
#
#echo "Uniendo pdfs de vectos."
#pdftk vecto*.pdf cat output "aux_$archivo_vectos"
#pdfcrop "aux_$archivo_vectos" $archivo_vectos
#
#echo "Uniendo pdfs de trazados."
#pdftk trazado*.pdf cat output "aux_$archivo_trazados"
#pdfcrop "aux_$archivo_trazados" $archivo_trazados
#
#echo "Eliminando archivos auxiliares."
#rm "aux_$archivo_vectos" 
#rm "aux_$archivo_trazados" 
#
#echo "Listo!"
