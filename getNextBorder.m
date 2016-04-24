function [ y,x ] = getNextBorder(I, x_s, y_s, direction )
%GETNEXTBORDER Summary of this function goes here
%   Detailed explanation goes here

s = size(I);

while I(y_s,x_s) == 1
    
    
    x_s = x_s + direction(2);
    y_s = y_s + direction(1);
    
    if(x_s == 1 || x_s == s(2) || y_s == 1 || y_s == s(1))
        
        break;
    end
    
end

while I(y_s,x_s) == 0
    
    x_s = x_s + direction(2);
    y_s = y_s + direction(1);
    
    if(x_s == 1 || x_s == s(2) || y_s == 1 || y_s == s(1))
        
        break;
    end
    
end

[y, x] = midleOfBorder(I,y_s,x_s);

end

