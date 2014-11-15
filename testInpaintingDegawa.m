clear

testImageName = 'cow'; % cow or bungee or man

testImagePath = '~/Documents/MATLAB/AutoShared/testimages/Petter_Strandmark/';
testImageSource = fullfile(testImagePath,testImageName);

img = imread([testImageSource,'.png']);
mask = imread([testImageSource,'-mask.png']);
mask(mask==255) = 1;

Rimg = img(:,:,1); Rimg(mask==1) = 0; img(:,:,1) = Rimg;
Gimg = img(:,:,2); Gimg(mask==1) = 255; img(:,:,2) = Gimg;
Bimg = img(:,:,3); Bimg(mask==1) = 0; img(:,:,3) = Bimg;

tmpImgFileName = [testImageName,'_masked.bmp'];
imwrite(img,tmpImgFileName,'BMP');

imgFilename = testImageSource;
fillFilename = tmpImgFileName;
tic
[i1,i2,i3,c,d,mov] = inpainting([imgFilename,'.png'],fillFilename,[0 255 0]);
toc

figure(1),imshow(uint8(i2)),title('Masked Image')
figure(2),imshow(uint8(i1)),title('Inpainted Image')
folderName = ['myresults/',datestr(now,'yymmdd-HHMMSS'),'_',testImageName];
mkdir(folderName)

imwrite(uint8(i2),fullfile(folderName,'maskedImg.bmp'),'BMP');
imwrite(uint8(i1),fullfile(folderName,'inpaintedImg.bmp'),'BMP');
