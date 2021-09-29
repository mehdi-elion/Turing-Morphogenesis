%% --------------- Clear Workspace and close all figures ------------------
close all
clear 


%% --------------- Discretization of Time & 2D space ----------------------

% Discretization of time domain
T = 20 ;
Nt = 20000 ;
animStep = 40 ;

% Discretization of x domain
xmin = -12 ;
xmax = 12 ;
Nx = 100 ;
Tx = abs(xmax-xmin) ;
wx = 2*pi/Tx ;

% Discretization of y domain
ymin = -12 ;
ymax = 12 ;
Ny = 100 ;
Ty = abs(ymax-ymin) ;
wy = 2*pi/Ty ;


%% ---------------------------- Systems -----------------------------------

% Diffusion coefficients
d = 10 ;
gamma = 9 ;


%---------------------------- Schnakenberg --------------------------------
% % Parameters
% a = 0.2 ;
% b = 0.6 ;
% % Reaction Terms
% F = @(u,v) a - u + (u.^2).*v ;
% G = @(u,v) b - (u.^2).*v ;
% % Initial conditions
% u_in = @(x,y) 0.5*sin( 2*pi .* repmat(x,1,Ny) ).*sin( 2*pi .* repmat(y,Nx,1) ) ;
% v_in = @(x,y) 0.5*sin( 3*pi .* repmat(y,Nx,1) ).*sin( 3*pi .* repmat(x,1,Ny) ) ;


%------------------------- Substrate Inhibition ---------------------------
% Parameters
a = 92 ;
b = 64 ;
K = 0.1 ;
alpha = 1.5 ;
rho = 18.5 ;
% Reaction Terms
F = @(u,v) a - u - rho*u.*v ./ (1 + u + K*u.^2) ;
G = @(u,v) alpha*(b-v) - rho*u.*v ./ (1 + u + K*u.^2) ;
% Initial conditions
% u_in = @(x,y) 1 + sin( wx*pi * repmat(x,1,Ny) ).*sin( wy*pi * repmat(y,Nx,1) ) ;
% v_in = @(x,y) 1  + sin( 3*wx*pi * repmat(y,Nx,1) ).*sin( 3*wy*pi * repmat(x,1,Ny) ) ;
u_in = @(x,y) 10 + 4* 2*(rand(Nx,Ny)-0.5) ;
v_in = @(x,y)  9 + 4* 2*(rand(Nx,Ny)-0.5) ;




%% --------------------------- Resolution ---------------------------------
t1 = cputime ;
[xf,yf,tf,MUf,MVf] = FiniteDiffRK4( xmin, xmax, Nx, ymin, ymax, Ny , T, Nt, u_in, v_in, d, gamma, F, G) ;
tcpu = cputime-t1 ;


%% --------------------------- Animation ----------------------------------
% Animate2(xf,yf,tf,MUf,MVf,animStep)


%% ----------------------------- Save -------------------------------------
save('SubInhib_n.mat','xmin','xmax','Nx','ymin','ymax','Ny','T','Nt',...
     'a','b','d','gamma','K','alpha','rho','u_in','v_in','F','G',...
     'animStep','tcpu') ;

