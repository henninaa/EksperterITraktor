function [ seeds ] = generateSeedPoints( dimentions, resolution )
%GENERATESEEDPOINTS Summary of this function goes here
%   Detailed explanation goes here

numberx = floor(dimentions(1)/resolution);
numbery = floor(dimentions(2)/resolution);

seeds(numberx + numbery,2) = 0;

n = 0;

    for i = 0:(numberx-1)
        
        for j = (0:numbery-1)
            n = n+1;
            seeds(n,:) = [(i*resolution +1), (j*resolution +1)];
            
        end
    end

end

