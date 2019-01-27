
load vecto_ramos_mejia.mat

a=a-280;        %%% offset impuesto por inkscape cuando se relevaron los puntos
#aux(:,1)=interp1(a(:,1),10);
#aux(:,2)=interp1(a(:,2),10);
#aux(:,3)=interp1(a(:,3),10);

#a=aux;
plot3(a(:,1), a(:,2), a(:,3),'LineWidth',1);
xlabel("x")
ylabel("y")
zlabel("z")
