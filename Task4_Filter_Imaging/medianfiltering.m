% function [] = medianfiltering(im)

clc;close all;
% %*********load the package, run >>pkg load image from the Octave Command Window
% im = imread('brain_CT.bmp');
im1=[
    30  18  12  27
    18  18  23  15 
    16  13  10  19 
    13  19  22  22 ];

% if (size(im,3)>1)
%     im1=rgb2gray(im);
% end
%  
%  im1 = double(im);
 
 im2 = medfilt2(im1); 

 subplot(2,2,1);imshow(im1,[]);title('original image');
 
 subplot(2,2,2);imshow(uint8(im2));title('median filtered image');
 
 
 
diff=0;

[diff]=noise_diff(im1, im2)

diff
 

 