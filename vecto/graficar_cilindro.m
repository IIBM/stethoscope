function graficar_cilindro(angulo, y, radio, desplazamiento, num_reg, a)
    idx=1;
    col=length(angulo);
    fil=length(y);
    for Y=y
        for angle=angulo
            Xn=radio*cos(angle*pi/180)+desplazamiento;
            Xp=radio*cos((angle-2)*pi/180)+desplazamiento;
            Zn=radio*sin(angle*pi/180);
            Zp=radio*sin((angle-2)*pi/180);
            ep=[Xp,Y,Zp];
            en=[Xn,Y,Zn];
             
           % figure(1);hold on
           % xlabel('X')
           % ylabel('Y')
           % zlabel('Z')
           % plot3(ep(1),ep(2),ep(3),'ro')
           % hold on
           % plot3(en(1),en(2),en(3),'bo')
            for n=1:size(a,1)
                                       %figure(1);hold on
                                       %line([0,a(n,1)],[0,a(n,2)],[0,a(n,3)],'linewidth',2,'LineStyle','-','Color',[0 0 0]);
                                       %xlabel('X')
                                       %ylabel('Y')
                                       %zlabel('Z')
                                       %xlim([-200,200]);
                                       %ylim([-200,200]);
                                       %zlim([-200,200]);
                                       %pause(0.05)
                                       %line([0,a(n,1)],[0,a(n,2)],[0,a(n,3)],'linewidth',2,'LineStyle','-','Color',[.9 .9 .9]);
                                       %plot3(ep(1),ep(2),ep(3),'ro')
                                       %hold on
                                       %plot3(en(1),en(2),en(3),'bo')
                vp=(1/norm(a(n,:)-ep) - 1/norm(ep));
                vn=(1/norm(a(n,:)-en) - 1/norm(en));
                v(n)=vp-vn;
            end
            figure(2);hold on
            subplot(fil,col,idx);
            hold on
            plot(v)
            %ylim([-0.00025 0.00025]);
            axis off
            idx=idx+1;
    %        %[Y, angle]
        end
    end
   % figure(1); hold on
   % plot3(a(:,1),a(:,2),a(:,3))
   % xlabel('X')
   % ylabel('Y')
   % zlabel('Z')

    nombre=strcat('cilindro',num2str(num_reg),'.pdf');
    print(nombre,'-dpdf')
    close all
end
