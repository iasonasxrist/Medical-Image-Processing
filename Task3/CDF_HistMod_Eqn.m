function [C]=CDF_HistMod_Eqn(B,tones)

% clc;clear;
% B= uigetfile('*.bmp');
% B = imread(B);
% B= double(B);
% tones=256;

B=(tones-1)*B/max(max(B));
M = size(B,1);N=size(B,2);
tone_values = M*M/tones;

q = tone_values*ones(tones-1);

CDFh = zeros(tones,1); CDFq = zeros(tones,1);
[h]=f_histogram(B,tones);

for i=1:tones
    for j=1:i 
       CDFh(i) = CDFh(i) + h(j);
       CDFq(i) = CDFq(i) + q(j);
    end
end



maxi = max(B(:)); 
for i=1:M
    for j=1:N
%         p=B(i,j);
        p=(tones-1)*B(i,j)/maxi;
    C(i,j)=(CDFh(round(p+1))/tone_values)-1;
    if C(i,j)<0
        C(i,j)=0;
    end
    end
end

%     C=round(C);