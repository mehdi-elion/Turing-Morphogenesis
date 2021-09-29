%% --------------- Clear Workspace and close all figures ------------------
close all
clear 



%% ----------------------------- Gray Scott -------------------------------
% Parameters
Du = 3*10^(-5) ;
Dv = 1.5*10^(-5) ;
f = 0.01 ;
k = 0.041;
% Discretization of x domain
xmin = -4 ;
xmax = 4 ;
Nx = 100 ;
Tx = abs(xmax-xmin) ;
wx = 2*pi/Tx ;
% Discretization of y domain
ymin = -4 ;
ymax = 4 ;
Ny = 100 ;
Ty = abs(ymax-ymin) ;
wy = 2*pi/Ty ;
% Discretization of time domain
T = 800 ; 
Nt = 20000 ;
animStep = 200 ;
% Reaction Terms
F = @(u,v) -u.*v.^2 + f*(1-u) ;
G = @(u,v) +u.*v.^2 - (f+k)*v ;
% Initial conditions
% u_in = @(x,y) 1 + sin( wx*pi * repmat(x,1,Ny) ).*sin( wy*pi * repmat(y,Nx,1) ) ;
% v_in = @(x,y) 1  + sin( 3*wx*pi * repmat(y,Nx,1) ).*sin( 3*wy*pi * repmat(x,1,Ny) ) ;
u_in = @(x,y) 3+2* 2*(rand(Nx,Ny)-0.5) ;
v_in = @(x,y) 4+2* 2*(rand(Nx,Ny)-0.5) ;


%% -------------------------------- Turk ----------------------------------
% % Discretization of time domain
% T = 500 ;
% Nt = 20000 ;
% animStep = 200 ;
% % Discretization of x domain
% xmin = -5 ;
% xmax = 5 ;
% Nx = 100 ;
% Tx = abs(xmax-xmin) ;
% wx = 2*pi/Tx ;
% % Discretization of y domain
% ymin = -5 ;
% ymax = 5 ;
% Ny = 100 ;
% Ty = abs(ymax-ymin) ;
% wy = 2*pi/Ty ;
% % Parameters
% Du = 0.1 ;
% Dv = 0.02 ;
% b = 0.05 ;
% k = 0.001 ;
% % Reaction Terms
% F = @(u,v) k*(16-u.*v) ;
% G = @(u,v) k*(u.*v-12-b) ;
% % Initial conditions
% % u_in = @(x,y) 1 + sin( wx*pi * repmat(x,1,Ny) ).*sin( wy*pi * repmat(y,Nx,1) ) ;
% % v_in = @(x,y) 1  + sin( 3*wx*pi * repmat(y,Nx,1) ).*sin( 3*wy*pi * repmat(x,1,Ny) ) ;
% u_in = @(x,y) 4+1*rand(Nx,Ny) ;
% v_in = @(x,y) 4+1*rand(Nx,Ny) ;




%% --------------------------- Resolution ---------------------------------
[xf,yf,tf,MUf,MVf] = FiniteDiffRK4( xmin, xmax, Nx, ymin, ymax, Ny , T, Nt, u_in, v_in, Du, Dv, F, G) ;


%% --------------------------- Animation ----------------------------------
% Animate2(xf,yf,tf,MUf,MVf,animStep)


%% ----------------------------- Save -------------------------------------
% save('GrayScott_1.mat','xmin','xmax','Nx','ymin','ymax','Ny','T','Nt',...
%      'Du','Dv','f','k','u_in','v_in','F','G', 'animStep') ;

