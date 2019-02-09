function M = graficar_plano(x, y, z, num_reg, a)
    idx=1;
    Z=z;
    col=length(x);
    fil=length(y);
    M=[]; %Matriz para guardar los latidos
    for Y=y
        for X=x
            Xp=X+0.2;
            Xn=X-0.2;
            ep=[Xp,Y,Z];
            en=[Xn,Y,Z];
            %idxY=idxY+1;

         %    figure(1);hold on
         %    xlabel('X')
         %    ylabel('Y')
         %    zlabel('Z')
         %    plot3(ep(1),ep(2),ep(3),'ro')
         %    hold on
         %    plot3(en(1),en(2),en(3),'ko')

            for n=1:size(a,1)
            %           figure(1);hold on
            %           plot3(ep(1),ep(2),ep(3),'ro')
            %           hold on
            %           plot3(en(1),en(2),en(3),'bo')
               % vp=(1/norm(a(n,:)-ep) - 1/norm(ep));
               % vn=(1/norm(a(n,:)-en) - 1/norm(en));
                vp=a(n,:)*ep';
                vn=a(n,:)*en';
                v(n)=vp-vn;
            end
            figure(2);
            hold on
            subplot(fil,col,idx);hold on
            plot(v)
            axis off
            idx=idx+1;
            M=[M;v];
        end
    end
  %  figure(1); hold on
  %  plot3(a(:,1),a(:,2),a(:,3))
  %  xlabel('X')
  %  ylabel('Y')
  %  zlabel('Z')

   % nombre=strcat('plano',num2str(num_reg),'.pdf');
   % print(nombre,'-dpdf')
    close all
end
