function [fieldAreas, gradientImage] = processOffline( )
%PROCESSOFFLINE Summary of this function goes here
%   Detailed explanation goes here


imageName = 'images/farm.PNG';
I = im2double(imread(imageName));

 [fieldAreas, gradientImage] = processImage(I, true);


end

