% clc;clear;
function [B]=CDF_HistMod_Table(A,tn)
A= uigetfile('*.bmp');
A = imread(A);
A= double(A);
tn=256;

M=size(A,1);N=size(A,2);

h = f_histogram(A,tn);
CDFh = cumsum(h);

tone_values = N*M/tn;

q = tone_values*ones(tn,1);

CDFq = cumsum(q);

tones = 0:tn-1;

if (M<=4)
    disp(' -----------Table-------------');
    disp(' tones     h    CDFh   q    CDFq  ');
    [tones' h' CDFh' q' CDFq'];
end


C=reshape(A,N*M,1);
C1=zeros(length(C),1);

for i=1:length(C)
    v1 = CDFh(C(i)+1);
   for j=1:length(CDFq)
       v2 = CDFq(j);
      D(j)=abs(v1-v2);
   end
end

[Z,indx] = min(D);
K(i) = tones(indx);
B =reshape(K,M,N)';

