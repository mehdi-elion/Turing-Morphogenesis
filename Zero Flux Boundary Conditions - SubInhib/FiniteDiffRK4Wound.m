function [ xf, yf, tf, MUf, MVf  ] = FiniteDiffRK4Wound( xmin, xmax, Nx, ymin, ymax, Ny , T, Nt, Uin, Vin, d, gamma, F, G)

%FINITEDIFFTURING Summary of this function goes here
%   Detailed explanation goes here



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
A = MatriceA_ZeroFlux(Nx, dx, Ny, dy) ;


%% Time derivative formula for RK4
Fsim = @(U,V) gamma*F(U,V) +   A*U ;
Gsim = @(U,V) gamma*G(U,V) + d*A*V ;



%% Resolution

% Storage 
MUf = zeros(Nx+2, Ny+2, Nt+1) ;
MVf = zeros(Nx+2, Ny+2, Nt+1) ;

% Initialization
    % u function
U0 = Uin ;
MUf(2:Nx+1, 2:Ny+1, 1 ) = U0 ;
U0 = reshape(U0,Nx*Ny,1) ;
    % u function
V0 = Vin ;
MVf(2:Nx+1, 2:Ny+1, 1 ) = V0 ;  
V0 = reshape(V0,Nx*Ny,1) ;

% Iterations
for n = 1:Nt
    % Calculation by RK4
    k1 = Fsim(U0,V0) ;                 	p1 = Gsim(U0,V0) ;
    k2 = Fsim(U0+dt/2*k1, V0+dt/2*p1) ;	p2 = Gsim(U0+dt/2*k1, V0+dt/2*p1) ;
    k3 = Fsim(U0+dt/2*k2, V0+dt/2*p2) ;	p3 = Gsim(U0+dt/2*k2, V0+dt/2*p2) ;
    k4 = Fsim(U0+dt*k3, V0+dt*p3) ;     p4 = Gsim(U0+dt*k3, V0+dt*p3) ;
    U1 = U0 + dt/6 * (k1 + 2*k2 + 2*k3 + k4) ;
    V1 = V0 + dt/6 * (p1 + 2*p2 + 2*p3 + p4) ;
    % Storage
    MUf(2:Nx+1, 2:Ny+1, n+1 ) = reshape(U1, Nx, Ny) ;
    MVf(2:Nx+1, 2:Ny+1, n+1 ) = reshape(V1, Nx, Ny) ;
    % Updating state vectors
    U0 = U1 ;
    V0 = V1 ;
    % Progress
    ['Calculation ongoing : ',num2str(n/Nt*100),' %']
end


%% Storage - Boundaries of the Space Domain (for graphic rendering)
% Left
MUf(1, 2:Ny+1, :) = MUf(2, 2:Ny+1, :) ;
MVf(1, 2:Ny+1, :) = MVf(2, 2:Ny+1, :) ;    
% Right
MUf(Nx+2, 2:Ny+1, :) = MUf(Nx+1, 2:Ny+1, :) ;
MVf(Nx+2, 2:Ny+1, :) = MVf(Nx+1, 2:Ny+1, :) ;         
% Bottom
MUf(2:Nx+1, 1, :) = MUf(2:Nx+1, 2, :) ;
MVf(2:Nx+1, 1, :) = MVf(2:Nx+1, 2, :) ;        
% Top
MUf(2:Nx+1, Ny+2, :) = MUf(2:Nx+1, Ny+1, :) ;
MVf(2:Nx+1, Ny+2, :) = MVf(2:Nx+1, Ny+1, :) ; 
% Corners
MUf(1, 1, :) = 1/3*( MUf(1, 2, :) + MUf(2, 1, :) + MUf(2, 2, :) ) ;
MVf(1, 1, :) = 1/3*( MVf(1, 2, :) + MVf(2, 1, :) + MVf(2, 2, :) ) ;
MUf(Nx+2, Ny+2, :) = 1/3*( MUf(Nx+1, Ny+2, :) + MUf(Nx+2, Ny+1, :) + MUf(Nx+1, Ny+1, :) ) ;
MVf(Nx+2, Ny+2, :) = 1/3*( MVf(Nx+1, Ny+2, :) + MVf(Nx+2, Ny+1, :) + MVf(Nx+1, Ny+1, :) ) ;
MUf(1, Ny+2, :) = 1/3*( MUf(1, Ny+1, :) + MUf(2, Ny+2, :) + MUf(2, Ny+1, :) ) ;
MVf(1, Ny+2, :) = 1/3*( MVf(1, Ny+1, :) + MVf(2, Ny+2, :) + MVf(2, Ny+1, :) ) ;
MUf(Nx+2, 1, :) = 1/3*( MUf(Nx+2, 2, :) + MUf(Nx+1, 1, :) + MUf(Nx+1, 2, :) ) ;
MVf(Nx+2, 1, :) = 1/3*( MVf(Nx+2, 2, :) + MVf(Nx+1, 1, :) + MVf(Nx+1, 2, :) ) ;


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

