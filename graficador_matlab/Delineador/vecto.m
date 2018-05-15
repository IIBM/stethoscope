function vecto(latido_promedio)

latido_promedio=latido_promedio*(2.42/3/((2^23)-1));

canal1=latido_promedio (1,:);
canal2=latido_promedio (2,:);

L1=max(max(abs(canal1),abs(canal2)));
L1=L1*1.1;

figure
    plot(canal1, canal2)
    set(gca,'Ydir','reverse')
    xlim([-L1 L1])
    ylim([-L1 L1])
    xL = xlim;
    yL = ylim;
    line(xL, [0 0],'color','k','LineStyle',':','linewidth',1) %x-axis
    line([0 0], yL,'color','k','LineStyle',':','linewidth',1) %y-axis
