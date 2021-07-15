  function []= christoulakis()
clc;clear;close all;

A = loadImage('head5.bmp');
% A = imread('head5.bmp');
% if (size(A,3)==3), A=rgb2gray(A);end
A = double(A);
A = NormalizeMatrix(A,255);

M=size(A,1);N=size(A,2);
Flength = round(sqrt(M^2 + N^2));
[fh]=gaussianMTF(Flength);


disp('1. Inverse');
disp('2. Wiener');
disp('3. Power');
selection = input('Selection:');

switch selection
    
    case 1
[FH]=from1dTo2dFilter(A,fh);

%1c.IMAGE BLURRING
B=filterImage(A,FH);


%1d.PROS8ETIKOS 8ORYBOS
Noise=0.05; 
Adegraded=addNoise(B,Noise);
Adegraded=NormalizeMatrix(Adegraded,255);
 
 
%2.SXEDIASMOS SYNARTHSHS ANTISTROFOY FILTROY (FW)

M=size(Adegraded,1);N=size(Adegraded,2);
Flength=round(sqrt(M^2+N^2));
[fh]=gaussianMTF(Flength);

% [fw]=inverseFilter(fh);
a=1;
b=0;
[fw]=general_restoration(fh,a);
strType=('Inverse Filter');
[FW]=from1dTo2dFilter(Adegraded,fw);
 
%3.APOKATASTASH EIKONAS
% FW είναι το ΑΝΤΙΣΤΡΟΦΟ  
[Afilt]=filterImage(Adegraded,FW);
[Afilt]=NormalizeMatrix(Afilt,255);
 
%4.APEIKONISH APOTELESMATAWN
% figure('units','normalized','outerposition',[0 0 1 1])
 
subplot(2,3,1);imshow(A,[]);
title('ARXIKH EIKONA');
subplot(2,3,2);
imshow(Adegraded,[]);
 
strNoise=sprintf('%3.1f%%',Noise*100);
title(strcat('YPOBA8MISMENH EIKONA ME MTF + 8ORYBO:',strNoise));
subplot(2,3,3);imshow(Afilt,[]);title('FILTRARISMENH EIKONA');
subplot(2,3,4);plot(fh);title('System MTF');grid on;
subplot(2,3,5);plot(fw);title(strcat('FILTRO: ',strType));grid on;
subplot(2,3,6);imshow(FW,[]);title(strcat(' DISDIASTATO ', strType));
 
diamARXIKH = diag(double(A));
diamDegraded = diag(Adegraded);
[SE_ARX_DEGR] = STDerror(diamARXIKH,diamDegraded);
diamFiltered=diag(Afilt);
[SE_ARX_FILT] = STDerror(diamARXIKH,diamFiltered);
[SE_ARX_DEGR] = STDerror(diamARXIKH,diamDegraded);
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
        
        
    case 2
 [FH]=from1dTo2dFilter(A,fh);

%1c.IMAGE BLURRING
B=filterImage(A,FH);


%1d.PROS8ETIKOS 8ORYBOS
Noise=0.05; 
Adegraded=addNoise(B,Noise);
Adegraded=NormalizeMatrix(Adegraded,255);
 
 
%2.SXEDIASMOS SYNARTHSHS Wiener FILTROY (FW)

M=size(Adegraded,1);N=size(Adegraded,2);
Flength=round(sqrt(M^2+N^2));
[fh]=gaussianMTF(Flength);

% [fw]=wienerFilter(fh);
a=0;
b=1;
[fhh]=general_restoration(fh,a);

strType=('Wiener Filter');
[FW]=from1dTo2dFilter(Adegraded,fhh);
 
%3.APOKATASTASH EIKONAS
% FW είναι το ΑΝΤΙΣΤΡΟΦΟ  
[Afilt]=filterImage(Adegraded,FW);
[Afilt]=NormalizeMatrix(Afilt,255);
 
%4.APEIKONISH APOTELESMATAWN
% figure('units','normalized','outerposition',[0 0 1 1])
 
subplot(2,3,1);imshow(A,[]);
title('ARXIKH EIKONA');
subplot(2,3,2);
imshow(Adegraded,[]);
 
strNoise=sprintf('%3.1f%%',Noise*100);
title(strcat('YPOBA8MISMENH EIKONA ME MTF + 8ORYBO:',strNoise));
subplot(2,3,3);imshow(Afilt,[]);title('FILTRARISMENH EIKONA');
subplot(2,3,4);plot(fh);title('System MTF');grid on;
subplot(2,3,5);plot(fhh);title(strcat('FILTRO: ',strType));grid on;
subplot(2,3,6);imshow(FW,[]);title(strcat(' DISDIASTATO ', strType));
 
diamARXIKH = diag(double(A));
diamDegraded = diag(Adegraded);
[SE_ARX_DEGR] = STDerror(diamARXIKH,diamDegraded);
diamFiltered=diag(Afilt);
[SE_ARX_FILT] = STDerror(diamARXIKH,diamFiltered);
[SE_ARX_DEGR] = STDerror(diamARXIKH,diamDegraded);
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
        
        
    case 3
[FH]=from1dTo2dFilter(A,fh);

%1c.IMAGE BLURRING
B=filterImage(A,FH);


