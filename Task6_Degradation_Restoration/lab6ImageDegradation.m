function []=lab6ImageDegradation ()
clc;close all;
 
A=loadImage('head5.bmp');
%METATROPH SE GRAYSCALE
A=double(A);
 
%1.SXEDIASMOS YPOBA8MISHS EIKONAS (MTF + 8ORYBOS) 
M=size(A,1);N=size(A,2);
Flength=round(sqrt(M^2+N^2));
%1a.KATASKEYH GAUSSIAN MTF
[fh]=gaussianMTF(Flength);%
[FH]=from1dTo2dFilter(A,fh);
 
%2.IMAGE BLURRING
[B]=blurImage(A,FH);
 
%3.PROS8ETIKOS 8ORYBOS
Noise=0.2; % ----- % 8ORYBOS ----
B=addNoise(B,Noise);
[B]=NormalizeMatrix(B,255);
 
%4.APEIKONISH APOTELESMATWN
figure('units','normalized','outerposition',[0 0 1 1])%use full screen size
figure(1);
subplot(2,2,1);imshow(A,[]);xlabel('ARXIKH EIKONA');
subplot(2,2,2);imshow(B,[]);xlabel('YPOBA8MISMENH EIKONA ME MTF + 8ORYBO');
subplot(2,2,3);plot(fh);xlabel('MONOFIASTATH MTF (GAUSSIAN) ');grid on;
subplot(2,2,4);imshow(FH,[]);xlabel('DIDIASTATH MTF ');
%5. APO8HKEYSH APOTELESMATWN 
imwrite(uint8(B),'YPOBA8MISMENH_EIKONA.bmp');%APO8HKEYSH YPOBA8MISMENHS EIKONAS
imwrite(uint8(A),'ARXIKH_EIKONA.bmp');%APO8HKEYSH ARXIKHS EIKONAS
 
%-----------------------------------------------------------------------
%----------------------------FUNCTIONS-----------------------------------
%-----------------------------------------------------------------------
function B=addNoise(A,Noise)
M=size(A,1);N=size(A,2);
for i=1:M
    for j=1:N
        B(i,j)=( A(i,j)+Noise*A(i,j)*rand() ) ;
    end
end
%---------------------------------------------------------------------
function [fh]=gaussianMTF(N)
if(rem(N,2)==0), L=round(N/2+1);M=round((N/2)+2);
else L=round(N/2); M=round((N/2)+1);
end
sigma=L/2-1;
for k=0:L-1
    fh(k+1)=exp( (-k^2/(2*sigma^2) ) );
end
% fh=gaussmf([0:L-1],[sigma 0] ); %SYNARTHSH TOY MATLAB
for k=M-1:N-1
    fh(k+1) = fh(N+1-k);
end
%//i.e. mirror N/2..N-1
fh=fh./max(fh);
%--------------------------------------------------------------------
function [FH]=from1dTo2dFilter(A,fh)
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
%------------------------------------------------------------------------
function [y]=blurImage(A,FH)
FA=fft2(A);
FY=(FA).*fftshift(FH);
y=(real(ifft2(FY)));

%==================================================

function [B] =NormalizeMatrix(A,maxVal)
M=size(A,1);N=size(A,2);
minA=min(min(A));maxA=max(max(A));
for i=1:M
    for j=1:N
        B(i,j)=maxVal*((A(i,j)-minA)/(maxA-minA));
    end
end