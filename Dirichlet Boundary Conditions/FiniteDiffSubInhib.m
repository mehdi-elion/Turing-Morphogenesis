function [ xf, yf, tf, MUf, MVf  ] = FiniteDiffSubInhib( xmin, xmax, Nx, ymin, ymax, Ny , T, Nt, u_in, v_in, u_L, u_R, u_T, u_B, v_L, v_R, v_T, v_B)

%FINITEDIFFTURING Summary of this function goes here
%   Detailed explanation goes here

%% Parameters of the Shnakenberg System
a = 2.6 ;
b = 1.5 ;
d = 12.5 ;
gamma = 0.6 ;
K = 10 ;
alpha = 4.5 ;
rho = 8.1 ;



%% Discretization of space time domain

% x discretization (column)
dx = (xmax-xmin)/(Nx+1);
x = (xmin+dx:dx:xmax-dx)';

% y discretization (row)
dy = (ymax-ymin)/(Ny+1);
y = (ymin+dy:dy:ymax-dy);

% t discretization
dt = T/Nt;
tf = 0:dt:T;




%% Matrice A
A = MatriceA(Nx, dx, Ny, dy) ;




%% Resolution

% Storage 
MUf = zeros(Nx+2, Ny+2, Nt+1) ;
MVf = zeros(Nx+2, Ny+2, Nt+1) ;

% Initialization
    % u function
U0 = u_in(x,y,Nx,Ny) ;
MUf(2:Nx+1, 2:Ny+1, 1 ) = reshape( U0, Nx, Ny ) ;
    % u function
V0 = v_in(x,y,Nx,Ny) ;
MVf(2:Nx+1, 2:Ny+1, 1 ) = reshape( V0, Nx, Ny ) ;  

% Iterations
for n = 1:Nt
    % Calculation
    U1 = U0 + dt*gamma*F_SubInhib(U0,V0,a,rho,K) - dt*A*U0 ;
    V1 = V0 + dt*gamma*G_SubInhib(U0,V0,b,rho,alpha,K) - dt*d*A*V0 ;
    % Storage
    MUf(2:Nx+1, 2:Ny+1, n+1 ) = reshape(U1, Nx, Ny);
    MVf(2:Nx+1, 2:Ny+1, n+1 ) = reshape(V1, Nx, Ny);
    % Updating state vectors
    U0 = U1 ;
    V0 = V1 ;
    % Progress
    ['Calculation ongoing : ',num2str(n/Nt*100),' %']
end



%% Complete resolution data
    % x vector
xf = zeros(Nx+2,1);
xf(2:Nx+1) = x;
xf(1) = xmin;
xf(Nx+2) = xmax;
    % y vector
yf = zeros(Ny+2,1);
yf(2:Ny+1) = y;
yf(1) = ymin;
yf(Ny+2) = ymax;



end

