function [] = Displot2(xf,yf,tf,Uf,Vf,i)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

Nt = length(tf) ;

s1 = subplot(1,2,1) ;
surf(xf, yf, Uf', 'EdgeColor', 'None')
colormap(s1, jet)
title(strcat('Temps = ',num2str((i-1)/Nt*100),' %'))
xlabel('x')
ylabel('y')
zlabel('u(x,y,t)')
view(0,90)
axis off

s2 = subplot(1,2,2);
surf(xf, yf, Vf','EdgeColor', 'None')
colormap(s2, parula)
title(strcat('Temps = ',num2str((i-1)/Nt*100),' %'))
xlabel('x')
ylabel('y')
zlabel('v(x,y,t)')
view(0,90)
axis off


end

