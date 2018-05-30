#!/bin/bash

#funcion para mostrar el uso del script
function mostrar_uso {
    echo "USO:"
    echo "    ./filtrar.sh directorio"
    echo "      -h muestra la ayuda"
}

#funcion para mostrar la ayuda del script
function mostrar_ayuda {
    echo "Filtra los registros tomados y guarda los 2 canales en un archivo por cada posición"
    echo "Los datos se guardan en <nombre_paciente>/filt"
    echo "El script filtrar_registros.m debe estar en el mismo directorio que este."
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

directorio_datos="${directorio}/filt"
#directorio_datos="${directorio##*/}/filt"
mkdir $directorio_datos

for archivo in $(find $directorio -type f -name "*c1*")
#for archivo in "${directorio}/*c1*"
do
    archivo_c1=${archivo}
    archivo_c2=${archivo_c1/c1/c2} #Search and replace (http://wiki.bash-hackers.org/syntax/pe#search_and_replace)
    #echo $archivo_c1
    #echo $archivo_c2
    
    #Indica la posición que se está graficando
    posicion=${archivo##*_}
    echo "Filtrando posicion ${posicion%.*}."
    
    #Llama al script de octave que realiza los gráficos
    ./filtrar_registros.m $archivo_c1 $archivo_c2 $directorio_datos
done

echo "Listo!"
