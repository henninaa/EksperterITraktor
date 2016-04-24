function [ outVecs ] = filterVectors( vectors, length, angleFromAv )
%FILTERVECTORS Summary of this function goes here
%   Detailed explanation goes here

s = size(vectors);
lengths(s(1)) = 0;
angles(s(1)) = 0;

avAngle = 0;

for i = 2:s(1)
    
    fVec(1) = vectors(i,2,1); fVec(2) = vectors(i,1,1);
    tVec(1) = vectors(i,2,2); tVec(2) = vectors(i,1,2);
    
    dir = tVec - fVec;
    angle = atan2(dir(2), dir(1));
    avAngle = avAngle + angle;
    angles(i) = angle;
    
    lengths(i) = sqrt((dir(1)^2)+(dir(2)^2));
    
end

if s(1) > 15
total = 0;
n = 0;

sortedAngles = sort(angles);

for i = 8:(s(1)-7)
   
    total = total + sortedAngles(i);
    n = n+1;
    
end

avAngle = total/n;

else
avAngle = avAngle/(s(1)-1);
angleFromAv = angleFromAv*20;

end
outVecs(1,:,:) = [ 0 0;
                    0 0];
n = 0;
for i = 2:s(1)

    if abs(avAngle - angles(i)) <= abs(angleFromAv) && lengths(i) >= length
        n = n+1;
        outVecs(n,:,:) = vectors(i,:,:);
        
    end
    
end

