clear all
close all

%load control_physionet.mat
%%load bloqueo_physionet.mat
%
%%a=a-280;        %%% offset impuesto por inkscape cuando se relevaron los puntos
%%aux(:,1)=interp(a(:,1),10);
%%aux(:,2)=interp(a(:,2),10);
%%aux(:,3)=interp(a(:,3),10);
%%
%%a=aux;
%
%a=a(3200:4100,:); %Elijo un latido
%%a=a(4600:5500,:); %Elijo un latido

%Saca las precordiales de los ECGs tomados de manera convencional con el ECGView

%[RegistrosECG]=ECGFileOpen ('ECG_Files/04/04_08.ECG');
[RegistrosECG]=ECGFileOpen ('ECG_Files/05/05_12.ECG');
%[RegistrosECG]=ECGFileOpen ('ECG_Files/06/06_09.ECG');
%[RegistrosECG]=ECGFileOpen ('ECG_Files/07/07_14.ECG');
%[RegistrosECG]=ECGFileOpen ('ECG_Files/08/08_16.ECG');
%[RegistrosECG]=ECGFileOpen ('ECG_Files/09/09_17.ECG');
%[RegistrosECG]=ECGFileOpen ('ECG_Files/10/10_20.ECG');
%[RegistrosECG]=ECGFileOpen ('ECG_Files/11/11_22.ECG');
%[RegistrosECG]=ECGFileOpen ('ECG_Files/13/13_25.ECG');
%[RegistrosECG]=ECGFileOpen ('ECG_Files/14/14_28.ECG');

a=RegistrosECG.RowDATA*RegistrosECG.Pendiente;

%plot(a(:,7:12)) %Grafico las precordiales para encontrar el latido donde estén más alineadas

%b=a(2550:2850,:); %Tomo un latido después de haber graficado
b=a(1980:2280,:); %Tomo un latido después de haber graficado
%b=a(4575:4875,:); %Tomo un latido después de haber graficado
%b=a(1400:1700,:); %Tomo un latido después de haber graficado
%b=a(2125:2425,:); %Tomo un latido después de haber graficado
%b=a(3275:3575,:); %Tomo un latido después de haber graficado
%b=a(1510:1810,:); %Tomo un latido después de haber graficado
%b=a(1925:2225,:); %Tomo un latido después de haber graficado
%b=a(3100:3400,:); %Tomo un latido después de haber graficado
%b=a(1820:2120,:); %Tomo un latido después de haber graficado

%Reordeno las columnas para que quede [V1 V2 V3 V4 V5 V6 I II]
ecg=[b(:,3:end), b(:,1:2)];


%Inversa de la matriz de Dower.
%v(n) = Ts(n)
%donde s(n)=[V1(n) V2(n) V3(n) V4(n) V5(n) V6(n) I(n) II(n)] y v(n)=[X(n) Y (n) Z(n)]^T
T = [ -0.172 -0.074  0.122  0.231 0.239 0.194  0.156 -0.010 ;
       0.057 -0.019 -0.106 -0.022 0.041 0.048 -0.227  0.887 ;
      -0.229 -0.310 -0.246 -0.063 0.055 0.108  0.022  0.102 ];

vecto=T*ecg';

%las columnas de la matriz posiciones son
% x- y- z- x+ y+ z+
posiciones=[-78, -66, -68, -71, -75, -81;
            16, -100, -124, 8, -103, -128;
            80, -57, -128, 99, -61, -113;
            150, -30, -73, 153, -27, -42;
            144, -23, 7, 137, -21, 21;
            106, -22, 54, 74, -24, 65;
            -53, -68, 15, -51, -72, 11;
            -65, -73, -26, -60, -80, -20;
            -60, -80, -93, -58, -87, -106;
            41, 2, -163, 70, -4, -164;
            87, -94, -88, 98, -94, -73;
            19, -106, 10, 25, -104, 15;
            12, -121, -48, 26, -122, -42;
            -60, -80, -93, -58, -87, -106;
            -90, 0, -63, -86, 2, -79;
            -78, 43, -19, -78, 47, -27;
            91, -53, 48, 83, -52, 56;
            -47, 80, -86, -32, 84, -94];

%Para obtener las derivaciones hago (x+)-(x-), (y+)-(y-) y (z+)-(z-)
derivaciones=[posiciones(:,4)-posiciones(:,1), posiciones(:,5)-posiciones(:,2), posiciones(:,6)-posiciones(:,3)];

registros=vecto'*derivaciones';

for i=1:18
    figure('visible','off')
    plot(registros(:,i))
    L1=max(abs(registros(:,1)))*1.1;
    ylim([-L1 L1])
    xlim([0 size(registros,1)])
    title(num2str(i))
    nombre=strcat('reg',num2str(i),'.pdf');
    print(nombre,'-dpdf')
end
