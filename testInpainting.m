% testInpainting.m
% 
% The test (demo) script for inpainting.m

clear

%% parameters section %% 
TestImgName = 'lena';
psz = 15; % patch size

inputImg = imread('lena.bmp','BMP');
mask = imread('mask.bmp','BMP');
maskedImg = mask;

outputImg = inpainting(inputImg, mask, psz);

figure(1), imshow(inputImg)
figure(2), imshow(mask)
figure(3), imshow(inputImg)

