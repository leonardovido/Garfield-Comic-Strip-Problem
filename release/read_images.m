function [imageArray, fileNames] = read_images(pathToImages, searchStr)
% function imageArray = read_images(pathToImages)
%   Reads all files matching search pattern from the specified folder and
%   outputs them to a cell array.
% Arguments
%   pathtoImages    path to image files as character array
%   imageArray      cell array with each element being an image
%   searchStr       search string for files to match

if isempty(pathToImages)
    % Set path to this folder
    pathToImages=['.' filesep];
elseif not(ismember(pathToImages(end), '\/'))
    % Add directory delimiter to end of path
    pathToImages = [pathToImages filesep];
end

% Read all file names matching search pattern
files = strtrim(string(ls([pathToImages searchStr])));

% Create image and file name cell array variable. This will be allowed to
% grow so that any errors in reading files may be ignored.
imageArray = {};
fileNames = {};

% Read through the files matching the search pattern
for f=1:length(files)
    try
        % Create a full file name
        fullFileName=strcat(pathToImages, files(f));

        % Read in the file to a temporary array
        temp=(imread(fullFileName));

        % If that succeeds then add it to the output array
        imageArray=[imageArray;temp];           %#ok<AGROW>

        % Extract the file name parts from the file name
        [~,name,ext] = fileparts(fullFileName);

        % Output the file names
        fileNames=[fileNames;strcat(name,ext)];       %#ok<AGROW>

    catch ME
        disp(strcat('Error reading file: ', files(f)))
        disp(ME.message);
    end
end
end
