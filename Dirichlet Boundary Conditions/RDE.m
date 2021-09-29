classdef RDE < handle
    %RDE Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        
        % Discretization of time domain
        T ;
        Nt ;
        dt ;
        tf ;
                
        % Discretization of x domain
        xmin ;
        xmax ;
        Nx ;
        dx ;
        x ;
        xf ;
        
        % Discretization of y domain
        ymin ;
        ymax ;
        Ny ;
        dy ;
        y ;
        yf ;
        
        % Simulation datat storage
        MUf ;
        MVf ;
        zmin ;
        zmax ;
        
        % Animation
        animStep ;
        
        % Recation terms
        F ;
        G ;
        
        % Equations
        gamma ;
        d ;
        A ;
        
        
        % Boundary conditions
        u_in ;
        v_in ;
        u_L ;
        u_R ;
        u_T ;
        u_B ;
        v_L ;
        v_R ;
        v_T ;
        v_B ;
        
        
    end
    
    methods
        
        function self = RDE(T,Nt,xmin,xmax,Nx,ymin,ymax,Ny)
            %RDE Construct an instance of this class
            %   Detailed explanation goes here
            
            % Input values
            self.T = T ;
            self.Nt = Nt ;
            self.Nx = Nx ;
            self.Ny = Ny ;
            self.xmin = xmin ;
            self.xmax = xmax ;
            self.ymin = ymin ;
            self.ymax = ymax ;
            
            % Discretization
                % t domain
            self.dt = T/Nt ;
            self.tf = 0:self.dt:T ;
                % x domain
            self.dx = (xmax-xmin)/(Nx+1);
            self.x = (xmin+self.dx:self.dx:self.xmax-self.dx)';
                % y domain            
            self.dy = (ymax-ymin)/(Ny+1) ;
            self.y = (ymin+self.dy:self.dy:ymax-self.dy) ;
            
            % Equation
                % Laplacian Matrix
            self.MatriceA
            
            % Simulaation data storage
            self.MUf = zeros(Nx+2, Ny+2, Nt+1) ;
            self.MVf = zeros(Nx+2, Ny+2, Nt+1) ;
            
            
            
        end
        
                
        function MatriceA(self)
            %MATRICEA  calculates the Nx*Ny matrix of 2D (minus) Laplacien operator
            % 

            I=-speye(self.Nx,self.Nx)/self.dy^2;
            B=(2/self.dx^2+2/self.dy^2)*sparse(1:self.Nx,1:self.Nx,1)-sparse(1:self.Nx-1,2:self.Nx,1,self.Nx,self.Nx)/self.dx^2-sparse(2:self.Nx,1:self.Nx-1,1,self.Nx,self.Nx)/self.dx^2;

            self.A=sparse(self.Nx*self.Ny,self.Nx*self.Ny);

            self.A(1:self.Nx,1:self.Nx)=B;
            self.A(1:self.Nx,self.Nx+(1:self.Nx))=I;
            for j=2:self.Ny-1
               self.A((j-1)*self.Nx+(1:self.Nx),(j-2)*self.Nx+(1:self.Nx))=I;
               self.A((j-1)*self.Nx+(1:self.Nx),(j-1)*self.Nx+(1:self.Nx))=B;
               self.A((j-1)*self.Nx+(1:self.Nx),j*self.Nx+(1:self.Nx))=I;
            end
            
        end
        
        
        function FiniteDiff(self)
            %FINITEDIFF solve the RDE equation
            
            % Initialization
            
                % u function
            U0 = self.u_in(self.x,self.y) ;
            self.MUf(2:self.Nx+1, 2:self.Ny+1, 1 ) = U0 ;
            U0 = reshape(U0,self.Nx*self.Ny,1) ;
            	% v function
            V0 = self.v_in(self.x,self.y) ;
            self.MVf(2:self.Nx+1, 2:self.Ny+1, 1 ) = V0  ;  
            V0 = reshape(V0,self.Nx*self.Ny,1) ;
            
            
            % Iterations
            for n = 1:self.Nt
                % Calculaation
                U1 = U0 + self.dt*self.gamma*self.F(U0,V0) - self.dt*self.A*U0 ;
                V1 = V0 + self.dt*self.gamma*self.G(U0,V0) - self.dt*self.d*self.A*V0 ;
                % Storage
                self.MUf(2:self.Nx+1, 2:self.Ny+1, n+1 ) = reshape(U1, self.Nx, self.Ny);
                self.MVf(2:self.Nx+1, 2:self.Ny+1, n+1 ) = reshape(V1, self.Nx, self.Ny);
                % Updating state vectors
                U0 = U1 ;
                V0 = V1 ;
                % Progress
                ['Calculation ongoing : ',num2str(n/self.Nt*100),' %']
            end



            % Complete resolution data
            % x vector
            self.xf = zeros(self.Nx+2,1);
            self.xf(2:self.Nx+1) = self.x;
            self.xf(1) = self.xmin;
            self.xf(self.Nx+2) = self.xmax;
            % y vector
            self.yf = zeros(self.Ny+2,1);
            self.yf(2:self.Ny+1) = self.y;
            self.yf(1) = self.ymin;
            self.yf(self.Nx+2) = self.ymax;

        end
        
        
        function [Cmap] = ColorMap(MU,MV)
            %COLORMAP Summary of this function goes here
            %   Detailed explanation goes here

            % Colors for u and v
                % Initialize
            cu = ones(1,1,3) ;
            cv = ones(1,1,3) ;
                % U --> red
            cu(1,1,:) = [1,0,0] ;
                % V --> blue
            cv(1,1,:) = [0,0,1] ; 


            % Get the size of the u and v matrices
            [nx, ny] = size(MU) ;
            if not([nx, ny] == size(MV))
                error('Size of MU and MV must be the same')
            end


            % Calculate the color map
            Cmap = max(MU.*cu , 0.5*MV.*cv) ;
            Cmap = Cmap./max(max(max(Cmap))) ;

        end
        
        
        function [] = Displot(self,i)
        %UNTITLED Summary of this function goes here
        %   Detailed explanation goes here

            self.Nt = length(self.tf) ;

            s1 = subplot(2,2,1) ;
            surf(self.xf, self.yf, self.MUf(:,:,i)', 'EdgeColor', 'None')
            colormap(s1, jet)
            title(strcat('Temps = ',num2str((i-1)/self.Nt*100),' %'))
            xlabel('x')
            ylabel('y')
            zlabel('u(x,y,t)')
            view(0,90)

            s2 = subplot(2,2,3);
            surf(self.xf, self.yf, self.MVf(:,:,i)','EdgeColor', 'None')
            colormap(s2, parula)
            title(strcat('Temps = ',num2str((i-1)/self.Nt*100),' %'))
            xlabel('x')
            ylabel('y')
            zlabel('v(x,y,t)')
            view(0,90)


            subplot(2,2,[2,4])
            Cmap = ColorMap(self.MUf(:,:,i)'/self.zmax, self.MVf(:,:,i)'/self.zmax) ;
            imagesc(self.xf, self.yf, Cmap)
            title(strcat('Temps = ',num2str((i-1)/self.Nt*100),' %'))
            xlabel('x')
            ylabel('y')
            zlabel('color plot')
            
        end
        
        
        function [] = Animate(self)
            %ANIMATE Summary of this function goes here
            %   Detailed explanation goes here

            figure('units','normalized','outerposition',[0 0 1 1])


            zmin_U = min([min(min(min(self.MUf))),min(min(min(self.MUf)))]) ;
            zmax_U = max([max(max(max(self.MUf))),max(max(max(self.MUf)))]) ;
            zmin_V = min([min(min(min(self.MVf))),min(min(min(self.MVf)))]) ;
            zmax_V = max([max(max(max(self.MVf))),max(max(max(self.MVf)))]) ;
            self.zmax = max(zmax_U, zmax_V) ;
            self.zmin = min(zmin_U, zmin_V) ;

            for i = 1:self.animStep:length(self.tf)
                self.Displot(i)
                pause(0.05)
            end

        end
        
        
        
        
        
    end
end


