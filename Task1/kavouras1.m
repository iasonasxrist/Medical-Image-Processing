%Graphics version of ImProLab1_APLH_APEIKONISH
%Read and display image 
% function []=ImProLab1_APLH_APEIKONISH_graphics()
clc;close all;
 
imageFile='pelvis.bmp';
im1=loadImage(imageFile);
im1=double(im1);
N=size(im1,1);M=size(im1,2);

fprintf('N= %d  M=%d\n',N,M);
subplot(2,1,1);imshow(im1,[]);
title('ARXIKH EIKONA');
image_depth=255 ;tones=64;
im2 = APLH_APEIKONISH(im1,image_depth,tones);
subplot(2,1,2);imshow(im2,[0 tones-1]);
title(strcat('ARXIKH EIKONA APEIKONISH ME:  ',num2str(tones), ' tones'));
% h_A=f_histogram(im1,tones);

%--------------SYNARTHSH: APLH_APEIKONISH----------------

%  function [im2]=APLH_APEIKONISH(im1,image_depth,tones)
% N=size(im1,1);
% M=size(im1,2);
% im2=zeros(N,M);%ORISMOS NEOY PINAKA POY 8A APO8HKEY8EI  TO APOTELESMA
% for i=1:N
%     for j=1:M
%         v=im1(i,j);
%         t=( (tones-1)/(image_depth-0) ) * (v-0);
%         im2(i,j)=round(t);
%     end;
% end;
% 
% %--------------SYNARTHSH: loadImage-----------
% 
% function [im]=loadImage(imName)
% if(imName(end-1:end) == 'cm')
%     im = dicomread(imName);
% else
%     im = imread(imName);
% end
% if (size(im,3)>1)
%     im=rgb2gray(im);
% else
%     im=im;
% end
