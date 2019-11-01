function image_resize(folder, filename, numrows, numcols)
%----------------------------------------------------------------
% Function for resizing images to a uniform dimension and saving 
% to a folder.
% Inputs: folder (str): directory for loading and saving
%         filename (str): class name e.g. 'pig_image'
%         numrows (int): number of pixels in row   
%         numcols (int): number of pixels in column  

newString = split(filename,'_');
original = imread([folder char(newString(1)) '.jpg']);

if strcmpi(char(newString(1)),'ballhat')
    resized = imresize(original, [numrows,numcols*1.5]); % wider image for this dual presentation.
else
resized = imresize(original, [numrows,numcols]);
end

imwrite(resized, [folder 'resized\' char(newString(1)) '.jpg'])


