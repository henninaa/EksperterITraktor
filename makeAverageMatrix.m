function [ out ] = makeAverageMatrix( dimention )
%MAKEAVERAGEMATRIX Summary of this function goes here
%   Detailed explanation goes here
    
    out(dimention, dimention) = 1;
    out(:,:) = 1;

    out = out / (dimention^2);


end

