function [ result ] = maskImageRGB( I,mask,factor )
%MASKIMAGERGB Summary of this function goes here
%   Detailed explanation goes here

result = I;
S_m = size(I);
S_f = size(mask);

for i = 1:S_m(1)
    ii = ceil(i*factor);
    for j = 1:S_m(2)
        jj = ceil(j*factor);
        
        for x = 1:S_m(3)
            
        if ii > S_f(1)
            result(i,j,x) = 0;
        elseif jj > S_f(2)
            result(i,j,x) = 0;
        else
            result(i,j,x) = I(i,j,x) * mask(ii,jj);
        end
        
        end
        
    end
end

end

