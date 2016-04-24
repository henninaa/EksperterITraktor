function [ result ] = maskImageG( I,mask,factor )
%MASKIMAGERGB Summary of this function goes here
%   Detailed explanation goes here

result = I;
S_m = size(I);
S_f = size(mask);

for i = 1:S_m(1)
    ii = ceil(i/factor);
    for j = 1:S_m(2)
        jj = ceil(j/factor);
            
        if ii > S_f(1)
            result(i,j) = 0;
        elseif jj > S_f(2)
            result(i,j) = 0;
        else
            result(i,j) = I(i,j) * mask(ii,jj);
        end
        
        
    end
end

end

