%%% V=25 mm/seg
%%% cuadricula 200 ms / division grande
%%%             40 ms / division chica

function varargout = ecg(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ecg_OpeningFcn, ...
                   'gui_OutputFcn',  @ecg_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before ecg is made visible.
function ecg_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;
guidata(hObject, handles);

%movegui('north')

% global var;
% var.x=0;
% var.tmr=timer('TimerFcn',{@TimerCallback,hObject,handles},'Period',0.1,'ExecutionMode','FixedRate');

global s;
delete(instrfindall)
%s = serial('/dev/tty.wchusbserial1410','BaudRate',38400);
%4800, 9600, 19200, 57600, 115200
s = serial('/dev/ttyUSB0','BaudRate',115200,'DataBits',8,'Parity','none','StopBits',1);
fopen(s)
pause(6) %Espera que termine la configuración del ADS1292
global escalado;
escalado=256*(2.42/3/((2^23)-1)); %cuanto representa 1 muestra en tension
global c1 c2;
c1=zeros(1,2000);
c2=zeros(1,2000);
global L1;
L1=100*escalado;
global L2;
L2=100*escalado;
global X1;
X1=1000;
global X2;
X2=2000;
global save;
save=0;
global fid;
fid=fopen('output.txt','wb');
%global archivo_c1;
%global archivo_c2;
global beep

beep = audioplayer(sin(1:.2:2000), 22050);

set(handles.C1,'xlim',[0 X1],'xtick',0:50:X1,'xticklabel',0:0.2:4)
hold(handles.C1,'on');
set(handles.C2,'xlim',[0 X1],'xtick',0:50:X1,'xticklabel',0:0.2:4)
hold(handles.C2,'on');

% UIWAIT makes ecg wait for user response (see UIRESUME)
% uiwait(handles.figure1);

% --- Para el filtro adaptado de linea de base
global alfa w1 w2;
fc = 0.5; %Frecuencia de corte del filtro
wc = 2*pi*fc;%7;
Fs=250; %Frecuencia de muestreo del ADS1292
coswc = cos(wc * 2*pi/Fs);
p = [1 -2*coswc (-3+4*coswc)];
beta12 = roots(p);
alfa12 = 1 - beta12;
alfa = alfa12(2);
w1 = randn;
w2 = randn;

% --- Outputs from this function are returned to the command line.
function varargout = ecg_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;


% --- Executes on button press in Start.
function Start_Callback(hObject, eventdata, handles)
global s;
global running;
global leer_muestras;
global escalado;
global c1 c2;
global c1aux c2aux;
global c1filt c2filt;
global L1; %L2;
global X1 X2;
global fid;
global archivo_c1;
global archivo_c2;
global guardar_c1;
global guardar_c2;
global save;
global alfa w1 w2;
global graficar;
global muestras_guardar;

graficar=true;

canal1=0;
canal2=0;

c1filt=zeros(1, 251);
c2filt=zeros(1, 251);

global w;
running=1;
leer_muestras=1;

global j;
j=0;

X1=1000;
X2=2000;

set(handles.C1,'xlim',[0 X1],'xtick',0:50:X1,'xticklabel',0:0.2:4)
set(handles.C2,'xlim',[0 X1],'xtick',0:50:X1,'xticklabel',0:0.2:4)

c1hp=zeros(1, 2000);
c2hp=zeros(1, 2000);

inicio_trama=[0 255 0]; %[0x00 0xFF 0x00]

global fecha_guardada;
fecha_guardada=0;

fwrite(s,'1');
pause(2)

while running
%     tic
    if (leer_muestras==1)

        %while(true) %Lee tramas nuevas 
        num_canal=1;
        while(num_canal==1) %Lee tramas nuevas 
            %Busca el inicio de la trama
            aux_inicio_trama = fread(s, 3, 'uint8')';
            while ~all(aux_inicio_trama == inicio_trama)
                aux_inicio_trama(end) = fread(s, 1, 'uint8');
                aux_inicio_trama = circshift(aux_inicio_trama, [1, -1]);
            end

            %Lee las distintas partes de la trama
            cant_muestras=fread(s,1, 'uint8');
            c = fread(s, cant_muestras+2, 'int8'); %Lee cant_muestras+num_canal+chksum
            num_canal=c(1);
            muestras=c(2:end-1);
            chksum=typecast(int8(c(end)), 'uint8');

            %Calcula el checksum
            %aux_chksum=typecast(int8(muestras(1)), 'uint8');
            %for i=2:cant_muestras
            %    aux_chksum=bitxor(aux_chksum, typecast(int8(muestras(i)), 'uint8'));
            %end
            aux_chksum=typecast(int8(muestras), 'uint8');
            chksum_calculado=bin2dec(num2str(flipdim(mod(sum(de2bi(aux_chksum,8)),2),2)));

            %Si el checksum dio bien, pone las muestras en el canal que
            %corresponda
            %if (aux_chksum==chksum)
            if (chksum_calculado==chksum)
                cint=double(typecast(int8(muestras), 'int16')); %Pasa a enteros de 16 bits los 2 bytes de cada canal que se reciben
                if (num_canal==1)
                    c1aux=cint'*escalado;
                elseif (num_canal==2)
                    c2aux=cint'*escalado;
                end%if
            else %Si no da el checksum descarta los datos y pone NaN
                if(num_canal==1)
                    c1aux=ones(cant_muestras, 1)*NaN;
                elseif(num_canal==2)
                    c2aux=ones(cant_muestras, 1)*NaN;
                end%if
            end%if del checksum
         end%while tramas
         
         % -- Agrego las nuevas muestras
         c1=[c1((cant_muestras/2)+1:end) c1aux]; 
         c2=[c2((cant_muestras/2)+1:end) c2aux];        
            
         % -- Filtro los 50Hz con un MA
         c1_50Hz=moving_average_50hz(c1, 250);
         c2_50Hz=moving_average_50hz(c2, 250);

         % -- Filtro la línea de basecon con un hp adaptado
         c1hp=hp_adaptado(c1_50Hz, alfa);
         c2hp=hp_adaptado(c2_50Hz, alfa);

         c1filt=c1hp';
         c2filt=c2hp';

         
         if(save==1) % Si se seleccionó 'Guardar' voy armando el vector
            if(length(guardar_c1) <= muestras_guardar) %Guarda hasta que se termine el tiempo
                guardar_c1=[guardar_c1; c1aux'];
                guardar_c2=[guardar_c2; c2aux'];
                graficar=~graficar;
            else % Si se terminó el tiempo o se seleccionó 'Parar' llamo a save para que deje de guardar
                Save_Callback(hObject, eventdata, handles)
            end
         end

        if(graficar==true)
            %Acomodo los datos para graficar
            canal1=[c1filt(end-j:end); c1filt(end-X1:end-j)];
            canal2=[c2filt(end-j:end); c2filt(end-X1:end-j)];

            axes(handles.C1)
            set(gca,'NextPlot','replacechildren') %Para que resetee el gráfico
            plot(canal1,'linewidth',1) %Trazado del Canal1
            line([j j], [-L1 L1], 'Color', 'g', 'linewidth',1) %Linea que sigue el final del trazado
            ylim([-L1 L1])
            grid on
            
            axes(handles.C2)
            set(gca,'NextPlot','replacechildren') %Para que resetee el gráfico
            plot(canal2,'linewidth',1) %Trazado del Canal2
            line([j j], [-L1 L1], 'Color', 'g', 'linewidth',1) %Linea que sigue el final del trazado
            ylim([-L1 L1])
            grid on
            
            axes(handles.V1)
            plot(c1filt(end-250:end),c2filt(end-250:end)) %Vectocardiograma
            xlim([-L1 L1])
            ylim([-L1 L1])
            set(gca,'Ydir','reverse') %Doy vuelta el eje y para que coincida con el cabezal
            pause(0.000001)
        end

        j=j+length(cint);
        if(j>=(X2-X1))
           j=j-(X2-X1);
        end%if 

     elseif(leer_muestras==0)
        axes(handles.C1)
        plot(c1filt,'linewidth',1)
        ylim([-L1 L1])
        xlim([X1 X2])
        set(gca,'xtick',X1:50:X2,'xticklabel',0:0.2:4)
        grid on
        
        axes(handles.C2)
        plot(c2filt,'linewidth',1)
        ylim([-L1 L1])
        xlim([X1 X2])
        set(gca,'xtick',X1:50:X2,'xticklabel',0:0.2:4)
        grid on
        
        axes(handles.V1)
        [y0 x0]=find(min(c1filt(end-250:end).^2+c2filt(end-250:end).^2));
        plot(c1filt(end-250:end),c2filt(end-250:end))
        xlim([-L1 L1])
        ylim([-L1 L1])
        set(gca,'Ydir','reverse')
        pause(0.000001)
    end%if
end


% --- Executes on button press in Stop.
function Stop_Callback(hObject, eventdata, handles)
% hObject    handle to Stop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global s;
global leer_muestras;
global beep

leer_muestras=0;
fwrite(s,'2');
play(beep);
pause(1)


% --- Executes on button press in upc1.
function upc1_Callback(hObject, eventdata, handles)
% hObject    handle to upc1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global L1
L1=0.9*L1;


% --- Executes on button press in downc1.
function downc1_Callback(hObject, eventdata, handles)
% hObject    handle to downc1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global L1
L1=1.1*L1;


% --- Executes on button press in Save.
function Save_Callback(hObject, eventdata, handles)
% hObject    handle to Save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global save;
global var;
global fecha_guardada;
global archivo_c1;
global archivo_c2;
global guardar_c1;
global guardar_c2;
global graficar;
%global muestras_guardar;

posicion=get(handles.posicion,'String');
posicion=strrep(posicion,' ','-'); %Reemplazo los espacios por "-"

nombre_paciente=get(handles.nombre_paciente,'String');
nombre_paciente=strrep(nombre_paciente,' ','-'); %Reemplazo los espacios por "-"

aux_nombre_archivo=strcat('./Datos/', nombre_paciente, '_', datestr(now,'yyyy-mm-dd_HH-MM-SS'), '_');

if (strcmp(lower((get(handles.Save,'String'))),'guardar'))
    save=1;
    set(handles.Save,'String','Parar')
    archivo_c1=strcat(aux_nombre_archivo, 'c1_', num2str(posicion), '.txt');
    archivo_c2=strcat(aux_nombre_archivo, 'c2_', num2str(posicion), '.txt');
    fecha=clock';
    guardar_c1=fecha;
    guardar_c2=fecha;
else
    save=0;
    fecha_guardada=0;
    dlmwrite(archivo_c1, guardar_c1);
    dlmwrite(archivo_c2, guardar_c2);
    set(handles.Save,'String','Guardar')
    graficar=true;
end

    
function TimerCallback(obj,event,hObject,handles)
global var;
set(handles.text1,'String',var.x);
var.x=var.x+1;


% --- Executes on button press in Atras.
function Atras_Callback(hObject, eventdata, handles)
% hObject    handle to Atras (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)global running;
global s;
global leer_muestras;
global running;
global X1 X2;
leer_muestras=0;
running=1;
fwrite(s,'2');
X1=X1-100;
X2=X2-100;
if (X2<900)
    set(handles.Atras,'Enable','off')
end
if (X2<2000)
    set(handles.Adelante,'Enable','on')
end

% --- Executes on button press in Adelante.
function Adelante_Callback(hObject, eventdata, handles)
% hObject    handle to Adelante (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global s;
global leer_muestras;
global running;
global X1 X2;
leer_muestras=0;
running=1;
fwrite(s,'2');
X1=X1+100;
X2=X2+100;
if (X2>900)
    set(handles.Atras,'Enable','on')
end
if (X2>2000)
    set(handles.Adelante,'Enable','off')
end


% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global s;
global running;
global leer_muestras;
global save;
leer_muestras=0;
save=0;
running=0;
fwrite(s,'3');
pause(1)
% Hint: delete(hObject) closes the figure
delete(hObject);


% --- Executes on key press with focus on figure1 and none of its controls.
function figure1_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  structure with the following fields (see FIGURE)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
switch eventdata.Key
    case 'uparrow'
        upc1_Callback(hObject, eventdata, handles);
    case 'downarrow'
        downc1_Callback(hObject, eventdata, handles);
    case 'rightarrow'
        Adelante_Callback(hObject, eventdata, handles);
    case 'leftarrow'
        Atras_Callback(hObject, eventdata, handles);
    case 'space'
        Stop_Callback(hObject, eventdata, handles);
    case 's'
        Start_Callback(hObject, eventdata, handles)
    case 'g'
        Save_Callback(hObject, eventdata, handles)
end


% --- Executes during object creation, after setting all properties.
function nombre_paciente_CreateFcn(hObject, eventdata, handles)
% hObject    handle to nombre_paciente (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
%nombre_paciente=getappdata(0,'nombre');
%nombre=['Paciente: ',' ', nombre_paciente];
%set(hObject,'String',nombre);


function posicion_Callback(hObject, eventdata, handles)
% hObject    handle to posicion (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of posicion as text
%        str2double(get(hObject,'String')) returns contents of posicion as a double
%global posicion;
%posicion=get(hObject,'String');
%set(handles.Save,'Enable','on')


function segundos_Callback(hObject, eventdata, handles)
% hObject    handle to segundos (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of segundos as text
%        str2double(get(hObject,'String')) returns contents of segundos as a double
global muestras_guardar;

tiempo=str2double(get(hObject,'String'));
if isnan(tiempo) %str2double devuelve NaN si el string no es un número
    set(handles.Save,'Enable','off')
else
    set(handles.Save,'Enable','on')
    muestras_guardar=(tiempo*250)+6; %Cantidad de muestras a guardar.
                                     %(Segundos*SPS)+fecha
end

function nombre_paciente_Callback(hObject, eventdata, handles)
% hObject    handle to nombre_paciente (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of nombre_paciente as text
%        str2double(get(hObject,'String')) returns contents of nombre_paciente as a double


% --- Executes during object creation, after setting all properties.
function posicion_CreateFcn(hObject, eventdata, handles)
% hObject    handle to posicion (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function segundos_CreateFcn(hObject, eventdata, handles)
% hObject    handle to segundos (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
