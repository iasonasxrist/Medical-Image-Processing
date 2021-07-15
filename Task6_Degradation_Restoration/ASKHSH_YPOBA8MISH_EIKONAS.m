function [] = ASKHSH_YPOBA8MISH_EIKONAS()
clc;close all;
 
%ARXIKH EIKONA 
im=[15,22
    28,17];
 
%1. YPOBA8MISH EIKONAS ME MTF & 8ORYBO
Fh=[1,0.5,0.1,0.5];%1-d MTF SYSTHMATOS 
noiseLevel=0.05 ;% %8ORYBOS
M=size(im,1);N=size(im,2);
%1.1. AY3HSH DIASTASEWN EIKONAS ME MHDENIKA GIA WRAPPING EFFECT
A=zeros(2*M,2*N);
%1.2. TOPO8ETHSH ARXIKHS EIKONAS im STHN ARXH TOY A
A(1:M,1:N)=im;
%1.3. YPOLOGISMOS 2d-MTF
[FH]=from1dTo2d_MTF(A,Fh);
%1.4. BLUR IMAGE
FY=fft2(A).*fftshift(FH);
B=((ifft2(FY)));%EIKONA  * MTF 

%1.5 EIKONA + MTF+ PROS8ETIKOS 8ORYBOS 
Bdegraded=addNoise(B,noiseLevel);
% Bdegraded=B+B*noiseLevel*rand(2*M,2*N);
 
%3. EKTYPWSH APOTELESMATWN
fprintf('ARXIKH EIKONA\n')
disp(im)
fprintf('DIPLASIASMOS EIKONAS ME MHDENIKA\n')
disp(A)
fprintf('2-d MTF\n')
fprintf('%4.1f %4.1f %4.1f %4.1f \n',FH)
fprintf('\nEIKONA ME MTF\n')
disp(round(B))
fprintf('YPOBA8MISMENH EIKONA ME 8ORYBO %4.2f%%\n',100*noiseLevel)
disp(round(Bdegraded(1:M,1:N)))
%--------------------------------------------------------------------
function [FH]=from1dTo2d_MTF(A,fh)
y=size(A,1);x=size(A,2);N=length(fh);
z1=1;z2=1;
if (rem(y,2)==0), 
    z1=0;
end
if (rem(x,2)==0), 
    z2=0;
end
 FH=zeros(y,x);
for i=0:y-1
    for j=0:x-1
        k=round(y/2-z1)-i;
        m=round(x/2-z2)-j;
        ir = round(( k^2 +m^2 )^0.5);
        FH(i+1,j+1)=fh(ir+1);
    end
end
%-----------------------------------------------------------------------
function B=addNoise(A,Noise)
M=size(A,1);N=size(A,2);
for i=1:M
    for j=1:N
        B(i,j)=( A(i,j)+Noise*A(i,j)*rand() ) ;
    end
end
