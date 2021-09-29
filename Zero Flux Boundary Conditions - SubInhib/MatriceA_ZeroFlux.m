function A = MatriceA_ZeroFlux(Nx,dx,Ny,dy)
% Returns the Nx*Ny matrix of 2D (plus) Laplacien operator in the case of
% zeros flux boundary condtions

% Block matrices 
I = 1/dy^2 * speye(Nx,Nx) ;
D = 1/dx^2 * ( sparse(1:Nx-1,2:Nx,1,Nx,Nx) + sparse(2:Nx,1:Nx-1,1,Nx,Nx) ) ;
C1 = sparse( diag( [-1/dx^2-1/dy^2, (-2/dx^2-1/dy^2)*ones(1,Nx-2), -1/dx^2-1/dy^2] ) ) ;
C0 = sparse( diag( [-1/dx^2-2/dy^2, (-2/dx^2-2/dy^2)*ones(1,Nx-2), -1/dx^2-2/dy^2] ) ) ;
B1 = C1 + D ;
B0 = C0 + D ;

% Initialize Laplatian zero flux matrix
A=sparse(Nx*Ny,Nx*Ny) ;

% Fill in the matrix
A(1:Nx,1:Nx) = B1 ;
A(1:Nx,Nx+(1:Nx)) = I ;

for j=2:Ny-1  
   A((j-1)*Nx+(1:Nx),(j-2)*Nx+(1:Nx)) = I ;
   A((j-1)*Nx+(1:Nx),(j-1)*Nx+(1:Nx)) = B0 ;
   A((j-1)*Nx+(1:Nx),j*Nx+(1:Nx)) = I ;   
end

A((Ny-1)*Nx+(1:Nx),(Ny-1)*Nx+(1:Nx)) = B1 ;
A((Ny-1)*Nx+(1:Nx),(Ny-2)*Nx+(1:Nx)) = I ;

A = sparse(A);

end

