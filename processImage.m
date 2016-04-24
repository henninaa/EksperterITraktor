function [ allFieldAreas, gradientImage ] = processImage( image, demo )
%PROCESSIMAGE Summary of this function goes here
%   Detailed explanation goes here

I = image;
factor = 5;

I2 = lowerResolution(I,factor);

s = size(I);


% po = [
%     1 1 1 1 1 1;
%     1 1 1 1 1 1;
%     1 1 1 1 1 1;
%     1 1 1 1 1 1;
%     1 1 1 1 1 1;
%     1 1 1 1 1 1];
po = [
    1 1;
    1 1];



%I_s_l = I;

I_s_l = nonlinearStretch(I,2,0.1,0.53);

treshold = 0.1;
c = 1;
gamma = 0.8;

gammaImg = I_s_l .* (c);

for i = 1:s(1)
    for j = 1:s(2)
       I_s_l(i,j,:) = gammaImg(i,j,:).^gamma;
    end
end

scale = 1.3;
xs = 1*scale;
ys = 1*scale;

s_x = [
    -1 0 1;
    -2 0 2;
    -1 0 1]*xs;
s_y = [
    -1 -2 -1;
     0  0  0;
     1  2  1]*ys;

convImgGradx_r = ConvolutionGray(I_s_l(:,:,1),s_x);
convImgGradx_g = ConvolutionGray(I_s_l(:,:,2),s_x);
convImgGradx_b = ConvolutionGray(I_s_l(:,:,3),s_x);

convImgGrady_r = ConvolutionGray(I_s_l(:,:,1),s_y);
convImgGrady_g = ConvolutionGray(I_s_l(:,:,2),s_y);
convImgGrady_b = ConvolutionGray(I_s_l(:,:,3),s_y);

convImgGradx = abs(convImgGradx_r) + abs(convImgGradx_g) + abs(convImgGradx_b);
convImgGrady = abs(convImgGrady_r) + abs(convImgGrady_g) + abs(convImgGrady_b);

convImgGrad = convImgGrady;

for i = 1:s(1)
    for j = 1:s(2)
        
        if (abs((convImgGradx(i,j)))+abs((convImgGrady(i,j))))*4>=treshold
            convImgGrad(i,j) = 1;
        else
            convImgGrad(i,j) =0;
        end
    end
end

SE = strel('square',3);

A = convImgGrad;

A = imerode(convImgGrad, SE);
A = imdilate(A, SE);

SE = strel('square',5);

A = imdilate(A, SE);
A = imerode(A, SE);

SE = strel('diamond',3);

AC = convImgGrad;
AC = imdilate(convImgGrad, SE);
AC = imerode(AC, SE);

AV_P = makeAverageMatrix( 5 );


I_AV = I;
A_AV = ConvolutionRGB(I2,AV_P);
%A_AV = ConvolutionRGB(A_AV,AV_P);

%growT = 0.0139;
growT = 0.012;
sizeT = 2000;

si2 = size(I2);

seeds = generateSeedPoints(si2, 50);

[A_GG_R, nope,B_GG_R] = regionGrow(A_AV(:,:,1), seeds, growT, sizeT);
[A_GG_G, nope,B_GG_G] = regionGrow(A_AV(:,:,2), seeds, growT, sizeT);
[A_GG_B, nope,B_GG_B] = regionGrow(A_AV(:,:,3), seeds, growT, sizeT);

A_GG = A_GG_R .* A_GG_G .* A_GG_B;

SE = strel('square',5);

A_GGC = morphClose( A_GG,SE );

gradientImage = A;

allFieldAreas = A_GGC;

end

