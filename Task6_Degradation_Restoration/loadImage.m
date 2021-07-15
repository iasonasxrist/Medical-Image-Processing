function [im]=loadImage(imName)
if(imName(end-1:end) == 'cm')
    im = dicomread(imName);
else
    im = imread(imName);
end
if (size(im,3)>1)
    im=rgb2gray(im);
else
    im=im;
end
%---------