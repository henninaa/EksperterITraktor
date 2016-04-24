function [ vectors, Ihit ] = findTracksInField( gradientImage, fieldAreas, selectedField )
%FINDTRACKSIFIELD Summary of this function goes here
%   Detailed explanation goes here

field(:,:) = fieldAreas(selectedField, :,:);

BOM = maskImageG(gradientImage, field, 5);

[vectors, Ihit] = findLines(BOM);

vectors = filterVectors(vectors, 1, pi/28);

end

