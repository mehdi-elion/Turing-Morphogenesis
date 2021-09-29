function [] = Animate3(xf,yf,tf,MUf,MVf,animStep)
%ANIMATE Summary of this function goes here
%   Detailed explanation goes here

%figure('units','normalized','outerposition',[0 0 1 1])


% zmin_U = min([min(min(min(MUf))),min(min(min(MUf)))]) ;
% zmax_U = max([max(max(max(MUf))),max(max(max(MUf)))]) ;
% zmin_V = min([min(min(min(MVf))),min(min(min(MVf)))]) ;
% zmax_V = max([max(max(max(MVf))),max(max(max(MVf)))]) ;
% zmax = max(zmax_U, zmax_V) ;
% zmin = min(zmin_U, zmin_V) ;

% lambda = [(0:0.0001:0.2)' ; (0.2:0.001:0.8)' ; (0.8:0.0001:1)'] ;
% lambda = (0:0.2:1)' ;
lambda = [(0:0.0001:0.2)' ; (0.2:0.1:0.8)' ; (0.8:0.0001:1)'] ;

C0 = [0,0,0] ;
C1 = [1,215/255,0] ;
Cmap = lambda*C1 + (1-lambda)*C0 ;
Cmap = [zeros(2,3) ; Cmap] ;


for i = 1:1%animStep:length(tf)
    Displot3(xf,yf,tf,MUf(:,:,i),MVf(:,:,i),i,Cmap)
    pause(0.05)
end

end


