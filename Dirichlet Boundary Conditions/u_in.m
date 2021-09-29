function [ U ] = u_in( x,y,Nx,Ny )

x0 = +1 ;
y0 = +0.5 ;
sigma = 0.1^2 ;

%U = 0.001*exp(-(abs(repmat(x,1,Ny)-x0).^2 + abs(repmat(y,Nx,1)-y0).^2)/sigma-1) ;
%U = 0.3*abs(cos( 1*pi .* ( ((repmat(x,1,Ny)-x0).^2 + (repmat(y,Nx,1)-y0).^2 )))) ;
U = 0.5*sin( 2*pi .* repmat(x,1,Ny) ).*sin( 2*pi .* repmat(y,Nx,1) ) ;

U = reshape(U,Nx*Ny,1) ;


end

