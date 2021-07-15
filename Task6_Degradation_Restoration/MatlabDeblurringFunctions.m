function [] = MatlabDeblurringFunctions()
clc;close all;
%         https://www.mathworks.com/help/images/referencelist.html?type=function&category=image-restoration-deblurring&s_tid=CRUX_topnav
figure('units','normalized','outerposition',[0 0 1 1])%use full screen size
% imageNames={};    
% % path=;
% imNumber=1;
% imFile=strcat(path, imageNames{imNumber});
A=loadImage('BODY1.BMP');

A=double(A);
[A]=NormalizeMatrix(A,255);
%         1.SXEDIASMOS SYNARTHSHS YPOBA8MISHS EIKONAS (FH)
M=size(A,1);N=size(A,2);
Flength=round(sqrt(M^2+N^2));
 
%==================================================
noise=0.1;% x100 for %IMAGE DEPENDENT NOISE
MTFfco=Flength/2;
%==================================================
 
[fh]=gaussianMTFb(Flength,MTFfco);
[FH]=from1dTo2dFilter(A,fh);
PSF=fftshift(abs(ifft2(FH)));
PSF=PSF./max(PSF(:));
%2.YPOBA8MISH EIKONAS ME PSF + 8ORYBO 
 
FA=fftshift(FH).*fft2(A);
blurred=abs(ifft2(FA));
 
 
 
signal_var = var(A(:));SNR=signal_var/noise;
blurred_noisy=addNoise(blurred,noise);
%         blurred_noisy=imnoise(blurred,'gaussian',0.5,noise_var);
subplot(2,3,5);imshow(blurred_noisy,[]);title('blurred + noisy ');
tic
%3. FILTRARISMA EIKONAS ME 3 FILTRA, 
%   WIENER, BLIND DECONV KAI LUCY
 
inverseFilter= deconvwnr(blurred_noisy,PSF);  
[inverseFilter]=NormalizeMatrix(inverseFilter,255);
 
wienerdeblurred = deconvwnr(blurred_noisy,PSF,noise);
[wienerdeblurred]=NormalizeMatrix(wienerdeblurred,255);
 
blinddeblurred = deconvblind(blurred_noisy,PSF);
[blinddeblurred ]=NormalizeMatrix(blinddeblurred ,255);
 
lucydeblurred = deconvlucy(blurred_noisy,PSF,[],[],SNR);
[lucydeblurred]=NormalizeMatrix(lucydeblurred,255);
 
toc
 
 
subplot(3,3,1);imshow(A,[]);title('original image');
subplot(3,3,2);plot(fh,'r');grid on;title('1-d of blurring function'); 
xlabel('spatial frequencies');
subplot(3,3,3);imshow(FH,[]);title('2-d MTF of blurring function');
subplot(3,3,4);imshow(blurred,[]);title('blurred image');
subplot(3,3,5);imshow(blurred_noisy,[]);
sText=sprintf('blurred image with signal dependent noise %4.1f %%',100*noise)
 
title(sText);
 
subplot(3,3,6);imshow(inverseFilter,[]);title('Matlab Inverse Filter');        
 
subplot(3,3,7);imshow(wienerdeblurred ,[]);title('Matlab Wiener deblurred');
subplot(3,3,8);imshow(blinddeblurred,[]);title('Matlab Blind deconv deblurred');
subplot(3,3,9);imshow(lucydeblurred,[]);title('Matlab Lucy deconv deblurred');
 

 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%==================FUNCTIONS=====================
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%--------------------------------------------------------------
function [fhh]=Inverse_Filter(fh)
N=length(fh);
C=0.172;
for i=0:N-1
    fhh(i+1)=1.0/(fh(i+1));
    if (fhh(i+1)<C)
        fhh(i+1)=1.0/C;
    end
end;
fhh=fhh./max(fhh);
 
%--------------------------------------------------------------
function [fhh]=Wiener_Filter(fh)
%SXEDIASMOS FILTROY
N=length(fh);
C=0.172;
for i=0:N-1
    fhh(i+1) =  (fh(i+1)^2 / ( (fh(i+1)^2+ C) ) )/fh(i+1) ;
    if(fhh(i+1)<C)
        fhh(i+1) = (fh(i+1)^2 / ( (fh(i+1)^2+ C) )/C );
    end; 
end;
fhh=fhh./max(fhh);
%--------------------------------------------------------------
function [fhh]=Power_Filter(fh)
%SXEDIASMOS FILTROY ................
N=length(fh);
C=0.172;
for i=0:N-1
    fhh(i+1) = sqrt( (fh(i+1)^2 / ( (fh(i+1)^2+ C) ) ) )/ fh(i+1) ;
    if(fhh(i+1)<C)
        fhh(i+1) = sqrt( (fh(i+1)^2 / ( (fh(i+1)^2+ C) ) ) )/C ;
    end; 
end;
fhh=fhh./max(fhh);
 
 
%---------------------------------------------------------------------
function [fh]=gaussianMTFb(N,sigma)
if(rem(N,2)==0), L=round(N/2+1);M=round((N/2)+2);
else L=round(N/2); M=round((N/2)+1);
end
 
for k=0:L-1
    fh(k+1)=exp( (-k^2/(2*sigma^2) ) );
end
% fh=gaussmf([0:L-1],[sigma 0] ); %SYNARTHSH TOY NMATLAB
for k=M-1:N-1
    fh(k+1) = fh(N+1-k);
end;%//i.e. mirror N/2..N-1
fh=fh./max(fh);
%----------------------------------------------------------------
function [FH]=from1dTo2dFilter(A,fh)
y=size(A,1);x=size(A,2);
N=length(fh);
z=1:length(fh);
mx=0;
FH=zeros(y,x);
for i=1:y
    for j=1:x
        k=y/2-i+1;
        m=x/2-j+1;
        ir = round(( k^2 +m^2 )^0.5);
        FH(i,j)=fh(ir+1);
    end
end
%------------------------------------------------------------------------
function [y]=deconvolveImage(A,FH)
FA=fft2(A);
FY=(FA).*fftshift(FH);
y=(real(ifft2(FY)));
 
%=========================================================================
function [B] =NormalizeMatrix(A,maxVal)
M=size(A,1);N=size(A,2);
minA=min(min(A));maxA=max(max(A));
for i=1:M
    for j=1:N
        B(i,j)=maxVal*((A(i,j)-minA)/(maxA-minA));
    end
end
 
 
%------------------------------------------------------------------------
function [y]=blurImage(A,FH)
FA=fft2(A);
FY=(FA).*fftshift(FH);
y=(real(ifft2(FY)));
 
%-----------------------------------------------------------------------
function B=addNoise(A,Noise)
M=size(A,1);N=size(A,2);
mA=mean(A(:));
for i=1:M
    for j=1:N
        B(i,j)=( A(i,j)+Noise*A(i,j)*rand() ) ;
%         B(i,j)=( A(i,j)+Noise*mA*rand() ) ;
    end
end
%------------------------------------------
function [im]=loadImage(imName)
if(imName(end-1:end) == 'cm')
    im = dicomread(imName);
else
    im = imread(imName);
end
if (size(im,3)>1)
    im=rgb2gray(im);
else
    im=im;
end


    

