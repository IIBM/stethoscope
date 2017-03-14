pkg load instrument-control

clear all
close all

s1 = serial("/dev/ttyUSB0", 38400, 3);

pause(6);

disp('comienzo')

#ch1_temp = cell(10,1);
ch1 = zeros(1, 1000);

#ch2_temp = cell(10,1);
ch2 = zeros(1, 1000);

j=0;

srl_flush(s1);
srl_write(s1, '1'); #El ADS1292 espera un 1 del graficador para empezar a mandar datos
pause(1);

while j<100
    muestra=leer_muestras(s1, 100);
    muestra_ch1 = muestra(1:2:end);
    muestra_ch2 = muestra(2:2:end);

    ch1 = [ch1(length(muestra_ch1+1):end) muestra_ch1];
    ch2 = [ch2(length(muestra_ch2+1):end) muestra_ch2];
    #ch2(end+1) = muestra_ch2;
    #ch1 = cat(1, ch1, ch1_temp{1:10});
    #ch2 = cat(1, ch2, ch2_temp{1:10});
    if kbhit(1) =='q'
        break
    end
    j++;
    #if(!mod(j,10))
    subplot(2,1,1)
        plot(ch1, 'LineWidth', 1)
    subplot(2,1,2)
        plot(ch2, 'LineWidth', 1)

        
    #    pause(0.5)
    #end
endwhile

srl_close(s1)

#    #for i = 1:10
#        #Canal 1
#        muestra=leer_muestra(s1, 2);
#        muestra_ch1 = typecast(flip(muestra), 'uint16');
#        #ch1_temp{i,1} = muestra_ch1;
#        #Canal 2
#        muestra=leer_muestra(s1, 2);
#        muestra_ch2 = typecast(flip(muestra), 'uint16');
#        #ch2_temp{i,1} = muestra_ch2;
#        #pause(0.01)
#    #endfor
