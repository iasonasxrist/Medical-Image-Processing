
function [h]=f_histogram(A,tones)
M=size(A,1);N=size(A,2);
tn=0:(tones-1);
C=reshape(A',M*N,1);%from 2d-->1d matrix
h=hist(C,tn);%find histogram
