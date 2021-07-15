function []=ImProc_Lab_3_smooth_c()
format short g
%2-D CONVOLUTION
clc;close all;
A=[
    30  18  12  27
    18  18  23  15 
    16  13  10  19 
    13  19  22  22 ];

sm=[1 1 1
    1 1 1
    1 1 1];

B=conv2(A,sm./sum(sum(sm)),'same'); %filter image


D=A;%equate for keeping frame
M=size(A,1); N=size(A,2);
D(2:M-1,2:N-1)=round(B(2:M-1,2:N-1));%form D

D
diff=0;

[diff]=noise_diff(A, D)

diff;
 
% % -------------------------------------------------
function [diff] =noise_diff(im, m) 
Central_im=im(2:3,2:3)
Central_m=m(2:3,2:3)
N=size(Central_m,2);
diff=0;
mean_im=mean2(Central_im)
mean_m=mean2(Central_m)
 
sigma_im=std2(Central_im)
sigma_m=std2(Central_m)
 
diff=100*(sigma_im-sigma_m)/sigma_im;
