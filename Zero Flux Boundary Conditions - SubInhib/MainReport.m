%% --------------- Clear Workspace and close all figures ------------------
close all
clear 


%% ----------------------------- Load -------------------------------------
load SubInhib_Cheetah_P1


%% --------------------------- Resolution ---------------------------------
t1 = cputime ;
[xf,yf,tf,MUf,MVf] = FiniteDiffRK4( xmin, xmax, Nx, ymin, ymax, Ny , T, Nt, u_in, v_in, d, gamma, F, G) ;
tcpu = cputime-t1 ;


%% --------------------------- Animation ----------------------------------
Animate3(xf,yf,tf,MUf,MVf,animStep)


%% ----------------------------- Save -------------------------------------
% save('SubInhib_n.mat','xmin','xmax','Nx','ymin','ymax','Ny','T','Nt',...
%      'a','b','d','gamma','K','alpha','rho','u_in','v_in','F','G',...
%      'animStep','tcpu') ;

