#!/bin/bash

#funcion para mostrar el uso del script
function mostrar_uso {
    echo "USO:"
    echo "    ./graficar.sh -d directorio -i inicio -f fin"
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
#if [ $# -gt 6 ]
#then
#    echo "Exceso de argumentos"
#    echo $#
#    mostrar_uso
#    exit 1
#elif [ $# -eq 0 ]
#then
#    echo "Faltan argumentos"
#    mostrar_uso
#    exit 1
#fi

OPTIONS=d:i:f:h
LONGOPTS=dir:,inicio:,fin:,ayuda
exp_numero='^[0-9]+([.][0-9]+)?$' #Expresión regular que coincide con números positivos con coma

#PARSED=$(getopt --options $OPTIONS --name="$0" -- "$@")
#! PARSED=$(getopt --options $OPTIONS --name="$0" -- "$@")
OPTS=$(getopt --options $OPTIONS --longoptions $LONGOPTS --name "$0" -- "$@")
#! PARSED=$(getopt --options=$OPTIONS --longoptions=$LONGOPTS --name "$0" -- "$@")
#if [[ ${PIPESTATUS[0]} -ne 0 ]]; then
#    # e.g. return value is 1
#    #  then getopt has complained about wrong arguments to stdout
#    exit 2
#fi

echo $OPTS
echo "$1"

# read getopt’s output this way to handle the quoting right:
eval set -- "$OPTS"
while true ; do
    case "$1" in
        -d | --directorio )
            if [[ -d "$2"  ]]
            then
                #leer nombres de archivo
                directorio=$2
                directorio=${directorio%/*} #Le saco la / del final
            else
                echo "Error de argumentos: verificar el campo de directorio"
                mostrar_uso
            fi
            shift 2
            ;;
        -i | --inicio )
            if [[ $2 =~ $exp_numero ]] 
            then
                inicio=$2
            else
                echo "Error de argumentos: el valor de inicio debe ser un número positivo"
                mostrar_uso
                break
            fi
            shift 2
            ;;
        -f | --fin )
            if [[ $2 =~ $exp_numero ]] 
            then
                fin=$2
            else
                echo "Error de argumentos: el valor de fin debe ser un número positivo"
                mostrar_uso
                break
            fi
            shift 2
            ;;
        -h )
            echo "entró a h"
            mostrar_uso
            break
            ;;
        -- )
            shift
            break
            ;;
        * )
            echo "Internal error!"
            exit 1
    esac
done

#Veo que inicio no sea mayor a fin
_output=$(echo "$inicio > $fin" | bc)
if [ $_output == "1" ]
then
    echo "inicio debe ser menor a fin"
    mostrar_uso
    exit 1
fi


directorio_graficos="Img/${directorio##*/}"
mkdir $directorio_graficos

for archivo in $(find $directorio -type f -name "*c1*")
#for archivo in "${directorio}/*c1*"
do
    archivo_c1=${archivo}
    archivo_c2=${archivo_c1/c1/c2} #Search and replace (http://wiki.bash-hackers.org/syntax/pe#search_and_replace)
    #echo $archivo_c1
    #echo $archivo_c2
    
    #Indica la posición que se está graficando
    posicion=${archivo##*_}
    echo "Graficando posicion ${posicion%.*}."
    
    #Llama al script de octave que realiza los gráficos
    ./graficar_datos.m $archivo_c1 $archivo_c2 $inicio $fin $directorio_graficos
done

#Genero un pdf con todos los vectos, y otro con todos los trazados
cd $directorio_graficos

archivo_vectos="vectos_${directorio##*/}.pdf"
archivo_trazados="trazados_${directorio##*/}.pdf"

if [ -e $archivo_vectos ]
then
    rm $archivo_vectos
fi

if [ -e $archivo_trazados ]
then
    rm $archivo_trazados
fi

echo "Uniendo pdfs de vectos."
pdftk vecto*.pdf cat output "aux_$archivo_vectos"
pdfcrop "aux_$archivo_vectos" $archivo_vectos

echo "Uniendo pdfs de trazados."
pdftk trazado*.pdf cat output "aux_$archivo_trazados"
pdfcrop "aux_$archivo_trazados" $archivo_trazados

echo "Eliminando archivos auxiliares."
rm "aux_$archivo_vectos" 
rm "aux_$archivo_trazados"
#rm "trazado*.pdf"
#rm "vecto*.pdf"

echo "Listo!"
