function [mask, frameEdges] = mask_frames(stripImage)
% function [mask, frameEdges] = mask_frames(stripImage)
%   Create a separate mask for each frame in an cartoon strip image
% Arguments:
%   stripImage: cartoon strip image
%   mask:       mask with each pixel labelled with frame number
%   frameEdges: column where the edge of the frames are
%               The first column is automatically a frame boundary
%
%   Note the number of frames is the length of frameEdges plus one, or the
%   largest value in mask.

localImage=im2double(rgb2gray(stripImage));
imageWidth=size(localImage,2);

% Convert everything below median to median
% This removes black borders; only white boundaries are significant
thresh=median(localImage,'all');
localImage(localImage<thresh)=thresh;

% Take the vertical mean
vertMean=rescale(mean(localImage,1));

% Create Gaussian filters
sigma2=round(imageWidth/81);
width1=3*sigma2;
h=gausswin(2*width1,sigma2);
hd1=diff(h);
hd2=diff(hd1);hd2=hd2/sum(abs(hd2));

% Filter with second derivate of Gaussian
vertImage=conv(vertMean,hd2,'same');

% White peaks are negative, so invert and truncate
vertImage=-vertImage;
vertImage(vertImage<0)=0;

% Peaks near ends of the image aren't frame boundaries, so
% remove them from further processing
vertImage(:,1:ceil(0.125*imageWidth))=0;
vertImage(:,floor(0.875*imageWidth):end)=0;

% Filter the result
vertImage=conv(vertImage,h,'same');
vertImage=rescale(vertImage);

% Find the peaks
[~,frameEdges] = findpeaks(vertImage,...
    'MinPeakProminence',0.5,'MinPeakDistance',width1);

% Create a mask for each frame
mask = uint8(ones(size(localImage)));
for f=1:length(frameEdges)
    mask(:,frameEdges(f):end)=f+1;
end

% Put a zero as the first frame 'edge' and the width of the image as the
% end of the last frame.
frameEdges=[0 frameEdges imageWidth];

end