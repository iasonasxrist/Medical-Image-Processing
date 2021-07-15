function [im3,im2]=smoothing(im, sm);



clc; close all;
format short g;
        
% 2-D CONVOLUTION

im = imread('brain_CT_noisy.bmp');
if (size(im,3)>1)
   im1=rgb2gray(im);
end
im1 = double(im1);
  size(im1)
        
%  Mask definition
% 
% sm=[1,1,1
%     1,1,1
%     1,1,1];
sm2 = sm./sum(sm(:));

% Convolution

im2=conv2(im1,sm2,'same'); %filter image
% Windowing     

 WW=100;WC=150;image_depth=255;tones=256;
[im3]=APLO_PARA8YRO(im2,WW,WC,image_depth,tones);
        
%   Plotting
subplot(2,2,1);imshow(im);
title('Original noisy image');
subplot(2,2,2);imshow(uint8(im2));
strm = num2str(sm(:)');
s=sprintf('Smoothing mask:\n %s ', num2str(sm(:)));
title(s);
subplot(2,2,3);imshow(uint8(im3));
title('windowed smoothed-image'); 