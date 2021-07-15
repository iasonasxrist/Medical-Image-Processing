function []= CHRISTOULAKIS_IASONAS()


selection = input('Select a method:');

switch selection 
    
    case 1
        
    imageFile='pelvis.bmp';
    im1=loadImage(imageFile);
    im1=double(im1);
    N=size(im1,1);M=size(im1,2);
    image_depth=255 ;tones=64;
    tones=256;image_depth=255;
    im2 = APLH_APEIKONISH(im1,image_depth,tones); 
    subplot(3,3,1);
    hold on;
    imshow(im1,[]);
    title('original image');
    set(gcf,'Name','Designed by IasonasXrist','NumberTitle','On') 
    h_J=f_histogram(im1,tones);
    subplot(3,3,4);plot(h_J/max(h_J) ,'b' )
    title('Histogram');
    
    subplot(3,3,2);
    gray_val=100; im_val=30;
    im3 = SPASTO_PARA8YRO(im1,gray_val, im_val,image_depth,tones);
    imshow(im3,[]);
    title('Broken Window')
    
    h_J1=f_histogram(im3,tones);
    subplot(3,3,5);plot(h_J1/max(h_J1),'r' );
    title('CDF-Equation histogram ')
    
    C =CDF_HistMod_Eqn(im1,tones);
    subplot(3,3,3);
    imshow(C,[]);
    title('HE (CDF)-Equation ')
    h_J2=f_histogram(C,tones);
    subplot(3,3,6);plot(h_J2/max(h_J2) ,'r');
    title('CDF-Equation histogram ')
    
    case 2
    
    imageFile='mam1.bmp';
    im1=loadImage(imageFile);
    im1=double(im1);
    N=size(im1,1);M=size(im1,2);
    tones=256;image_depth=255;
   
    [im2,l1] = linearwindow(im1,image_depth,tones);
    subplot(3,3,1);
    hold on;
    imshow(im2,[]);
    title('Linear window')
    subplot(3,3,4);
    plot([0:image_depth],l1);
    grid on;
    title('Wavelet of Inverse');
    set(gcf,'Name','Designed by IasonasXrist','NumberTitle','On');
    
    [im3,l2] = coswindow(im1,image_depth,tones);
    subplot(3,3,2);
    hold on;
    imshow(im3,[]);
    title('Cosine Window')
    subplot(3,3,5);
    plot([0:image_depth],l2);
     grid on;
    title('Wavelet of Cosine');
    
    
    [im4,l3] = inexpwindow(im1,image_depth,tones);
    subplot(3,3,3);
    hold on;
    imshow(im4,[]);
    title('Exponential Window');
    
    subplot(3,3,6);
    plot([0:image_depth],l3);
     grid on;
    title('Wavelet of Exponential');
    
    

end

% -----------------------APLH_APEIKONISH-------------------------
function [im2]=APLH_APEIKONISH(im1,image_depth,tones)
N=size(im1,1);
M=size(im1,2);
im2=zeros(N,M);%ORISMOS NEOY PINAKA POY 8A APO8HKEY8EI  TO APOTELESMA
for i=1:N
    for j=1:M
        v=im1(i,j);
        t=( (tones-1)/(image_depth-0) ) * (v-0);
        im2(i,j)=round(t);
    end;
end;

% -----------------------SPASTO_PARA8YRO-------------------------
function [im1] = SPASTO_PARA8YRO(im,gray_val, im_val,image_depth,tones)
N=size(im,1);M=size(im,2);
im1=zeros(N,M);
for i=1:N
    for j=1:M
        if (im(i,j)<=im_val) 
            t=((gray_val-0)/(im_val-0) )*(im(i,j)-0) + 0;
            im1(i,j)=round(t);
        end%if
        if (im(i,j)>im_val) 
            t=(  ((tones-1)-(gray_val+1))/...
                (image_depth-(im_val+1)) )*(im(i,j)-(im_val+1)) + (gray_val+1);
            im1(i,j)=round(t);
        end
    end
end
% -----------------------DIPLO_PARA8YRO-------------------------
function [im1]=DIPLO_PARA8YRO(im,ww1,wl1,ww2,wl2,image_depth,tones)
N=size(im,1);M=size(im,2);

half= (tones/2)-1;
ve1=round ( (2.0*wl1+ww1)/2.0 );
vs1=ve1-ww1;
ve2=round ( (2.0*wl2+ww2)/2.0 );
vs2=ve2-ww2;

if(vs2<ve1) 
    new_point=round ( ((vs2+ve1))/2.0);
    ve1=new_point;
    vs2=ve1;
