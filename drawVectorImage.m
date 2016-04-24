function [ hitI2 ] = drawVectorImage( vectors,  sHitI)
%DRAWVECTORIMAGE Summary of this function goes here
%   Detailed explanation goes here

hitI2(sHitI(1), sHitI(2)) = 0;

sV = size(vectors);
for i = 1:sV(1)
    fVec(1) = vectors(i,2,1); fVec(2) = vectors(i,1,1);
    tVec(1) = vectors(i,2,2); tVec(2) = vectors(i,1,2);
    hitI2 = drawLine(hitI2, fVec, tVec, 20,0);
    
end


end

