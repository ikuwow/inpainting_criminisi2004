% inpainting.m
% 
% The MATLAB implementation of inpainting algorithm by A. Criminisi (2004)
% 
% Inputs:
% - inputImg: 
% - mask: mask matrix (same size as inputImg). 1 denotes source region, and 0 denotes hole.
% - psz: patch size (odd scalar). If psz=5, patch size is 5x5.
%
% Outputs:
% - outputImg: inpainted image
%
function [outputImg] = inpainting(inputImg, mask, psz)

inputImg = double(inputImg);
mask = double(mask);

%% error check
if ~ismatrix(inputImg); error('Input image must be grayscale image.'); end
if ~ismatrix(mask); error('Invalid mask'); end
if sum(sum(mask~=0 & mask~=1))>0; error('Invalid mask'); end
if mod(psz,2)==0; error('Patch size psz must be odd.'); end


imsize = size(inputImg);
targetRegion = mask;
sourceRegion = ~mask;

%% Initialize
fillRegion = targetRegion;
Confidence = sourceRegion;
Data = repmat(-0.1,imsize);
image = inputImg;
outputImg = mask.*inputImg; return

while any(fillRegion)

    % decide fill front
    [p, fillConfidence] = decideFillFront(outputImg, fillRegion, Confidence, psz, Data);

    % full search

    % patch attachment

end % while


end % end of function
