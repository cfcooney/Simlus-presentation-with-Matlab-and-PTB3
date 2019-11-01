function image = get_image(name)

folder = 'C:\Users\sb00745777\OneDrive - Ulster University\Study_3\Matlab\images\resized\';
try
    image = imread([folder name '.jpg']);
catch
    [image, map] = imread([folder name '.gif']);
    image = immovie(image,map);
end