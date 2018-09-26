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

narginchk(5,5);

arg_list=argv();

archivo_canal_1=arg_list{1};
archivo_canal_2=arg_list{2};
inicio=arg_list{3};
fin=arg_list{4};
directorio_graficos=arg_list{5};

c1=dlmread(archivo_canal_1,'',6,0); %Los primeros 6 datos son la fecha y hora del registro
c2=dlmread(archivo_canal_2,'',6,0); %Los primeros 6 datos son la fecha y hora del registro

pos=regexp(archivo_canal_1, '[_.]', 'split'){end-1}; %Encuentra la posicion donde se hizo el registro
                                                     %en el nombre del archivo

% --- Genero los nombres de los archivos y títulos
titulo_trazado=cstrcat('Trazado ',num2str(pos));
archivo_trazado=strcat(directorio_graficos, '/trazado',pos);
%archivo_trazado=strcat(directorio_graficos, '/trazado',num2str(str2num(pos),'%02d'));
%archivo_trazado=strcat('trazado',num2str(pos,'%02d'));

titulo_vecto=cstrcat('Vecto ',num2str(pos));
archivo_vecto=strcat(directorio_graficos, '/vecto',pos);
%archivo_vecto=strcat(directorio_graficos, '/vecto',num2str(str2num(pos),'%02d'));
%archivo_vecto=strcat('vecto',num2str(pos,'%02d'));

SPS=250; %Muestras por segundo

% --- Para el filtro adaptado de linea de base
fc = 0.5; %Frecuencia de corte del filtro
wc = 2*pi*fc;%7;
Fs=250; %Frecuencia de muestreo del ADS1292
coswc = cos(wc * 2*pi/Fs);
p = [1 -2*coswc (-3+4*coswc)];
beta12 = roots(p);
alfa12 = 1 - beta12;
alfa = alfa12(2);


c1_50Hz=moving_average_50hz(c1, 250);
c2_50Hz=moving_average_50hz(c2, 250);

c1hp=hp_adaptado(c1_50Hz, alfa);
c2hp=hp_adaptado(c2_50Hz, alfa);

canal1=c1hp';
canal2=c2hp';

X1=floor(str2num(inicio)*SPS)+100; %Sumo 100 para saltear el principio de la señal porque queda deformada por el filtro
if ( (strcmp(fin, "fin")) || (str2num(fin)>length(canal1)) )
    X2=length(canal1);
else
    X2=floor(str2num(fin)*SPS)+100;
endif

largo_grafico=5.08*((X2-X1)/250);

label_x=0:0.2:(X2-X1)/250;

L1=max(max(abs(canal1(X1:X2)), abs(canal2(X1:X2))));
L1=L1*1.1;

figure('visible','off')
    set(gcf,'PaperPositionMode','auto','units','centimeters','position',[0,0,largo_grafico,20], 'papersize',[largo_grafico, 20])
    subplot(2,1,1)
    plot(canal1,'linewidth',1)
    ylim([-L1 L1])
    xlim([X1 X2])
    set(gca,'xtick',X1:50:X2,'xticklabel',label_x,'fontsize',6)
    xlabel('Tiempo [s]')
    ylabel('Amplitud [V]')
    grid on
    title(titulo_trazado)
    %title('Canal 1')
    
    subplot(2,1,2)
    plot(canal2,'linewidth',1)
    ylim([-L1 L1])
    xlim([X1 X2])
    set(gca,'xtick',X1:50:X2,'xticklabel',label_x,'fontsize',6)
    xlabel('Tiempo [s]')
    ylabel('Amplitud [V]')
    grid on
    %title('Canal 2')
    print(archivo_trazado,'-dpdf')

escala_flechas=0;
figure('visible','off')
    hold on
    if((X2-X1)>SPS)
        %Si hay más muestras que 1 segundo, grafica el vecto del último segundo
        c1dif=diff(canal1(X2-SPS:X2));
        c2dif=diff(canal2(X2-SPS:X2));

        quiver(canal1(X2-SPS:X2-1),canal2(X2-SPS:X2-1),c1dif,c2dif,escala_flechas,'linewidth',1)
        %plot(canal1(X2-SPS:X2),canal2(X2-SPS:X2),'color','b','LineStyle',':','linewidth',1)
    else
        %Si no, grafica el vecto del rango que se pasó
        c1dif=diff(canal1(X1:X2));
        c2dif=diff(canal2(X1:X2));

        quiver(canal1(X1:X2-1),canal2(X1:X2-1),c1dif,c2dif,escala_flechas,'linewidth',1)
        %plot(canal1(X1:X2),canal2(X1:X2),'color','b','LineStyle',':','linewidth',1)
    endif
    xlim([-L1 L1])
    ylim([-L1 L1])
    set(gca,'Ydir','reverse')
    xlabel('Amplitud [V]')
    ylabel('Amplitud [V]')
    xL = xlim;
    yL = ylim;
    line(xL, [0 0],'color','k','LineStyle',':','linewidth',1) %x-axis
    line([0 0], yL,'color','k','LineStyle',':','linewidth',1) %y-axis

    title(titulo_vecto)
    %title('Vectorcardiograma')
    print(archivo_vecto,'-dpdf')


 
