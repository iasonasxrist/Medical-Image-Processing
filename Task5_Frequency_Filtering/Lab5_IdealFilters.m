function []=Lab5_IdealFilters()
clc;close all;
format short g
% A=loadImage('AA1a.BMP');
A=loadImage('brain_CT_noisy.bmp');
A=double(A);
[A]=imNormalize(A,256);
M=size(A,1);
N=size(A,2);
Flength=round(sqrt(M^2+N^2))
 
type=3; %1:LP,2:HP,3:BR,4:BP
 
switch (type)
    case 1
        lowhigh=1;fco=round(Flength*0.25);trans=0;
        w=0;enh=0.0;
        sText=' Ideal LP filter';
        WC=130;WW=180;
    case 2
        lowhigh=2;fco=round(Flength*0.3);
        trans=round(Flength/20);
        w=0;enh=0.4;
        sText=' Ideal HP filter';
        WC=80;WW=200;
    case 3
        A=loadImage('testNoise.bmp');
        A=double(A);
        [A]=imNormalize(A,256);
        M=size(A,1);
        N=size(A,2);
        Flength=round(sqrt(M^2+N^2));
        x=size(A,1);
        lowhigh=3;fco=0;enh=0.0;
        w=15;trans=N*0.3;
        sText=' Ideal BR filter';
        WC=130;WW=200;
    case 4
        lowhigh=4;fco=round(Flength*0.01)
        %το κέντρο του παραθύρου
        trans=round(Flength/4)
        %εύρος του παράθυρου
        w=round(Flength/3)
        enh=0.7;
        sText=' Ideal BP filter';
        WC=130;WW=200;
end
 
[fh]=Ideal(Flength,fco,lowhigh,enh,trans,w);
  
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
 
%------------------------------------------------
function [fh]=Ideal(N,fco,lowhigh,enh,trans,w)
if(rem(N,2)==0)
    L=round(N/2+1);M=round((N/2)+2);
else
    L=round(N/2); M=round((N/2)+1);
end
switch lowhigh
    case 1
        fh=ones(L,1);
        for k=fco:L-1
            fh(k+1)=0+enh;%Exp LP
        end
    case 2
        fh=zeros(L,1)+enh;
        for k=fco:L-1
            fh(k+1)=1;%Exp HP
        end
    case 3%BandReject
        d=trans;
        fh=ones(N,1);
        for k=round(d-w/2):round(d+w/2)
            fh(k+1)=0+enh;%Ideal BR
        end
    case 4%Band Pass
        d=trans;
        fh=zeros(N,1)+enh;
        for k=round(d-w/2):round(d+w/2)
            fh(k+1)=1;%Ideal BR
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
Vb=(2.0*WC+WW)/2.0;if(Vb>image_depth), Vb=image_depth;end;
Va=Vb-WW; if(Va<0), Va=0;end;
for i=1:N
    for j=1:M
        Vm=im(i,j);
        if (Vm<Va), t=0; end;
        if (Vm>Vb), t=tones-1;end;
        
        if ( Vm>=Va && Vm<=Vb)
            t=((tones-1)*(Vm-Va))/(Vb-Va);
        end;
        im1(i,j)=round(t);
    end;
end;

