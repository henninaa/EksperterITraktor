function [ out ] = morphClose( I, SE)
%MORPHCLOSE Summary of this function goes here
%   Detailed explanation goes here

s = size(I);

out = I;

for i = 1:s(1)
out1(:,:) = I(i,:,:);
out1 = imdilate(out1, SE);
out1 = imerode(out1, SE);

out(i,:,:) = out1;

end

end

