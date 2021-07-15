% function []=ImProLab1_BELTISTH_APEIKONISH_matrix()
clc;clear all;

im1=[30    16    20    18
    14     8     5    20
    24    16     4    18
     2     5    12    14];



im1  =double(im1);

N=size(im1,1);
M=size(im1,2);
image_depth=32;
tones=8;

fprintf("ARXIKH EIKONA\n");
im1

[im2] = APLH_APEIKONISH(im1,image_depth,tones);
fprintf("EIKONA META APO GRAMMIKH APEIKONISH\n");
im2


[im3] = BELTISTH_APEIKONISH(im1,tones);
fprintf("BELTISTH APEIKONISH\n");
im3

%--------------SYNARTHSH: APLH_APEIKONISH----------------


% function [im2] = APLH_APEIKONISH(im1,image_depth,tones)
% 
% N=size(im1,1);
% M=size(im1,2);
% im2 = zeros(N,M);
% for j=1:M
%     for i=1:N
%        v=im1(i,j);
%        t = ((tones-1)/(image_depth-0))*(v-0);
%        im2(i,j) = round(t);
%     end
% end
% 
% %--------------SYNARTHSH: BELTISTH_APEIKONISH------
% 
% function [im3] = BELTISTH_APEIKONISH(im1,tones)
% 
% max_im = max(im1(:));
% min_im = min(im1(:));
% N=size(im1,1);
% M=size(im1,2);
% im3 = zeros(N,M);
% 
% for j=1:M
%     for i=1:N
%         v = im1(i,j);
%         t = ((tones-1)/(max_im -min_im))*(v-min_im);
%         im3(i,j) = round(t);
%     end
% end




