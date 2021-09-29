function [] = Displot(xf,yf,tf,Uf,Vf,i,zmax)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

Nt = length(tf) ;

s1 = subplot(2,2,1) ;
surf(xf, yf, Uf', 'EdgeColor', 'None')
colormap(s1, jet)
title(strcat('Temps = ',num2str((i-1)/Nt*100),' %'))
xlabel('x')
ylabel('y')
zlabel('u(x,y,t)')
view(0,90)

s2 = subplot(2,2,3);
surf(xf, yf, Vf','EdgeColor', 'None')
colormap(s2, parula)
title(strcat('Temps = ',num2str((i-1)/Nt*100),' %'))
xlabel('x')
ylabel('y')
zlabel('v(x,y,t)')
view(0,90)


subplot(2,2,[2,4])
Cmap = ColorMap(Uf'/zmax, Vf'/zmax) ;
imagesc(xf, yf, Cmap)
title(strcat('Temps = ',num2str((i-1)/Nt*100),' %'))
xlabel('x')
ylabel('y')
zlabel('color plot')



end

