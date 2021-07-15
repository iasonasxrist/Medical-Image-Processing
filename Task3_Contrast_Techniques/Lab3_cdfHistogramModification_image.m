% function []=Lab3_cdfHistogramModification_image()
clc;close all;
A=imread('pelvis.bmp');
A=double(A);
N=size(A,1);M=size(A,2);
sprintf('N= %f  M=%f',N,M);
image_depth=256 ;tones=256;
%plot original image
%-------cdf Histogram modification  process-------------
fprintf('\n Start cdf Histogram Modification process  \n\n');
tic
HMmethod=2;
switch HMmethod
    case 1
        Z=CDF_HistMod_Table(A,tones);
        s='Equalized by CDF_Table method';
    case 2
        Z=CDF_HistMod_Eqn(A,tones);
        s='Equalized by CDF_Equation method';
end
toc
 
%--------end of cfd HMod process----------------------
figure(1);
subplot(2,2,1);imshow(A,[]);title('original image');
 
subplot(2,2,2);imshow(Z,[]);title(s,'interpreter','none');
h_A=f_histogram(A,tones);h_Z=f_histogram(Z,tones);
subplot(2,2,3);plot(h_A/max(h_A));title('original image histogram ');
subplot(2,2,4);plot(h_Z/max(h_Z),'r');title('CDF-image histogram');
 
 
 
figure(2)
J1 = histeq(uint8(A));
subplot(2,2,1);imshow(J1,[]);title('HE (CDF) Matlab')
h_J1=f_histogram(J1,tones);
subplot(2,2,2);plot(h_J1/max(h_J1) );title('CDF histogram Matlab')

 %++++++++ TO AKOLOY8O MONO GIA MATLAB CLAHE+++++
 
J2 = adapthisteq(uint8(A),'clipLimit',0.02,'Distribution','uniform');
% 'uniform', 'rayleigh', 'exponential'
subplot(2,2,3);imshow(J2,[]);title('CLAHE');
h_J2=f_histogram(J2,tones);
subplot(2,2,4);plot(h_J2/max(h_J2) );
title('CLAHE histogram');
 
 


%==================CDF_HistMod_Table============

% function [B]=CDF_HistMod_Table(A,tn)
% M=size(A,1);N=size(A,2);
% h=f_histogram(A,tn);
% CDFh=cumsum(h);
% tone_values=(N*M)/tn;
% q=tone_values*ones(tn,1);
% CDFq=cumsum(q);
% tones=0:tn-1;
% if(M<=4)
%     disp(' -----------Table-------------');
%     disp(' tones     h    CDFh   q    CDFq  ');
%     [tones' h' CDFh' q CDFq]
% end
% C=reshape(A',M*N,1);
% C1=zeros(length(C),1);
%  
% for i=1:length(C)
%     v1=CDFh(C(i)+1);
%     for j=1:length(CDFq)
%         v2=CDFq(j);
%         D(j)=abs(v1-v2);
%     end
%     [Z,indx]=min(D);
%     K(i)=tones(indx);%CDFh - CDFq correspendence
% end
% B=reshape(K,M,N)';
%  
% %============================================
% %==================CDF_HistMod_Eqn============
% %============================================
% function [C]=CDF_HistMod_Eqn(B,tones)
% B=(tones-1)*B/max(max(B));
% M=size(B,1);N=size(B,2);
% tone_values=(M*M)/tones;
% q=tone_values*ones(tones,1);
% CDFh=zeros(tones,1);CDFq=zeros(tones,1);
% [h]=f_histogram(B,tones);
% %form CDFs
% for i=1:tones
%     for j=1:i
%         CDFh(i)=CDFh(i)+h(j);
%         CDFq(i)=CDFq(i)+q(j);
%     end
% end
% %calculate CDF_modified image
% maxi=max(max(B));
% for i=1:M
%     for j=1:N
%         p=B(i,j);
% %         p=(tones-1)*B(i,j)/maxi;
%         C(i,j)=(CDFh(round(p+1))/tone_values)-1;
%         if(C(i,j)<0)
%             C(i,j)=0;
%         end
%     end
% end
% C=round(C);
% %============================================
% %==================hist_A====================
% %============================================
% function [h]=f_histogram(A,tones)
% M=size(A,1);N=size(A,2);
% tn=0:(tones-1);
% C=reshape(A',M*N,1);
% h=hist(C,tn);
%  
 


