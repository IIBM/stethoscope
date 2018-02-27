close all

for i=1:16
    if i==1
        c1=dlmread('Datos/Sergio/Sergio_2018-02-01_16-55-21_c1.txt','',6,0);
        c2=dlmread('Datos/Sergio/Sergio_2018-02-01_16-55-22_c2.txt','',6,0);
    elseif i==2
        c1=dlmread('Datos/Sergio/Sergio_2018-02-01_16-56-15_c1.txt','',6,0);
        c2=dlmread('Datos/Sergio/Sergio_2018-02-01_16-56-16_c2.txt','',6,0);
    elseif i==3
        c1=dlmread('Datos/Sergio/Sergio_2018-02-01_16-57-25_c1.txt','',6,0);
        c2=dlmread('Datos/Sergio/Sergio_2018-02-01_16-57-25_c2.txt','',6,0);
    elseif i==4
        c1=dlmread('Datos/Sergio/Sergio_2018-02-01_16-58-00_c1.txt','',6,0);
        c2=dlmread('Datos/Sergio/Sergio_2018-02-01_16-58-00_c2.txt','',6,0);
    elseif i==5
        c1=dlmread('Datos/Sergio/Sergio_2018-02-01_16-59-34_c1.txt','',6,0);
        c2=dlmread('Datos/Sergio/Sergio_2018-02-01_16-59-34_c2.txt','',6,0);
    elseif i==6
        c1=dlmread('Datos/Sergio/Sergio_2018-02-01_17-00-48_c1.txt','',6,0);
        c2=dlmread('Datos/Sergio/Sergio_2018-02-01_17-00-48_c2.txt','',6,0);
    elseif i==7
        c1=dlmread('Datos/Sergio/Sergio_2018-02-01_17-02-22_c1.txt','',6,0);
        c2=dlmread('Datos/Sergio/Sergio_2018-02-01_17-02-22_c2.txt','',6,0);
    elseif i==8
        c1=dlmread('Datos/Sergio/Sergio_2018-02-01_17-03-27_c1.txt','',6,0);
        c2=dlmread('Datos/Sergio/Sergio_2018-02-01_17-03-27_c2.txt','',6,0);
    elseif i==9
        c1=dlmread('Datos/Sergio/Sergio_2018-02-01_17-06-01_c1.txt','',6,0);
        c2=dlmread('Datos/Sergio/Sergio_2018-02-01_17-06-01_c2.txt','',6,0);
    elseif i==10
        c1=dlmread('Datos/Sergio/Sergio_2018-02-01_17-07-04_c1.txt','',6,0);
        c2=dlmread('Datos/Sergio/Sergio_2018-02-01_17-07-04_c2.txt','',6,0);
    elseif i==11
        c1=dlmread('Datos/Sergio/Sergio_2018-02-01_17-07-48_c1.txt','',6,0);
        c2=dlmread('Datos/Sergio/Sergio_2018-02-01_17-07-48_c2.txt','',6,0);
    elseif i==12
        c1=dlmread('Datos/Sergio/Sergio_2018-02-01_17-09-05_c1.txt','',6,0);
        c2=dlmread('Datos/Sergio/Sergio_2018-02-01_17-09-05_c2.txt','',6,0);
    elseif i==13
        c1=dlmread('Datos/Sergio/Sergio_2018-02-01_17-09-44_c1.txt','',6,0);
        c2=dlmread('Datos/Sergio/Sergio_2018-02-01_17-09-44_c2.txt','',6,0);
    elseif i==14
        c1=dlmread('Datos/Sergio/Sergio_2018-02-01_17-10-27_c1.txt','',6,0);
        c2=dlmread('Datos/Sergio/Sergio_2018-02-01_17-10-27_c2.txt','',6,0);
    elseif i==15
        c1=dlmread('Datos/Sergio/Sergio_2018-02-01_17-11-14_c1.txt','',6,0);
        c2=dlmread('Datos/Sergio/Sergio_2018-02-01_17-11-14_c2.txt','',6,0);
    elseif i==16
        c1=dlmread('Datos/Sergio/Sergio_2018-02-01_17-11-49_c1.txt','',6,0);
        c2=dlmread('Datos/Sergio/Sergio_2018-02-01_17-11-49_c2.txt','',6,0);
    end

    % --- Genero los nombres de los archivos y títulos
    titulo_trazado=strcat('Trazado',32,num2str(i,'%02d')); %32: caracter de espacio ASCII
    archivo_trazado=strcat('Img/trazado',num2str(i,'%02d'));
    %archivo_trazado=strcat('trazado',num2str(i,'%02d'));

    titulo_vecto=strcat('Vecto',32,num2str(i,'%02d')); %32: caracter de espacio ASCII
    archivo_vecto=strcat('Img/vecto',num2str(i,'%02d'));
    %archivo_vecto=strcat('vecto',num2str(i,'%02d'));


    X1=1000;
    X2=2000;

    % --- Para el filtro adaptado de linea de base
    fc = 0.5; %Frecuencia de corte del filtro
    wc = 2*pi*fc;%7;
    Fs=250; %Frecuencia de muestreo del ADS1292
    coswc = cos(wc * 2*pi/Fs);
    p = [1 -2*coswc (-3+4*coswc)];
    beta12 = roots(p);
    alfa12 = 1 - beta12;
    alfa = alfa12(2);
    %w1 = randn;
    %w2 = randn;

    pos_grafico_c1=[32 307 450 225];
    pos_grafico_c2=[32 30 450 225];
    pos_grafico_vecto=[557 80 401 401];
     
    %c1=[c1((cant_muestras/2)+1:end) c1aux];
    %c2=[c2((cant_muestras/2)+1:end) c2aux];        

    c1_50Hz=moving_average_50hz(c1, 250);
    c2_50Hz=moving_average_50hz(c2, 250);

    c1hp=hp_adaptado(c1_50Hz, alfa);
    c2hp=hp_adaptado(c2_50Hz, alfa);

    canal1=c1hp';
    canal2=c2hp';

    L1=max(max(abs(canal1(X1:X2)), abs(canal2(X1:X2))));
    L1=L1*1.1;

    %figure
    %    subplot(2,1,1)
    %    plot(canal1,'linewidth',1)
    %    %ylim([-L1 L1])
    %    ylim([-1e-3 1e-3])
    %    xlim([X1 X2])
    %    set(gca,'xtick',X1:50:X2,'xticklabel',0:0.2:4)
    %    xlabel('Tiempo [s]')
    %    ylabel('Amplitud [V]')
    %    grid on
    %
    %    %title(titulo_trazado)
    %    title('Canal 1')
    %    subplot(2,1,2)
    %    plot(canal2,'linewidth',1)
    %    %ylim([-L1 L1])
    %    ylim([-1e-3 1e-3])
    %    xlim([X1 X2])
    %    set(gca,'xtick',X1:50:X2,'xticklabel',0:0.2:4)
    %    xlabel('Tiempo [s]')
    %    ylabel('Amplitud [V]')
    %    grid on
    %    title('Canal 2')
    %    print(archivo_trazado,'-dpdf')

    figure
        plot(canal1(X2-250:X2),canal2(X2-250:X2))
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
   
end