%1d.PROS8ETIKOS 8ORYBOS
Noise=0.05; 
Adegraded=addNoise(B,Noise);
Adegraded=NormalizeMatrix(Adegraded,255);
 
 
%2.SXEDIASMOS SYNARTHSHS Power FILTROY (FW)

M=size(Adegraded,1);N=size(Adegraded,2);
Flength=round(sqrt(M^2+N^2));
[fh]=gaussianMTF(Flength);
% [fw]=powerFilter(fh);

a=0.5;

[fhh]=general_restoration(fh,a);

strType=('Power Filter');
[FW]=from1dTo2dFilter(Adegraded,fhh);
 
%3.APOKATASTASH EIKONAS
% FW είναι το ΑΝΤΙΣΤΡΟΦΟ  
[Afilt]=filterImage(Adegraded,FW);
[Afilt]=NormalizeMatrix(Afilt,255);
 
%4.APEIKONISH APOTELESMATAWN
% figure('units','normalized','outerposition',[0 0 1 1])
 
subplot(2,3,1);imshow(A,[]);
title('ARXIKH EIKONA');
subplot(2,3,2);
imshow(Adegraded,[]);
 
strNoise=sprintf('%3.1f%%',Noise*100);
title(strcat('YPOBA8MISMENH EIKONA ME MTF + 8ORYBO:',strNoise));
subplot(2,3,3);imshow(Afilt,[]);title('FILTRARISMENH EIKONA');
subplot(2,3,4);plot(fh);title('System MTF');grid on;
subplot(2,3,5);plot(fhh);title(strcat('FILTRO: ',strType));grid on;
subplot(2,3,6);imshow(FW,[]);title(strcat(' DISDIASTATO ', strType));
 
diamARXIKH = diag(double(A));
diamDegraded = diag(Adegraded);
[SE_ARX_DEGR] = STDerror(diamARXIKH,diamDegraded);
diamFiltered=diag(Afilt);
[SE_ARX_FILT] = STDerror(diamARXIKH,diamFiltered);
[SE_ARX_DEGR] = STDerror(diamARXIKH,diamDegraded);
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
        
        
        
end


% --------------------------FUNCTIONS-------------------------------------

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
%-----------------------=from1dTo2dFilter---------------------------------

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
%--------------------------------NormalizeMatrix--------------------------

function [B] = NormalizeMatrix(A,maxVal)
M=size(A,1);N=size(A,2);
minA=min(min(A));maxA=max(max(A));
for i=1:M
    for j=1:N
        B(i,j)=maxVal*((A(i,j)-minA)/(maxA-minA));
    end
end

%--------------------------------addNoise---------------------------------


function B = addNoise(A,Noise)
M=size(A,1);N=size(A,2);
for i=1:M
    for j=1:N
        B(i,j)=( A(i,j)+Noise*A(i,j)*rand() ) ;
    end
end
%--------------------------------gaussianMTF------------------------------

function [fh]=gaussianMTF(N)
if(rem(N,2)==0)
    L=round(N/2+1);M=round((N/2)+2);
else
    L=round(N/2); M=round((N/2)+1);
end
sigma=L/2-1;

for k=0:L-1
    fh(k+1)=exp((-k^2/(2*sigma^2)));
end
% fh=gaussmf([0:L-1],[sigma 0] ); %SYNARTHSH TOY MATLAB
for k=M-1:N-1
    fh(k+1) = fh(N+1-k);
end;
%//i.e. mirror N/2..N-1
fh=fh./max(fh);

%--------------------------------filterImage------------------------------

function [y]=filterImage(A,FH)
FA=fft2(A);
FY=(FA).*fftshift(FH);
y=(real(ifft2(FY)));

%--------------------------------generalfilter----------------------------
function [fhh]=general_restoration(fh,a)

% ----wienerFilter----

switch a
    
    case 0
N=length(fh);
A=0.05;
for i=0:N-1
    fhh(i+1) =  (fh(i+1)^2 / ( (fh(i+1)^2+ A) ) )/fh(i+1) ;
    if(fh(i+1)<A)
        fhh(i+1) = (fh(i+1)^2 / ( (fh(i+1)^2+ A) )/A );
    end 
end
fhh=fhh./max(fhh);

    case 0.5
% ----- powerFilter-----
N=length(fh);
A=0.05;
for i=0:N-1
    fhh(i+1) = sqrt( (fh(i+1)^2 / ( (fh(i+1)^2+ A) ) ) )/ fh(i+1) ;
    if(fh(i+1)<A)
        fhh(i+1) = sqrt( (fh(i+1)^2 / ( (fh(i+1)^2+ A) ) ) )/A ;
    end 
end
fhh=fhh./max(fhh);
%--------------------------------------------------------------------
case 1
% ----inverseFilter-----
C=0.0001;
for i=1:length(fh)
    if(fh(i)<C)
        fh(i)=C;
    end
end
fhh=1./fh;%ORISMOS ANTISTROFOY FILTROY

end

%------------------------STDerror-----------------------------------------
function [stErr]=STDerror(x,y)
stErr=0;
for i=1:length(x)
    stErr=stErr+(x(i)-y(i))^2;
end
stErr=sqrt(stErr)/length(x);