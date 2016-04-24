

clear all;
close all;

%% Constants and image
userInputPoint = [0.2 0.2];
fieldToFindTracks = 4;

imageName = 'images/farm.PNG';
I = im2double(imread(imageName));

%% Generating data - The important part

[fieldAreas, gradientImage] = processImage(I);

whichFieldIsPoint(fieldAreas, userInputPoint)

vectors = findTracksInField(gradientImage, fieldAreas, fieldToFindTracks);

%% Draw debugg image

sHitI = size(gradientImage);
hitI2(sHitI(1), sHitI(2)) = 0;

sV = size(vectors);
for i = 2:sV(1)
    fVec(1) = vectors(i,2,1); fVec(2) = vectors(i,1,1);
    tVec(1) = vectors(i,2,2); tVec(2) = vectors(i,1,2);
    hitI2 = drawLine(hitI2, fVec, tVec, 20,0);
    
end

figure(1);
imshow(hitI2);

%% Example of how to find field from point

'Field that is selected in app:'
whichFieldIsPoint(fieldAreas, userInputPoint)