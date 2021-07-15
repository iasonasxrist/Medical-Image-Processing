function []=Lab5_Butterworth_filters()
clc;close all;
format short g;

A=loadImage('AA1a.BMP');
% A=loadImage('brain_CT_noisy.bmp');
A=double(A);
[A]=imNormalize(A,256);
M=size(A,1);
N=size(A,2);
Flength=round(sqrt(M^2+N^2));
type=3;%1:LP,2:HP,3:BR,4:BP
 
switch type
    case 1
  %Στις απλές αποκοπές LP και HP το fco το παίρνει από το flength
        lowhigh=1;fco=round(Flength*0.3);
        ndegree=1;trans=round(N/5);
        sText=' Butterworth LP filter';
        WC=140;WW=200;
    case 2
    %Στις απλές αποκοπές LP και HP το fco το παίρνει από το flength
        lowhigh=2;fco=round(Flength*0.3);ndegree=2;
        trans=round(Flength*0.25);
        sText=' Butterworth HP filter';
        WC=130;WW=200;
    case 3
        A=loadImage('testNoise.bmp');
        A=double(A);
        [A]=imNormalize(A,256);
        M=size(A,1);
        N=size(A,2);
        Flength=round(sqrt(M^2+N^2))
%    Στις σύνθετες αποκοπές δημιουργεί το fco από την μια 
%   διάσταση της εικονας 
        lowhigh=3;fco=round(M*0.05)
        ndegree=1;
        noise=round(N*0.3)
        %Η συχνότητα αποκοπής
        trans=noise;
        sText=' Butterworth BR filter';
        WC=130;WW=250;
    case 4
        lowhigh=4;fco=round(Flength*0.1)
        ndegree=1;trans=round(Flength*0.2)
        sText=' Butterworth BP filter';
        WC=100;WW=180;
end
[fh]=Butterworth(Flength,ndegree,fco,lowhigh,trans);
 
 
%SXEDIASMOS DIDIASTATOY FILTROY KAI FILTRARISMA EIKONAS A
[FH]=from1dTo2dFilter(A,fh);
[B]=filterImage(A,FH);
[B]=imNormalize(B,256); 
%APEIKONISH APOTELESMATAWN
[B]=APLO_PARA8YRO(B,WW,WC,255,256);
figure('units','normalized','outerposition',[0.25 0.25 0.5 0.7]) 
subplot(2,2,1);imshow(uint8(A),[]);title('ARXIKH EIKONA');
subplot(2,2,2);imshow(uint8(B),[]);title('FILTRARISMENH EIKONA');
 
%APEIKONISH FILTPOY SE 1-DIASTASH
subplot(2,2,3);plot(fh,'color','red','linewidth',3);hold on;
 
stem(Flength/2,1 ,'m','linewidth',3, 'linestyle','--');
title(['1-D FILTRO' ':' sText]);grid on;
text(Flength/2,0.1,'M/2','color','b','fontsize',12);
axis([0 Flength 0 1.05]);
s=['filter: ' sText]
legend(s, 'axis of symmetry','location','northoutside')
 
%APEIKONISH 2-DIASTATOY FASMATOS FILTROY 
subplot(2,2,4);imshow(FH);
title(['2-D FILTRO' ':' sText]);
 
 
%-----------------------------------
%-----------FUNCTIONS---------------
%-----------------------------------
function  [B]=imNormalize(A,tones)
mn=min(A(:));mx=max(A(:));
B=(tones-1)*(A-mn)/(mx-mn);
 
%----------------------------------------------------------------
function [fh]=Butterworth(N,ndegree,fco,lowhigh,trans)
% N=12;trans=0;lowhigh=1;
if(rem(N,2)==0)
    L=round(N/2+1);
    M=round((N/2)+2);
else
    L=round(N/2); 
    M=round((N/2)+1);
end
switch lowhigh
    case 1
        for k=0:L-1
            fh(k+1)=1.0/(1.0+0.414*(k/fco)^(2*ndegree) );
        end
    case 2
        for k=0:L-1
            fh(k+1)=1.0/(1.0+0.414*(fco/(k+0.0002))^(2*ndegree) );
        end
        for k=0:L-1
            if (k<(N/2-trans))  
                fh(k+1) = fh(k+1+trans);
            end
            if (k>=(N/2-trans)) 
                fh(k+1) = fh(round(N/2));
            end
        end
    case 3%BandReject
        d=trans;
        for k=0:L-1
           fh(k+1)=1.0/(1.0+0.414*( fco/(k-d+0.0001))^(2*ndegree) );
        end
    case 4%Band Pass
        d=trans;
        for k=0:L-1
           fh(k+1)=1.0/(1.0+0.414*( (k-d)/fco)^(2*ndegree) );
        end
end
for k=M-1:N-1
    fh(k+1) = fh(N+1-k);
end;%//i.e. mirror N/2..N-1
fh=fh./max(fh);
 
 
%----------------------------------
function [y]=filterImage(A,FH)
FA=fft2(A);
FY=(FA).*fftshift(FH);%METATOPISH GIATI TO FILTRO EXEI SXEDIASTEI 
% METATOPISMENO STO N/2,N/2
y=(abs(ifft2(FY)));
 
%----------------------------------------
function [FH]=from1dTo2dFilter(A,fh)
y=size(A,1);x=size(A,2);
N=length(fh);
z=1:length(fh);
mx=0;
FH=zeros(y,x);
for k=1:y
    for m=1:x
        K=y/2-k+1;
        M=x/2-m+1;
        ir = round(( K^2 +M^2 )^0.5);
        FH(k,m)=fh(ir+1);
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
%-------------------------------------------------------
%--------------SYNARTHSH: APLO PARA8YRO----------------
%-------------------------------------------------------
function [im1]=APLO_PARA8YRO(im,WW,WC,image_depth,tones)
N=size(im,1);
M=size(im,2);
Vb=(2.0*WC+WW)/2.0;
if(Vb>image_depth)
    Vb=image_depth;
end
Va=Vb-WW; 
if(Va<0)
    Va=0;
end
for i=1:N
    for j=1:M
        Vm=im(i,j);
        if (Vm<Va), t=0; end
        if (Vm>Vb), t=tones-1;end
        
        if ( Vm>=Va && Vm<=Vb)
            t=((tones-1)*(Vm-Va))/(Vb-Va);
        end
        im1(i,j)=round(t);
    end
end