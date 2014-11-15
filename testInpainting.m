% testInpainting.m
% 
% The test (demo) script for inpainting.m

clear

%% parameters section %% 
TestImgName = 'lena';
psz = 15; % patch size

inputImg = rgb2gray(imread('lena.bmp','BMP')); % uint8


mask = imread('mask.bmp','BMP'); % uint8

mask(mask==255) = 1;
maskedImg = mask.*inputImg;

outputImg = inpainting(inputImg, mask, psz);
outputImg = uint8(outputImg);

figure(1), imshow(inputImg)
figure(2), imshow(maskedImg)
figure(3), imshow(outputImg)

