function [ selectedField ] = whichFieldIsPoint( images, point )
%WHICHFIELDISPOINT Summary of this function goes here
%   Detailed explanation goes here

s = size(images);

selectedField = -1;

if point(1) < 1
   
    point(1) = round(s(3) * point(1));
    point(2) = round(s(2) * point(2));
    
end

for i = 1:s(1)
   
   if images(i, point(2), point(1)) == 1
       selectedField = i;
       break;
   end
    
end


end

