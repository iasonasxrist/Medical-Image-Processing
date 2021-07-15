function []=ImProc_Lab_3_sharp_a()
format short g
%2-D CONVOLUTION (Sharpening)
clc;close all;

A=[30  18  12  27
   18  18  23  15 
   16  13  10  19 
   13  19  22  22];
 
imageDepth=31;

Lmask1= [0,-1,0;-1,5,-1;0,-1,0];
% [0,1,0;1,-4,1;0,1,0]

S=sum(Lmask1(:))

if(S<=0) 
    S=1;
end

B=conv2(A,Lmask1./S,'same'); %filter image
D=A;%equate for keeping frame
M=size(A,1); N=size(A,2);
D(2:M-1,2:N-1)=round(B(2:M-1,2:N-1));%form D

for i=1:N
    for j=1:M
        if(D(i,j)<0) 
            D(i,j)=0
        end
        if(D(i,j)>imageDepth) 
            D(i,j)=imageDepth;
        end
    end
end

D
diff=0;
[diff]=noise_diff(A, D);
diff
 
% -------------------------------------------------
function [diff] =noise_diff(A, D) 
Central_A=A(2:3,2:3)
Central_D=D(2:3,2:3)
N=size(Central_D,2);
diff=0;
mean_A=mean2(Central_A)
mean_D=mean2(Central_D)
 
sigma_A=std2(Central_A)
sigma_D=std2(Central_D)
 
diff=100*(sigma_A-sigma_D)/sigma_A;
 
