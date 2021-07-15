function []=ImProc_Lab_3_smooth_d()
format short g
%median filter
clc;close all;
A=[
30  18  12  27
18  18  23  15 
16  13  10  19 
13  19  22  22];

 
M=size(A,1); N=size(A,2);
MFilt=A;
B=medfilt2(A);
MFilt(2:M-1,2:N-1) = round(B(2:M-1,2:N-1));%form Filtered Image
MFilt
 
K1 = A(2:M-1,2:N-1)
K2 = MFilt(2:M-1,2:N-1)
 
meanK1 = mean2(K1)
meanK2 = mean2(K2)
stdK1 = std2(K1)
stdK2 = std2(K2)
 
 noise_diff = 100*(stdK1-stdK2)/stdK1
