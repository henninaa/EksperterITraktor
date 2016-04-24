function [ Io ] = drawLine( I, sPoint, ePoint, width, buffer )
%DRAWLINE Summary of this function goes here
%   Detailed explanation goes here

s = size(I);
Io = I;

x = sPoint(1);
y = sPoint(2);

dir = ePoint - sPoint;
len = norm(dir);
dir = (dir/len)/2;

x = x - (dir(1)*(buffer/2));
y = y - (dir(2)*(buffer/2));

halfWidth = floor(width/2);

normal(1) = -dir(2);

normal(2) = dir(1);

done = 0;

while done == 0

            
    for i = -halfWidth:halfWidth
       
        xNorm = floor(x + (normal(1)*i));
        yNorm = floor(y + (normal(2)*i));
        
        if xNorm <1 || xNorm > s(1) || yNorm <1 || yNorm > s(2)
            continue;
        end
        
        Io(xNorm, yNorm) = 1;
        
    end
    
    
    x = x + dir(1);
    y = y + dir(2);
    
    if (sqrt((x - sPoint(1))^2 + (y - sPoint(2))^2)) > (len + buffer)
        done = 1;
    end
    
end
end

