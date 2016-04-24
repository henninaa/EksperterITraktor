function [ outList ] = equalizeSize( list, seedList )
%EQUALIZESIZE Summary of this function goes here
%   Detailed explanation goes here
   
s = size(list);
minS = inf;
minL = 1;

for i = 1:s(1)
    
    stmp = size(list(i,:,:,:));
    
    if stmp(1) <= minS
        minS = stmp(1);
        minL = i;
    end
    
end

seedsToUse = seedList(minS,:);
number = 0;

for i = 1:s(1)
    
    stmp2 = size(list(i,:,:,:));
    number = 0;
    
    for j = 1:stmp2(1)
        
        if isIn(seedList(i,j,:),seedList)
           
            number = number+1;
            outList(i,number,:,:) = list(i,j,:,:);
            
        end
        
    end
    
    
end

end

