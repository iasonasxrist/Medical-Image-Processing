% function []=Lab3_cdfHistogramModification_matrix()
clc;close all;
% A=[30 18 12 27
%    18 18 23 15 
%    16 13 10 19
%    13 19 22 22];
 
A=double(A);B=A;
disp('image matrix');
disp(A);
tones=8;
 
%turn matrix values into image values (pixels)
N=size(A,1);M=size(A,2);
for i=1:N
    for j=1:M
        ival=A(i,j);
        tone_ival=(tones-1)*(double(ival)-0)/(31-0);
        B(i,j)=tone_ival;
    end;
end;
B=round(B);
disp('plotted image ');disp(B);
disp('original image histogram');
[h]=f_histogram(B,tones);disp(h);
 
fprintf('\n Start cdf Table-Histogram Modification process  \n\n');
tic;[C]=CDF_HistMod_Table(B,tones);toc;
disp('equalized image by Table-Histogram Modification process');disp(C);
disp('histogram of equalized image');
hZ=f_histogram(C,tones);disp(hZ);
 
tic;[D]=CDF_HistMod_Eqn(B,tones);toc
disp('equalized image by Equation-Histogram Modification process');
disp(D);
disp('histogram of equalized image by Equation-Histogram Modification process');
hZ=f_histogram(D,tones);
disp(hZ);
 
%============================================
%==================CDF_HistMod_Table==========
%============================================

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
% M=size(B,1);N=size(B,2);
% B=(tones-1)*B/max(max(B));
% tone_values=(M*N)/tones;
% q=tone_values*ones(tones,1);
% CDFh=zeros(tones,1);CDFq=zeros(tones,1);
% [h]=f_histogram(B,tones)
% %form CDFs
% for i=1:tones,
%     for j=1:i
%         CDFh(i)=CDFh(i)+h(j);
%         CDFq(i)=CDFq(i)+q(j);
%     end;
% end;
% %calculate CDF_modified image
% for i=1:M
%     for j=1:N
%         p=B(i,j);
%         C(i,j)=(CDFh(round(p+1))/tone_values)-1;
%         if(C(i,j)<0) C(i,j)=0;end;
%     end;
% end;
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


