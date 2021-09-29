function [ xf, yf, tf, MUf, MVf  ] = FiniteDiff( xmin, xmax, Nx, ymin, ymax, Ny , T, Nt, u_in, v_in, d, gamma, F, G)

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




%% Resolution

% Storage 
MUf = zeros(Nx+2, Ny+2, Nt+1) ;
MVf = zeros(Nx+2, Ny+2, Nt+1) ;

% Initialization
    % u function
U0 = u_in(x,y) ;
MUf(2:Nx+1, 2:Ny+1, 1 ) = U0 ;
U0 = reshape(U0,Nx*Ny,1) ;
    % u function
V0 = v_in(x,y) ;
MVf(2:Nx+1, 2:Ny+1, 1 ) = V0 ;  
V0 = reshape(V0,Nx*Ny,1) ;

% Iterations
for n = 1:Nt
    % Calculation
    U1 = U0 + dt*gamma*F(U0,V0) + dt*A*U0 ;
    V1 = V0 + dt*gamma*G(U0,V0) + dt*d*A*V0 ;
    % Storage
    MUf(2:Nx+1, 2:Ny+1, n+1 ) = reshape(U1, Nx, Ny) ;
    MVf(2:Nx+1, 2:Ny+1, n+1 ) = reshape(V1, Nx, Ny) ;
    % Storage - Boundaries of the Space Domain (for graphic rendering)
        % Left
    MUf(1, 2:Ny+1, n+1) = MUf(2, 2:Ny+1, n+1) ;
    MVf(1, 2:Ny+1, n+1) = MVf(2, 2:Ny+1, n+1) ;    
        % Right
	MUf(Nx+2, 2:Ny+1, n+1) = MUf(Nx+1, 2:Ny+1, n+1) ;
    MVf(Nx+2, 2:Ny+1, n+1) = MVf(Nx+1, 2:Ny+1, n+1) ;         
        % Bottom
    MUf(2:Nx+1, 1, n+1) = MUf(2:Nx+1, 2, n+1) ;
    MVf(2:Nx+1, 1, n+1) = MVf(2:Nx+1, 2, n+1) ;        
        % Top
    MUf(2:Nx+1, Ny+2, n+1) = MUf(2:Nx+1, Ny+1, n+1) ;
    MVf(2:Nx+1, Ny+2, n+1) = MVf(2:Nx+1, Ny+1, n+1) ; 
        % Corners
    MUf(1, 1, n+1) = 1/3*( MUf(1, 2, n+1) + MUf(2, 1, n+1) + MUf(2, 2, n+1) ) ;
    MVf(1, 1, n+1) = 1/3*( MVf(1, 2, n+1) + MVf(2, 1, n+1) + MVf(2, 2, n+1) ) ;
    MUf(Nx+2, Ny+2, n+1) = 1/3*( MUf(Nx+1, Ny+2, n+1) + MUf(Nx+2, Ny+1, n+1) + MUf(Nx+1, Ny+1, n+1) ) ;
    MVf(Nx+2, Ny+2, n+1) = 1/3*( MVf(Nx+1, Ny+2, n+1) + MVf(Nx+2, Ny+1, n+1) + MVf(Nx+1, Ny+1, n+1) ) ;
    MUf(1, Ny+2, n+1) = 1/3*( MUf(1, Ny+1, n+1) + MUf(2, Ny+2, n+1) + MUf(2, Ny+1, n+1) ) ;
    MVf(1, Ny+2, n+1) = 1/3*( MVf(1, Ny+1, n+1) + MVf(2, Ny+2, n+1) + MVf(2, Ny+1, n+1) ) ;
    MUf(Nx+2, 1, n+1) = 1/3*( MUf(Nx+2, 2, n+1) + MUf(Nx+1, 1, n+1) + MUf(Nx+1, 2, n+1) ) ;
    MVf(Nx+2, 1, n+1) = 1/3*( MVf(Nx+2, 2, n+1) + MVf(Nx+1, 1, n+1) + MVf(Nx+1, 2, n+1) ) ;
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
yf(Nx+2) = ymax;



end

