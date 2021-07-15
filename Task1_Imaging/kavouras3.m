% function []=ImProLab1_BELTISTH_APEIKONISH_graphics()
clc;close all;

 imageFile='mri256.jpg';
im1=loadImage(imageFile);
im1=double(im1);
image_depth=256;tones=256;

 %1.APLH GRAMIKH APEIKONISH
[im2]=APLH_APEIKONISH(im1,image_depth,tones);
figure(1);subplot(2,1,1);imshow(im2,[]);
title('APLH GRAMMIKH APEIKONISH');
 %2.BELTISTH APEIKONISH
 
tones=256;
[im3]=BELTISTH_APEIKONISH(im1,tones);
subplot(2,1,2);imshow(im3,[min(im1(:)) max(im1(:))]);
title('BELTISTH APEIKONISH');

%--------------SYNARTHSH: APLH_APEIKONISH----------------

% function [im2]=APLH_APEIKONISH(im1,image_depth,tones)
% N=size(im1,1);
% M=size(im1,2);
% im2=zeros(N,M);%ORISMOS NEOY PINAKA POY 8A APO8HKEY8EI TO APOTELESMA
% for i=1:N
%     for j=1:M
%         v=im1(i,j);
%         t=( (tones-1)/(image_depth-0) ) * (v-0);
%         im2(i,j)=round(t);
%     end
% end

%--------------SYNARTHSH: BELTISTH_APEIKONISH------

% function [im3]=BELTISTH_APEIKONISH(im1,tones)
% max_im=max(max(im1));
% min_im=min(min(im1));
% N=size(im1,1);
% M=size(im1,2);
% im3=zeros(N,M);%ORISMOS NEOY PINAKA POY 8A APO8HKEY8EI TO APOTELESMA
% for i=1:N 
%     for j=1:M 
%         v=im1(i,j);
%             t=( (tones-1)/(max_im-min_im) ) * (v-min_im);
%         im3(i,j)=round(t);
%     end; 
% end; 
% 
% %--------------SYNARTHSH loadImage----------------------
% 
% function [im1]=loadImage(imName)
% if(imName(end-1:end) == 'cm')
%     im = dicomread(imName);
% else
%     im = imread(imName);
% end
% if (size(im,3)>1)
%     im1=rgb2gray(im);
% else
%     im1=im;
% end
