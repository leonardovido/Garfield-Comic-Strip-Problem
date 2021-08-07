function outputImages=egh444_group11(garfieldDataFile, pathToImages, searchStr)
% function egh444_group11(garfieldDataFile, pathToImages, searchStr)
%
% EGH444 2019 Semester 2, Group 11, Final Project
%
% Group members:
%   Name                                    Student No.
%   Michael Irvine                           1143701
%   Paul Zapotezny-Anderson                  4337948
%   Leonardo Villamil Dominguez              10411526
%
% Input arguments:
%   garfieldDataFile    File name containing Garfield's colour range
%   pathToImages        Path to folder containing images
%   searchStr           Search string for matching files, e.g. '*_tr.png'
%
% Output arguments:
%   outputImages        Cell array of output images
%
% File outputs
%   File containing processed output image. The file format will be the
%   same as the input file. If the original file name is, 'original.ext',
%   the output file name will be 'original_out.ext.
%
% Instructions
%   Add the path to the code to the MATLAB path, e.g.
%       'addpath ../path_to_code'.
%   Run the function from the folder where output files are to be written.
%   Specify the location of the input files using the pathToImages input
%   argument.
%

% Load Garfield training data from file; the file must be in the search path
% File must have RGB colours in order
garfieldColour=csvread(garfieldDataFile);

% Read images from the specified folder matching the search string
[inputImages, fileNames] = read_images(pathToImages, searchStr);
montage(inputImages,'BackgroundColor','w');

% Create cell array to hold output images
outputImages=cell(size(inputImages));

% Loop through the images to perform processing, i.e. paint frames with
% Garfield black
for g=1:length(inputImages)
    % Process the Garfield strip image
    outputImages{g}=process_garfield_strip(inputImages{g}, garfieldColour);

    % Display the processed image
    hf=figure;imshow(outputImages{g});
    [hf.Position(4),hf.Position(3),~]=size(outputImages{g});
    title(['Output image from ' fileNames{g}],'Interpreter','none')
end

% Loop through the images to save the output. This is performed in a
% separate loop so that the output images will be created and displayed
% regardless of filesystem errors.
try
    for g=1:length(outputImages)
        % Extract file name and extension from original file name
        [~, name, ext]=fileparts(fileNames{g});

        % Write the output image to file
        % The output file name has '_out' appended
        imwrite(outputImages{g}, [name, '_out', ext]);
    end
catch
    disp(strcat('Error saving file: ', outputPath))
    disp(ME.message);
end

montage(outputImages,'BackgroundColor','w');

end