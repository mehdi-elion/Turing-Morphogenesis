function A=MatriceA(Nx,dx,Ny,dy)

% Return the Nx*Ny matrix of 2D (plus) Laplacien operator

I=-speye(Nx,Nx)/dy^2;
B=(2/dx^2+2/dy^2)*sparse(1:Nx,1:Nx,1)-sparse(1:Nx-1,2:Nx,1,Nx,Nx)/dx^2-sparse(2:Nx,1:Nx-1,1,Nx,Nx)/dx^2;

A=sparse(Nx*Ny,Nx*Ny);

A(1:Nx,1:Nx)=B;
A(1:Nx,Nx+(1:Nx))=I;
for j=2:Ny-1
   
   A((j-1)*Nx+(1:Nx),(j-2)*Nx+(1:Nx))=I;
   A((j-1)*Nx+(1:Nx),(j-1)*Nx+(1:Nx))=B;
   A((j-1)*Nx+(1:Nx),j*Nx+(1:Nx))=I;
    
    
end


A((Ny-1)*Nx+(1:Nx),(Ny-1)*Nx+(1:Nx))=B;
A((Ny-1)*Nx+(1:Nx),(Ny-2)*Nx+(1:Nx))=I;

A=-sparse(A);

%C=sparse(1:Nx*Ny,1:Nx*Ny,C);