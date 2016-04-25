function [ linesV, hitI ] = findLines( I )
%FINDLINES Summary of this function goes here
%   Detailed explanation goes here

s = size(I);

hitI(s(1),s(2)) = 0;
linesV(1,:,:) = [0 0;
                 0 0];
lines(1) = 0;

it = 0;

turnMatrix = [0 1;
                1 0];

for i = 1:s(2);
    for j = 1:s(1)
        if I(j,i) == 1
           if  hitI(j,i) == 1
               YE = 0;
               continue;
           end
            points = findCircularPoints(I,i,j,10,30);
            
            s_points = size(points);
            
            for k = 2:s_points(1)
                if  hitI(j,i) == 0
                [hit, fVec, tVec] = checkIfLine(I,i,j,points(k,1),points(k,2), 5, 180, 8);
                if hit == 1 && hitI(tVec(2), tVec(1)) == 0
                    
                    linesV(end + 1,:,:) = [fVec tVec];
                    fVec = turnMatrix * fVec;
                    tVec = turnMatrix * tVec;
                    hitI = drawLine(hitI, fVec, tVec, 120, 10);
                    continue;
                    
                end
                else
                    YE = 0;
                end
                
            end
            
        end
        
    end
end
linesV;
end

