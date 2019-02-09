clear all
close all


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

%radio=200;
radio=1;
desplazamiento=max(a(:,1));

angulo=[[315:15:360],[15:15:45]];
%angulo=[315:15:360];
%angulo=[15:15:45];

min_y=min(a(:,2));
max_y=max(a(:,2));
margen_y=(abs(min_y)+abs(max_y))*0.2;

y=linspace(max_y+margen_y, min_y-margen_y, 12);

for num_reg=[1:6]
    y=linspace(max_y+margen_y, min_y-margen_y, 12);

    switch num_reg
        case 1
            angulo=[315:15:360];
            y=y(1:4);
            C1=graficar_cilindro(angulo, y, radio, desplazamiento, num_reg, a);
        case 2
            angulo=[15:15:45];
            y=y(1:4);
            C2=graficar_cilindro(angulo, y, radio, desplazamiento, num_reg, a);
        case 3
            angulo=[315:15:360];
            y=y(5:8);
            C3=graficar_cilindro(angulo, y, radio, desplazamiento, num_reg, a);
        case 4
            angulo=[15:15:45];
            y=y(5:8);
            C4=graficar_cilindro(angulo, y, radio, desplazamiento, num_reg, a);
        case 5
            angulo=[315:15:360];
            y=y(9:12);
            C5=graficar_cilindro(angulo, y, radio, desplazamiento, num_reg, a);
        case 6
            angulo=[15:15:45];
            y=y(9:12);
            C6=graficar_cilindro(angulo, y, radio, desplazamiento, num_reg, a);
    end
end

save('vect_cilindro', 'C1', 'C2', 'C3', 'C4', 'C5', 'C6')
