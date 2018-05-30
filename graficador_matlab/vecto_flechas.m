c1d=diff(canal1(X2-250:X2));
c1d=[c1d; canal1(X2)-canal1(X2-250)];

c2d=diff(canal2(X2-250:X2));
c2d=[c2d; canal2(X2)-canal2(X2-250)];

quiver(canal2(X2-250:X2),canal1(X2-250:X2),c2d,c1d,'linewidth',1.5)
set(gca,'Ydir','reverse')