end
if(vs1<0) vs1=0;end
if(ve2>image_depth) ve2=image_depth;end
im1=zeros(N,M);
for i=1:N
    for j=1:M 
        if (im(i,j)<vs1) im1(i,j)=0; end
        if ( im(i,j) >= vs1 && im(i,j)<=ve1 ) 
            t= round ( (  (half-0)/(ve1-vs1) )*(im(i,j)-vs1) + 0.0);
            im1(i,j)=round(t);
        end
        if ( im(i,j)>ve1 && im(i,j)<vs2 )
            im1(i,j)=half+1;
        end
        if ( im(i,j)>=vs2 && im(i,j)<=ve2 )
            t= round ( (  ( (tones-1)-(half+1) )/(ve2-vs2) )*(im(i,j)-vs2) + (half+1));
            im1(i,j)=round(t);
        end
        if (im(i,j)>ve2) 
            im1(i,j)=tones-1;
        end
    end
end
% -----------------------CDF_HistMod_Eqn-------------------------
function [C]=CDF_HistMod_Eqn(B,tones)

% clc;clear;
% B= uigetfile('*.bmp');
% B = imread(B);
% B= double(B);
% tones=256;

B=(tones-1)*B/max(max(B));
M = size(B,1);N=size(B,2);
tone_values = M*M/tones;

q = tone_values*ones(tones-1);

CDFh = zeros(tones,1); CDFq = zeros(tones,1);
[h]=f_histogram(B,tones);

for i=1:tones
    for j=1:i 
       CDFh(i) = CDFh(i) + h(j);
       CDFq(i) = CDFq(i) + q(j);
    end
end



maxi = max(B(:)); 
for i=1:M
    for j=1:N
%         p=B(i,j);
        p=(tones-1)*B(i,j)/maxi;
    C(i,j)=(CDFh(round(p+1))/tone_values)-1;
    if C(i,j)<0
        C(i,j)=0;
    end
    end
end

%     C=round(C);
% ---------------------f_histogram--------------------------
function [h]=f_histogram(A,tones)
M=size(A,1);N=size(A,2);
tn=0:(tones-1);
C=reshape(A',M*N,1);%from 2d-->1d matrix
h=hist(C,tn);%find histogram
% ---------------------loadImage--------------------------
function [im1]=loadImage(imName)
if(imName(end-1:end) == 'cm')
    im = dicomread(imName);
else
    im = imread(imName);
end
if (size(im,3)>1)
    im1=rgb2gray(im);
else
    im1=im;
end
% ---------------------inexpwindow--------------------------
function [im1,l3] = inexpwindow(im,image_depth,tones)

im=double(im);
L=image_depth;
N=size(im,1);
M=size(im,2);
% 1-D όσες και οι τόνοι του γκρι
 for i=0:L
    w(i+1)=exp(-(i/L));
 end
 
 mx=max(w); mn=min(w);

 %Κανονικοποιεί τις τιμές από 0-255 μέσω εκθετική παρεμβολής
%Δηλαδή τις τροποποιεί π.χ 253=252.5
 for i=0:L

     w(i+1) = (tones-1)*(w(i+1)-mn)/(mx-mn);
 end
  l3=w;  
 for j=1:M
     for i=1:N
        v=im(i,j);
        t=w(v+1);
        im1(i,j) = round(t);
     end
 end

im1;
% ---------------------coswindow--------------------------
function [im1,l2] = coswindow(im,image_depth,tones)

im=double(im);
L=image_depth;
N=size(im,1);
M=size(im,2);

for i=0:L
   w(i+1)=cos(2*pi*(i)/(4*L));
end

mx=max(w);mn=min(w);

for i=0:L
    w(i+1)=(tones-1)*(w(i+1)-mn)/(mx-mn);
end
 l2=w;

 for i=1:N
    for j=1:M
        v=im(i,j);
        t=w(v+1);
        im1(i,j) = round(t);
    end
end
 im1;
 % ---------------------linearwindow--------------------------
 function [im1,l1] = linearwindow(im,image_depth,tones)
im=double(im);
L=image_depth;
N=size(im,1);
M=size(im,2);


for i=0:L
   w(i+1)=((tones-1)/(image_depth))*(i-0)+(tones-1);
       
end

      

mx=max(w);mn=min(w);
for i=0:L
    w(i+1)=(tones-1)*(w(i+1)-mn)/(mx-mn);
end
 l1=w;
% x=0:L;plot(x,w);grid on;
 for i=1:N
    for j=1:M
        v=im(i,j);
        t=w(v+1);
        im1(i,j)=round(t);
    end
 end
 
 
 im1;
