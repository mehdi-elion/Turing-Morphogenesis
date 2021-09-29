%% --------------- Clear Workspace and close all figures ------------------
close all
clear 


%% --------------- Discretization of Time & 2D space ----------------------

% Discretization of time domain
T = 0.10;
Nt = 20000;
animStep = 40 ;

% Discretization of x domain
xmin = -1;
xmax = 1;
Nx = 100;

% Discretization of y domain
ymin = -1;
ymax = 1;
Ny = 100;


%% --------------------------- Resolution ---------------------------------
[xf,yf,tf,MUf,MVf] = FiniteDiffSubInhib(xmin,xmax,Nx, ymin,ymax,Ny, T,Nt, @u_in,@v_in, @u_L,@u_R,@u_T,@u_B, @v_L,@v_R,@v_T,@v_B) ;


%% --------------------------- Animation ----------------------------------
Animate(xf,yf,tf,MUf,MVf,animStep)


















%% Animation (first script)
% zmin_U = min([min(min(min(MUf))),min(min(min(MUf)))]) ;
% zmax_U = max([max(max(max(MUf))),max(max(max(MUf)))]) ;
% zmin_V = min([min(min(min(MVf))),min(min(min(MVf)))]) ;
% zmax_V = max([max(max(max(MVf))),max(max(max(MVf)))]) ;
% zmax = max(zmax_U, zmax_V) ;
% zmin = min(zmin_U, zmin_V) ;
%
% figure('units','normalized','outerposition',[0 0 1 1])
% for i = 1:animStep:Nt
%     
%     s1 = subplot(2,2,1) ;
%     surf(xf, yf, MUf(:,:,i)', 'EdgeColor', 'None')
%     colormap(s1, jet)
%     title(strcat('Temps = ',num2str((i-1)/Nt*100),' %'))
%     xlabel('x')
%     ylabel('y')
%     zlabel('u(x,y,t)')
%     view(0,90)
%     
%     s2 = subplot(2,2,3);
%     surf(xf, yf, MVf(:,:,i)','EdgeColor', 'None')
%     colormap(s2, parula)
%     title(strcat('Temps = ',num2str((i-1)/Nt*100),' %'))
%     xlabel('x')
%     ylabel('y')
%     zlabel('v(x,y,t)')
%     view(0,90)
%     
%     
%     subplot(2,2,[2,4])
%     Cmap = ColorMap(MUf(:,:,i)'/zmax, MVf(:,:,i)'/zmax) ;
%     imagesc(xf, yf, Cmap)
%     title(strcat('Temps = ',num2str((i-1)/Nt*100),' %'))
%     xlabel('x')
%     ylabel('y')
%     zlabel('color plot')
%     
%     
%     pause(0.05)
% end



