close all
clear all

delete('prueba*')

datos=dlmread ('../Datos/Martín-Mello-Teggia/filt/Martín-Mello-Teggia_03_filt.txt' );

tm=(1:length(datos))';
fs=250;
%ganancia=1; %A/D units per mV
ganancia=1/(2.42/3/((2^23)-1)); %A/D units per mV
%ganancia=1e-3/(2.42/3/((2^23)-1)); %A/D units per mV

canal1=datos(:,1)*(2.42/3/((2^23)-1));
canal2=datos(:,2)*(2.42/3/((2^23)-1));

umbral=[];
%umbral=1.1;

%wrsamp(tm,datos,'prueba',fs,ganancia) %Writes data into a WFDB compatible *.dat and *.hea files.
%wrsamp(tm,datos,'prueba',fs) %Writes data into a WFDB compatible *.dat and *.hea files.

%canal=2;
for canal=1:2
    wrsamp(tm,datos(:,canal),'prueba',fs,ganancia) %Writes data into a WFDB compatible *.dat and *.hea files.
    wqrs ('prueba',[],150,[],umbral,true)%Creates a WQRS annotation file  at the current MATLAB directory. (recordName,N,N0,signal,threshold,findJ,powerLineFrequency,resample)
    ann(canal,:)=rdann('prueba','wqrs');%Reads annotation files for WFDB records
    [ecg_aux,fs_aux,tm_aux]=rdsamp ('prueba'); %Reads signal files for WFDB records
    ecg(canal,:)=ecg_aux; %Reads signal files for WFDB records

    ecgpuwave ('prueba','ondas', [], 150, 'wqrs');
    %ondas_p=rdann('prueba','ondas',[],[],[],'p');
    %ondas_t=rdann('prueba','ondas',[],[],[],'t');
    ondas_r(canal,:)=rdann('prueba','ondas',[],[],[],'N');

%    wrann('prueba','ondasr',ondas_r(canal,:));
%
%    [RR,tms]=ann2rr ('prueba','ondasr');
%    delay=round(0.1/tm(2));
%    M=length(RR);
%    %offset=0.3;
%    stack=zeros(M,min(RR))+NaN;
%    %qrs=zeros(M,2)+NaN;
%    for m=1:M
%        stack(m,1:min(RR)+1)=datos(:,canal)(tms(m)-delay:tms(m)+min(RR)-delay);
%        %qrs(m,:)=[delay+1 canal1(tms(m))];
%    end
%
%    latido_promedio(canal,:)=mean(stack);
end

%vecto(latido_promedio)

figure
hold on
%plot(canal1)
plot(ecg(1,:))
%%%plot(ecg(150:end))
stem (ann(1,:),1.1*max(canal1(150:end))*ones(size(ann(1,:))),'g') %Revisar la posición en la que queda
%%stem (ondas_t,01.1*max(canal1(150:end))*ones(size(ondas_t)),'k')
stem (ondas_r(1,:),01.1*max(canal1(150:end))*ones(size(ondas_r(1,:))),'r')

figure
hold on
%plot(canal2)
plot(ecg(2,:))
stem (ann(2,:),1.1*max(canal2(150:end))*ones(size(ann(2,:))),'g') %Revisar la posición en la que queda
stem (ondas_r(2,:),01.1*max(canal2(150:end))*ones(size(ondas_r(2,:))),'r')
