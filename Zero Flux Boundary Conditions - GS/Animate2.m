function [] = Animate2(xf,yf,tf,MUf,MVf,animStep)
%ANIMATE Summary of this function goes here
%   Detailed explanation goes here

figure('units','normalized','outerposition',[0 0 1 1])


zmin_U = min([min(min(min(MUf))),min(min(min(MUf)))]) ;
zmax_U = max([max(max(max(MUf))),max(max(max(MUf)))]) ;
zmin_V = min([min(min(min(MVf))),min(min(min(MVf)))]) ;
zmax_V = max([max(max(max(MVf))),max(max(max(MVf)))]) ;
zmax = max(zmax_U, zmax_V) ;
zmin = min(zmin_U, zmin_V) ;

for i = 1:animStep:length(tf)
    Displot2(xf,yf,tf,MUf(:,:,i),MVf(:,:,i),i)
    pause(0.05)
end

end


