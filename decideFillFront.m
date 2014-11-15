% decideFillFront.m
%
% inputs
% - img: 2D image matrix, lost region is filled with NaN
% - fillRegion: 2D binary matrix, same size as img.
%
% outputs
% - fillFront: the linear index of decided fill front.
% - contour: the contour of lost region (linear index), (on the not lost region)
% - debug: the structure of debugging info
% 
function [fillFront, fillConfidence] = decideFillFront(img, fillRegion, Confidence, patchsize, Data)

% Find contour
contour = find(conv2(double(fillRegion),[1,1,1;1,-8,1;1,1,1],'same')>0);

% normalized gradients of target region
[Nx, Ny] = gradient(double(~fillRegion));
Nxy = [Nx(contour), Ny(contour)]; % contourの部分だけgradientを抜き出す
Nxy = normr(Nxy); % 行を正規化
Nxy(~isfinite(Nxy)) = 0; % handle NaN and Inf

%{
Confidence_ = zeros(length(contour),1);
% for k = contour'
for k = 1:length(contour)
    idx_patch = getPatch(size(img),contour(k),patchsize);
    q = idx_patch(~(fillRegion(idx_patch))); % not fill region,
    Confidence_(k) = sum(Confidence(q))/numel(idx_patch);
end


% compute Data term
[gradX, gradY] = Gradient(double(img));
gradX = gradX/255; gradY = gradY/255;
tmp = gradX; gradX = -gradY; gradY = tmp; clear tmp; % Rotate gradient 90 degrees
Data(contour) = abs(gradX(contour).*Nxy(:,1)+gradY(contour).*Nxy(:,2)) + 10^(-5); % already normalized (alpha = 255)

Priorities = Confidence_ .* Data(contour); % TODO: corner is 0. its ok?

% find center of patch with maximum priority
[~, idx_maxpri] = max(Priorities(:));
fillFront = contour(idx_maxpri(1));
fillConfidence = Confidence_(idx_maxpri(1));

% TODO: more propagate

%}    
end % end of function
