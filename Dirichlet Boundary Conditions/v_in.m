function [ U ] = v_in( x,y,Nx,Ny )

x0 = -0.5 ;
y0 = -0.5 ;
sigma = 0.1^2 ;

%U = 0.0002*exp(-(abs(repmat(x,1,Ny)-x0).^2 + abs(repmat(y,Nx,1)-y0).^2)/sigma-1) ;
%U = 0.6*abs(sin(2*pi.*( (repmat(x,1,Ny)-x0).^2 + (repmat(y,Nx,1)-y0).^2 ))) ;
%U = 1.2*abs(x+y) ;
U = 0.5*sin( 3*pi .* repmat(y,Nx,1) ).*sin( 3*pi .* repmat(x,1,Ny) ) ;


U = reshape(U,Nx*Ny,1) ;


end

