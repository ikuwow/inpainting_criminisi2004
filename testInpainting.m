clear

%% parameters
testImageName = 'bungee'; % cow or bungee or man
psz = 9; % patch size ( to be inpainted in inpainting)

testImagePath = '~/Documents/MATLAB/AutoShared/testimages/Petter_Strandmark/';
testImageSource = fullfile(testImagePath,testImageName);

origImg = imread([testImageSource,'.png']);

mask = imread([testImageSource,'-mask.png']);
mask(mask==255) = 1;

tic
%output is fix!
[inpaintedImg,c,d,fillingMovie] = inpainting(origImg,mask,psz);
toc
maskedImg = repmat(uint8(~mask),[1,1,3]).*origImg;

figure(1),imshow(uint8(origImg)),title('Original Image')
figure(2),imshow(uint8(maskedImg)),title('Masked Image')
figure(3),imshow(uint8(inpaintedImg)),title('Inpainted Image')
folderName = ['myresults/',datestr(now,'yymmdd-HHMMSS'),'_',testImageName];
mkdir(folderName)

imwrite(uint8(origImg),fullfile(folderName,'origImg.bmp'),'BMP');
imwrite(uint8(maskedImg),fullfile(folderName,'maskedImg.bmp'),'BMP');
imwrite(uint8(inpaintedImg),fullfile(folderName,'inpaintedImg.bmp'),'BMP');
