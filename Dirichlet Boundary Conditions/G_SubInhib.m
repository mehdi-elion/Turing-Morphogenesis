function [ Fres ] = G_SubInhib(u,v,b,rho,alpha,K)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

Fres = alpha*(b-v) - rho*u.*v ./ (1 + u + K*u.^2) ;



end

