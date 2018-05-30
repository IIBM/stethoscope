#! /usr/bin/octave -qf

# Grafica el vecto y los trazados a partir de los archivos de los 2 canales de una medición
# y los guarda en el directorio indicado.
#
# Uso:
#     ./graficar_datos.m archivo_canal_1.txt archivo_canal_2.txt directorio_destino

%printf("%s\n", program_name());
%arg_list=argv();
%for i=1:nargin
%    printf("%s\n", arg_list{i});
%endfor
%printf("\n")

narginchk(3,3);

arg_list=argv();


archivo_canal_1=arg_list{1};
archivo_canal_2=arg_list{2};
directorio_datos=arg_list{3};

c1=dlmread(archivo_canal_1,'',6,0); %Los primeros 6 datos son la fecha y hora del registro
c2=dlmread(archivo_canal_2,'',6,0); %Los primeros 6 datos son la fecha y hora del registro

paciente=regexp(archivo_canal_1, '[/_.]', 'split'){end-5}; %Encuentra el nombre del paciente
pos=regexp(archivo_canal_1, '[_.]', 'split'){end-1}; %Encuentra la posicion donde se hizo el registro
                                                     %en el nombre del archivo

% --- Genero los nombres de los archivos 
nombre_archivo=strcat(directorio_datos,'/',paciente,'_',num2str(str2num(pos),'%02d'),'_filt.txt');


% --- Para el filtro adaptado de linea de base
fc = 0.5; %Frecuencia de corte del filtro
wc = 2*pi*fc;%7;
Fs=250; %Frecuencia de muestreo del ADS1292
coswc = cos(wc * 2*pi/Fs);
p = [1 -2*coswc (-3+4*coswc)];
beta12 = roots(p);
alfa12 = 1 - beta12;
alfa = alfa12(2);

% --- Las paso a los valores digitales nuevamente
c1=c1/(2.42/3/((2^23)-1));
c2=c2/(2.42/3/((2^23)-1));


c1_50Hz=moving_average_50hz(c1, 250);
c2_50Hz=moving_average_50hz(c2, 250);

c1hp=hp_adaptado(c1_50Hz, alfa);
c2hp=hp_adaptado(c2_50Hz, alfa);

registro=[c1hp; c2hp]';

dlmwrite(nombre_archivo,registro);
