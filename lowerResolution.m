function [ lowRes ] = lowerResolution( I, factor)
%LOWER Summary of this function goes here
%   Detailed explanation goes here

s = size(I);

topX = floor(s(1)/factor);
topY = floor(s(2)/factor);

lowRes(topX,topY,3) = 0;

for i = 0:(topX-1)
    
    for j = 0:(topY-1)

            lowRes(i+1,j+1,:) = I(i*factor + 1,j*factor + 1,:);
        
    end
end

end

