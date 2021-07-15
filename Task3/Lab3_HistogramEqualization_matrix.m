% function []=Lab3_HistogramEqualization_matrix()


% APLH APEIKONISH KAI ISOSTA8MISH HIST
clc; close all;
 A=[6 3 7 7
     6 6 5 7
     7 4 3 3
     4 7 6 6];
A=double(A);B=A;
disp('image matrix');
disp(A);
tones=8;image_depth=8;
 
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
disp('plotted image ');
disp(B);
[h]=f_histogram(B,tones);
disp('original image histogram');
disp(h);
 
fprintf('\n -----------------------------------------\n');
fprintf('------------ START HE PROCESS: ------------\n');
fprintf('-------------------------------------------\n');
 
tic
Z=hEqualization(A,tones,image_depth);
disp('equalized image2');
disp(Z)
disp('histogram 2 of equalized image');
hZ=f_histogram(Z, tones);
disp(hZ);
toc
%============================================
%==================hist_A====================
%============================================
% function [h]=f_histogram(A,tones)
% M=size(A,1);N=size(A,2);
% tn=0:(tones-1);
% C=reshape(A',M*N,1); %from 2d-->1d matrix
% h=hist(C,tn);
%  
% %============================================
% %==============  HE function ================
% %=============================================
% function [Z]=hEqualization(A,tones,image_depth)
% %turn matrix values into image values (pixels)
% N=size(A,1);M=size(A,2);
% for i=1:N
%     for j=1:M
%         ival=A(i,j);
%         tone_ival=(tones-1)*(double(ival)-0)/(image_depth-0);
%         B(i,j)=tone_ival;
%     end;
% end;
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
