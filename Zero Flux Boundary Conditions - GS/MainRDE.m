%% ------------------------ Clean things up -------------------------------
clear 
close all


%% ------------------------ Discretization --------------------------------

% Discretization of time domain
T = 0.10;
Nt = 20000;

% Discretization of x domain
xmin = -1;
xmax = 1;
Nx = 100;

% Discretization of y domain
ymin = -1;
ymax = 1;
Ny = 100;

% Animation
animStep = 40 ;


%% ----------------- Declare an instance of RDE class ---------------------
Simu = RDE(T,Nt,xmin,xmax,Nx,ymin,ymax,Ny) ;


%% --------------------- Equation Parameters ------------------------------
Simu.d = 12.5 ;
Simu.gamma = 0.6 ;


%% ----------------- Initial & Boundary Conditions ------------------------
Simu.u_in = @(x,y) 0.5*sin( 2*pi .* repmat(x,1,Ny) ).*sin( 2*pi .* repmat(y,Nx,1) ) ;
Simu.v_in = @(x,y) 0.5*sin( 3*pi .* repmat(y,Nx,1) ).*sin( 3*pi .* repmat(x,1,Ny) ) ;


%% ------------------------- Reaction Terms -------------------------------

%--------- Substrate Inhibition -----------
% Parameters
a = 2.6 ;
b = 1.5 ;
K = 10 ;
alpha = 4.5 ;
rho = 8.1 ;
% Functions
Simu.F = @(u,v) a - u - rho*u.*v ./ (1 + u + K*u.^2) ;
Simu.G = @(u,v) alpha*(b-v) - rho*u.*v ./ (1 + u + K*u.^2) ;



%% --------------------------- Resolution ---------------------------------
Simu.FiniteDiff()


%% --------------------------- Animation ----------------------------------
Simu.animStep = 40 ;
Simu.Animate()






