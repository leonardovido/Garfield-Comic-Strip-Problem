function imageOut = process_garfield_strip(imageIn, garfieldColour)
% function imageOut = process_garfield_strip(imageIn)
%
% Attempts to detect Garfield in an image, and returns the same image with
% a black background.

% Rotate input image to horizontal
imageOut=rotate_image(imageIn);

% Detect locations where Garfield exists
garfieldMask=detect_garfield(imageOut, garfieldColour);

% Create mask of frames
[frameMask, frameEdges]=mask_frames(imageOut);

% Split images into frames, and paint background black
for s=1:frameMask(end)
    % Create a mask for this frame
    thisFrame=frameMask==s;
    
    % Check for Garfield in this frame
    if any(thisFrame&garfieldMask,'all')
        % Find the column range for this frame
        frameRange=(frameEdges(s)+1):frameEdges(s+1);

        % Create an image for this frame only
        frameImage=imageOut(:,frameRange,:);
        
        % Paint the background of this frame black
        frameImage=blacken_background(frameImage);
        
        % Put the re-coloured frame back into the original image
        imageOut(:,frameRange,:)=frameImage;
    end
end

end

