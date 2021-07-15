function []=matrixRestorationByInverseFilter()

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
Bdegraded=B+B*noiseLevel*rand(2*M,2*N);
  
%2.APOKATASTASH EIKONAS
%DIPLASIASMOS Bd
Bd=zeros(2*M,2*N);
Bd(1:M,1:N)=Bdegraded(1:M,1:N);
Fh=[1,0.5,0.1,0.5];%1-d MTF SYSTHMATOS 
[FH]=from1dTo2d_MTF(Bd,Fh);%2-d MTF
Fdy=fft2(Bd)./fftshift(FH);%***INVERSE FILTERING***
C=ifft2(Fdy);%EPISTROFH STO PEDIO TOY XWROY
 
%3. EKTYPWSH APOTELESMATWN
fprintf('ARXIKH EIKONA\n')
disp(im)
fprintf('YPOBA8MISMENH EIKONA\n')
disp(round(Bd(1:M,1:N)))
fprintf('APOKATASTASH EIKONAS ME 8ORYBO %4.1f%%\n',100*noiseLevel)
disp(round(C(1:M,1:N)))
 
%4. EYRESH S.E. META3Y ARXIKHS/YPOBA8MISMENHS/FILTRARISMENHS 
diamARXIKH=diag(double(im));
diamDegraded=diag(B(1:M,1:N));

[SE_ARX_DEGR]=STDerror (diamARXIKH,diamDegraded);
diamFiltered=diag(C(1:M,1:N));
[SE_ARX_FILT]=STDerror (diamARXIKH,diamFiltered);
 
fprintf('S.E. ARXIKHS Vs YPOBA8MISMENHS :%4.2f\n',SE_ARX_DEGR)     
fprintf('S.E. ARXIKHS Vs FILTRARISMENHS :%4.2f\n',SE_ARX_FILT)
 
D_SE=100*(SE_ARX_DEGR-SE_ARX_FILT)/SE_ARX_DEGR;
 
if(SE_ARX_FILT<SE_ARX_DEGR)
    fprintf('BELTIWSH EIKONAS KATA: %4.2f\n',D_SE);
else
    fprintf('YPOBA8MISH EIKONAS KATA: %4.2f\n',D_SE);
end
%-----------------------------------------------
function [FH]=from1dTo2d_MTF(A,fh)
y=size(A,1);x=size(A,2);N=length(fh);
z1=1;z2=1;
if (rem(y,2)==0) 
    z1=0;
end
if (rem(x,2)==0) 
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
 
%----------------------------------------------------
function [stErr]=STDerror (x,y)
stErr=0;
for i=1:length(x)
    stErr=stErr+(x(i)-y(i))^2;
end
stErr=sqrt(stErr)/length(x);
