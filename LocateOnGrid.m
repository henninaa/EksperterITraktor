function [ locations ] = locateOnGrid( circles, gridsize )
%LOCATEONGRID Summary of this function goes here
%   Detailed explanation goes here

s = size(circles);

for i = 1:s(1)
    
   locations(i,1) = (circles(i,1)-(gridsize/2))/gridsize;
   locations(i,2) = (circles(i,2)-(gridsize/2))/gridsize;
    
end

end

