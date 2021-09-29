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

