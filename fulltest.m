% fulltest.m
%
%

clear


SaveFolderName = [datestr(now,'yymmdd-HHMMSS'), '_criminisi_fulltest'];

SaveFolderPath = 'myresults/';
mkdir(SaveFolderPath,SaveFolderName);
diary(fullfile(SaveFolderPath,SaveFolderName,'log.txt'));

psz = 9

TestImageFolderPath = '../AutoShared/testimages';
TestImageNames = {'barbara','lena','mandril','pepper'};

MaskNames = {'line','text'};
masks = load('~/Documents/MATLAB/AutoShared/testimages/mask512.mat');


for itr_mask = 1:length(MaskNames) % loop for mask
    maskName = cell2mat(MaskNames(itr_mask));

    switch maskName
        case 'line'; mask = masks.line;
        case 'text'; mask = masks.text;
        otherwise; error('what mask??')
    end
    mask = mask/255;

    for itrIm = 1:length(TestImageNames) % loop for image

        imageName = cell2mat(TestImageNames(itrIm));

        y_test = imread(fullfile(TestImageFolderPath,'512',[imageName,'.bmp']));
        %{
        if ndims(y_test) == 3;
            y_test = rgb2gray(y_test);
        end
        %}
        y_masked = uint8(repmat(mask,[1,1,3])).*y_test;

        folderName = [maskName,'_',imageName];
        mkdir(fullfile(SaveFolderPath,SaveFolderName),folderName);

        disp([imageName,', ',maskName]);
        tic
        [x_out, Confidence, Data, movie] = inpainting(y_test, logical(~mask), psz);
        toc

        % temporary grayscale evaluation
        x_out = rgb2gray(uint8(x_out));
        PSNR_ = imgPSNR(x_out, rgb2gray(uint8(y_test)) )

        imwrite(rgb2gray(uint8(y_test)),fullfile(SaveFolderPath,SaveFolderName,folderName,'y_test.bmp'),'BMP');
        imwrite(rgb2gray(uint8(y_masked)),fullfile(SaveFolderPath,SaveFolderName,folderName,'y_masked.bmp'),'BMP');
        imwrite(uint8(x_out),fullfile(SaveFolderPath,SaveFolderName,folderName,['x_out_PSNR',num2str(PSNR_),'.bmp']),'BMP');

    end

end

diary off;
