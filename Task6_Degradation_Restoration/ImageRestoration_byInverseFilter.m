function []=ImageRestoration_byInverseFilter()
clc;close all;
%1.FORTWMA KAI YPOBA8MISH EIKONAS
A=imread('head5.bmp');
if (size(A,3)==3)
    A=rgb2gray(A);
end % GRAYSCALE

A=double(A);
A=NormalizeMatrix(A,255);
 
%1a.SXEDIASMOS YPOBA8MISHS EIKONAS (MTF + 8ORYBOS)
M=size(A,1);N=size(A,2);
Flength=round(sqrt(M^2+N^2));
%1b.KATASKEYH GAUSSIAN MTF
[fh]=gaussianMTF(Flength);%
[FH]=from1dTo2dFilter(A,fh);
%1c.IMAGE BLURRING
B=filterImage(A,FH);
%1d.PROS8ETIKOS 8ORYBOS
Noise=0.05; % ----- % 8ORYBOS ----
Adegraded=addNoise(B,Noise);
Adegraded=NormalizeMatrix(Adegraded,255);
 
 
%2.SXEDIASMOS SYNARTHSHS ANTISTROFOY FILTROY (FW)
M=size(Adegraded,1);N=size(Adegraded,2);
Flength=round(sqrt(M^2+N^2));
[fh]=gaussianMTF(Flength);
[fw]=inverseFilter(fh);

strType=(' Inverse Filter');
[FW]=from1dTo2dFilter(Adegraded,fw);
 
%3.APOKATASTASH EIKONAS
[Afilt]=filterImage(Adegraded,FW);
[Afilt]=NormalizeMatrix(Afilt,255);
 
%4.APEIKONISH APOTELESMATAWN
figure('units','normalized','outerposition',[0 0 1 1])%use full screen size
 
subplot(2,3,1);imshow(A,[]);title('ARXIKH EIKONA');
subplot(2,3,2);imshow(Adegraded,[]);
 
strNoise=sprintf('%3.1f%%',Noise*100);
title(strcat('YPOBA8MISMENH EIKONA ME MTF + 8ORYBO:',strNoise));
subplot(2,3,3);imshow(Afilt,[]);title('FILTRARISMENH EIKONA');
subplot(2,3,4);plot(fh);title('System MTF');grid on;
subplot(2,3,5);plot(fw);title(strcat('FILTRO: ',strType));grid on;
subplot(2,3,6);imshow(FW,[]);title(strcat(' DISDIASTATO ', strType));
 
diamARXIKH=diag(double(A));
diamDegraded=diag(Adegraded);
[SE_ARX_DEGR]=STDerror (diamARXIKH,diamDegraded);
diamFiltered=diag(Afilt);
[SE_ARX_FILT]=STDerror (diamARXIKH,diamFiltered);
[SE_ARX_DEGR]=STDerror (diamARXIKH,diamDegraded);
diamFiltered=diag(Afilt);
[SE_ARX_FILT]=STDerror (diamARXIKH,diamFiltered);
fprintf('S.E. ARXIKHS Vs YPOBA8MISMENHS :%4.2f\n',SE_ARX_DEGR)     
fprintf('S.E. ARXIKHS Vs FILTRARISMENHS :%4.2f\n',SE_ARX_FILT)
D_SE=100*(SE_ARX_DEGR-SE_ARX_FILT)/SE_ARX_DEGR;
 
if(SE_ARX_FILT<SE_ARX_DEGR)
    fprintf('BELTIWSH EIKONAS KATA: %4.2f%%\n',D_SE);
else
    fprintf('YPOBA8MISH EIKONAS KATA: %4.2f%%\n',D_SE);
end
%-----------------------------------------------------------------
%--------------------------FUNCTIONS -----------------------------
%-----------------------------------------------------------------
 
function [Fw]=inverseFilter(Fh)
C=0.0001;
for i=1:length(Fh)
    if(Fh(i)<C), Fh(i)=C;
    end
end
Fw=1./Fh;%ORISMOS ANTISTROFOY FILTROY
Fw=Fw./max(Fw);
%---------------------------------------------------------------------
function [fh]=gaussianMTF(N)
if(rem(N,2)==0), L=round(N/2+1);M=round((N/2)+2);
else L=round(N/2); M=round((N/2)+1);
end
sigma=L/2-1;
% [L sigma]
for k=0:L-1
    fh(k+1)=exp( (-k^2/(2*sigma^2) ) );
end
% fh=gaussmf([0:L-1],[sigma 0] ); %SYNARTHSH TOY MATLAB
for k=M-1:N-1
    fh(k+1) = fh(N+1-k);
end;%//i.e. mirror N/2..N-1
fh=fh./max(fh);
%----------------------------------------------------------------
 
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

%-----------------------------------------------------------------------

function B=addNoise(A,noiseLevel)
M=size(A,1);N=size(A,2);
for i=1:M
    for j=1:N
        B(i,j)=( A(i,j)+noiseLevel*A(i,j)*rand() ) ;
    end
end

%------------------------------------------------------------------------

function [y]=filterImage(A,FH)
FA=fft2(A);
FY=(FA).*fftshift(FH);
y=(real(ifft2(FY)));

%------------------------------------------------------------------------

function [B] =NormalizeMatrix(A,maxVal)
M=size(A,1);N=size(A,2);
minA=min(min(A));maxA=max(max(A));
for i=1:M
    for j=1:N
        B(i,j)=maxVal*((A(i,j)-minA)/(maxA-minA));
    end
end

%----------------------------------------------------

function [stErr]=STDerror (x,y)
stErr=0;
for i=1:length(x)
    stErr=stErr+(x(i)-y(i))^2;
end
stErr=sqrt(stErr)/length(x);