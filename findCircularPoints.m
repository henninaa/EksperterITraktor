function [ points ] = findCircularPoints(I, x_c, y_c, r, numberOfPoints )
%FINDCIRCULARPOINTS Summary of this function goes here
%   Detailed explanation goes here

s = size(I);
step = (pi)/numberOfPoints;
k = 1;

points(1,2) = 0.0;

for i = -(pi/2):step:(pi/2)
    
    x_s = int32(x_c + r*cos(i));
    y_s = int32(y_c + r*sin(i));
    
    if x_s <1 || x_s >s(2) || y_s < 1 || y_s > s(1)
        continue;
    end
    
    if I(y_s,x_s) == 1
       points(end +1,:) = [x_s,y_s]; 
       k = k+1;
    end

end


end

