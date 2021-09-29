function [ Fres ] = F_SubInhib(u,v,a,rho,K)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

Fres = a - u - rho*u.*v ./ (1 + u + K*u.^2) ;

end

