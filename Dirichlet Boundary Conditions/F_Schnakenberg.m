function [ Fres ] = F_Schnakenberg(u,v,a)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

Fres = a - u + (u.^2).*v ;

end

