% function []=ImProLab1_APLH_APEIKONISH_matrix ()
clc;close all;
%ORISMOS MHTRAS EIKONA

im1=[17  19  17  25 
     13  21  21  21 
     27  25  21  12
     28  18  27  13];

N=size(im1,1);
M=size(im1,2);
im1=double(im1);%APARAITHTA NA GINETAI O PINAKAS double IDIWS OTAN PROKEITAI GIA PRAGMATIKES EIKONES
image_depth=31;%ORISMOS BA8OYS EIKONAS
tones=8;%ORISMOS TONWN TOY GKRI           
fprintf('ARXIKH MHTRA EIKONAS\n');
im1
[im2]=APLH_APEIKONISH(im1,image_depth,tones);
fprintf('GRAMMIKH APEIKONISH EIKONAS:');
im2 

%--------------SYNARTHSH: APLH_APEIKONISH----------------
% 
% function [im2]=APLH_APEIKONISH(im1,image_depth,tones)
% N=size(im1,1);
% M=size(im1,2);
% im2=zeros(N,M);%ORISMOS NEOY PINAKA POY 8A APO8HKEY8EI H  TO APOTELESMA
% for i=1:N
%     for j=1:M
%         v=im1(i,j);
%         t=( (tones-1)/(image_depth-0) ) * (v-0);
%         im2(i,j)=round(t);
%     end;
% end;

