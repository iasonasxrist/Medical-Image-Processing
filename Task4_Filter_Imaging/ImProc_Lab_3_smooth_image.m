function []=ImProc_Lab_3_smooth_image()
%Median Filter
clc;close all;

im = imread('brain_CT.bmp');

 if (size(im,3)>1)
     im1=rgb2gray(im);
 end
  
 im1 = double(im);
        
% input salt & pepper noise

 signal_noise = 100*imnoise(im1,'salt & pepper',0.1);
 im2 = im1+signal_noise;
 
 %255/255
 im2 = im2*255/max(im2(:));
 
% set(gcf)
set(gcf, 'Name', 'Designed by IasonasXrist', 'NumberTitle', 'On')
        
        
 % apply median filter
        
 im3 = medfilt2(im2); %filter image
 % apply window filter
 
 WW=100;WC=150;image_depth=255;tones=256;
 [im4]=APLO_PARA8YRO(im3,WW,WC,image_depth,tones);
  subplot(2,2,1);imshow(im,[]);title('original image');
  subplot(2,2,2);imshow(im2,[]);title('salt & pepper added noise');
  subplot(2,2,3);imshow(im3,[]);title('median filtered image');
  subplot(2,2,4);imshow(im4,[]);title('windowed smoothed-image'); 

  %To uint8 δεν έχει διαφορά με το double στην απεικόνιση ....
  ... απλώς για το απεικονίσω ως double χρησιμοποιώ τις []
  