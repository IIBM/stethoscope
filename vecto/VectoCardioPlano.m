clear all
%close all


% a=150;
% e=-0.9;
% idx=1;
% figure;hold on
% plot(0,0,'+')
% Y=[200 175 150 125 100]
% for tita=[20 26 35 50 90]
%     r=a*(1-e^2)/(1+e*cos(pi/180*tita));
%     x=r*cos(pi/180*tita)-100;
%     y=r*sin(pi/180*tita);
%     plot3(x,y,Y(idx),'k.')
%     xlim([-200 200]);
%     ylim([-200 200]);
%     pause(0.1)
%     idx=idx+1;
% end


%load vecto_ramos_mejia.mat
load control_physionet.mat
%load bloqueo_physionet.mat

%a=a-280;        %%% offset impuesto por inkscape cuando se relevaron los puntos
%aux(:,1)=interp(a(:,1),10);
%aux(:,2)=interp(a(:,2),10);
%aux(:,3)=interp(a(:,3),10);
%
%a=aux;

a=a(3200:4100,:); %Elijo un latido
%a=a(4600:5500,:); %Elijo un latido

deltaangle=15;
deltaY=10;

ar=150;
e=-0.9;

Z=max(a(:,3))*1.2;

min_x=min(a(:,1));
max_x=max(a(:,1));
margen_x=(abs(min_x)+abs(max_x))*0.2;

min_y=min(a(:,2));
max_y=max(a(:,2));
margen_y=(abs(min_y)+abs(max_y))*0.2;

for num_reg=[1:9]
    x=linspace(min_x-margen_x, max_x+margen_x, 12);

    y=linspace(max_y+margen_y, min_y-margen_y, 12);

    switch num_reg
        case 1
            x=x(1:4);
            y=y(1:4);
            P1=graficar_plano(x, y, Z, num_reg, a);
        case 2
            x=x(5:8);
            y=y(1:4);
            P2=graficar_plano(x, y, Z, num_reg, a);
        case 3
            x=x(9:12);
            y=y(1:4);
            P3=graficar_plano(x, y, Z, num_reg, a);
        case 4
            x=x(1:4);
            y=y(5:8);
            P4=graficar_plano(x, y, Z, num_reg, a);
        case 5
            x=x(5:8);
            y=y(5:8);
            P5=graficar_plano(x, y, Z, num_reg, a);
        case 6
            x=x(9:12);
            y=y(5:8);
            P6=graficar_plano(x, y, Z, num_reg, a);
        case 7
            x=x(1:4);
            y=y(9:12);
            P7=graficar_plano(x, y, Z, num_reg, a);
        case 8
            x=x(5:8);
            y=y(9:12);
            P8=graficar_plano(x, y, Z, num_reg, a);
        case 9
            x=x(9:12);
            y=y(9:12);
            P9=graficar_plano(x, y, Z, num_reg, a);
    end
end

save('vect_plano', 'P1', 'P2', 'P3', 'P4', 'P5', 'P6', 'P7', 'P8', 'P9')
