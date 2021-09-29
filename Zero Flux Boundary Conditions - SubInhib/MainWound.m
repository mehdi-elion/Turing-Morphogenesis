%% --------------- Clear Workspace and close all figures ------------------
close all
clear 


%% ----------------------------- Load -------------------------------------
load SubInhib_Cheetah_P1
load Wound_Cheetah_P1


%% -------------------------- Artificial Wound ----------------------------
Uin = U_cheetah(2:Nx+1,2:Ny+1) ;
Uin(25:75,25:75) = Uin(25:75,25:75) .* (1.5*rand(51,51));
Vin = V_cheetah(2:Nx+1,2:Ny+1) ;
Vin(25:75,25:75) = Vin(25:75,25:75) .* (1.5*rand(51,51));


%% --------------------------- Resolution ---------------------------------
t1 = cputime ;
[xf,yf,tf,MUf,MVf] = FiniteDiffRK4Wound( xmin, xmax, Nx, ymin, ymax, Ny , T, Nt, Uin, Vin, d, gamma, F, G) ;
tcpu = cputime-t1 ;


%% --------------------------- Animation ----------------------------------
%Animate3(xf,yf,tf,MUf,MVf,animStep)


%% ----------------------------- Save -------------------------------------
% save('SubInhib_n.mat','xmin','xmax','Nx','ymin','ymax','Ny','T','Nt',...
%      'a','b','d','gamma','K','alpha','rho','u_in','v_in','F','G',...
%      'animStep','tcpu') ;

