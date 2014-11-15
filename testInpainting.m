clear

%% parameters
testImageName = 'bungee'; % cow or bungee or man
psz = 9; % patch size ( to be inpainted in inpainting)

testImagePath = '~/Documents/MATLAB/AutoShared/testimages/Petter_Strandmark/';
testImageSource = fullfile(testImagePath,testImageName);

origImg = imread([testImageSource,'.png']);

img = origImg;
mask = imread([testImageSource,'-mask.png']);
mask(mask==255) = 1;

%% maskedImg creation
Rimg = img(:,:,1); Rimg(mask==1) = 0; img(:,:,1) = Rimg;
Gimg = img(:,:,2); Gimg(mask==1) = 255; img(:,:,2) = Gimg;
Bimg = img(:,:,3); Bimg(mask==1) = 0; img(:,:,3) = Bimg;
tmpImgFileName = [testImageName,'_masked.bmp'];
imwrite(img,tmpImgFileName,'BMP');

fillFilename = tmpImgFileName;

tic
[inpaintedImg,c,d,fillingMovie] = inpainting(origImg,fillFilename,[0 255 0],psz);
toc
mask_ = uint8(~mask);
maskedImg = repmat(mask_,[1,1,3]).*origImg;

figure(1),imshow(uint8(origImg)),title('Original Image')
figure(2),imshow(uint8(maskedImg)),title('Masked Image')
figure(3),imshow(uint8(inpaintedImg)),title('Inpainted Image')
folderName = ['myresults/',datestr(now,'yymmdd-HHMMSS'),'_',testImageName];
mkdir(folderName)

imwrite(uint8(origImg),fullfile(folderName,'origImg.bmp'),'BMP');
imwrite(uint8(maskedImg),fullfile(folderName,'maskedImg.bmp'),'BMP');
imwrite(uint8(inpaintedImg),fullfile(folderName,'inpaintedImg.bmp'),'BMP');
