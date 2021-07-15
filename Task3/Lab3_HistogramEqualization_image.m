% function []=Lab3_HistogramEqualization_image()
clc; close all;
% ##A1=loadImage('lung_130.bmp');
A1=loadImage('pelvis.bmp');
A=double(A1);

 
N=size(A,1);M=size(A,2);
sprintf('N= %f  M=%f',N,M);
tones=256;image_depth=255;
 
%plot original image
 
subplot(2,2,1);imshow(A,[]);title('original image');

[Z]=hEqualization(A,tones,image_depth);
 
subplot(2,2,2);imshow(Z,[]);title('Equalized image');

h_A=f_histogram(A,tones);
h_Z=f_histogram(Z,tones);

if(rem(M,2)>0 || rem(N,2)>0)
    h_Z=h_Z(1:end-1); 
end 
 
subplot(2,2,3);plot(h_A/max(h_A),'linewidth',2);
title('original image histogram ');grid on;
 
subplot(2,2,4);plot(h_Z/max(h_Z),'--r','linewidth',2);
title('Equalized image histogram');grid on;
 
 
 
%============================================
%==================hist_A====================
%============================================

% function [h]=f_histogram(A,tones)
% M=size(A,1);N=size(A,2);
% tn=0:(tones-1);
% C=reshape(A',M*N,1);%from 2d-->1d matrix
% h=hist(C,tn);%find histogram
% 
% %============================================
% %==============  HE function ================
% %=============================================
% 
% function [Z]=hEqualization(A,tones,image_depth)
% %turn matrix values into image values (pixels)
% N=size(A,1);M=size(A,2);
% for i=1:N
%     for j=1:M
%         ival=A(i,j);
%         tone_ival=(tones-1)*(double(ival)-0)/(image_depth-0);
%         B(i,j)=tone_ival;
%     end
% end
% N=size(B,1);M=size(B,2);
% k=0;
% Bval=zeros(N*M,1);
% %from 2-d to 1-d
% for i=1:N
%     for j=1:M
%         k=k+1;
%         Bval(k)=round(B(i,j));
%     end
% end
% clear B;
%  
% %sort 1-d table that holds image values
% %p retains original index values in 1-d table Bval
% [C,p]=sort(Bval);
% clear C;
% BL=length(Bval);
% clear Bval;
% neq=round((N*M)/tones);
% zRem=rem(BL,neq);
% az=fix(N*M/neq);
% k=-1;
% for i=1:neq:neq*az
%     k=k+1;
%     for j=1:neq
%         D(i+j-1)=k;
%     end
% end
% if(zRem>0)
%     k=k+1;
%     for i=neq*az+1:(az*neq)+zRem
%         D(i)=k;
%     end
% end
% %reassign equalized values into their proper position
% k=0;
% for i=1:N
%     for j=1:M
%         k=k+1;
%         L(p(k))=D(k);
%     end
% end
% clear D;
% %turn 1-d table into 2-d table
% k=0;
% for i=1:N
%     for j=1:M
%         k=k+1;
%         Z(i,j)=L(k);
%     end
% end
% clear L;
% %-------------------------------------------------------
% %--------------SYNARTHSH: loadImage-----------
% %-------------------------------------------------------
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


