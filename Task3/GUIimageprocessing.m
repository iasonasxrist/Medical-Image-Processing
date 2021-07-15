function [] = GUIimageprocessing()
clc;clear;close all;

imName = uigetfile('*.bmp');

im1 = loadImage(imName);
% im1 = loadImage('Pelvis.bmp');
im1 = double(im1);

N=size(im1,1);M=size(im1,2);

sprintf('N= %f  M=%f',N,M);

tones=256;image_depth=255;


disp('****MENU****');
disp('1)Equalization ');
disp('2)CDF Table');
disp('3)CDF Equation');
disp('4)CDF Matlab');
disp('5)CLAHE');
disp('')
% selection = menu('Select a technique:','Simple Display','Histogram Equalization','Modified Histogram');
selection = menu('Select a technique:',1,2,3,4,5);

switch selection
    
    
  
        
    case 1
    tones=256;image_depth=255;
    N=size(im1,1);M=size(im1,2);
    subplot(2,2,1);
    hold on;
    imshow(im1,[]);
    title('original image');

    [Z]=hEqualization(im1,tones,image_depth);
 
    subplot(2,2,3);imshow(Z,[]);title('Equalized image');

    h_A=f_histogram(im1,tones);
    h_Z=f_histogram(Z,tones);

    if(rem(M,2)>0 || rem(N,2)>0)
        h_Z=h_Z(1:end-1); 
    end 
 
    subplot(2,2,2);plot(h_A/max(h_A),'linewidth',2);
    title('original image histogram ');grid on;
 
    subplot(2,2,4);plot(h_Z/max(h_Z),'--r','linewidth',2);
    title('Equalized image histogram');grid on;
    
    set(gcf,'Name','Designed by IasonasXrist','NumberTitle','On');
        
    case 2
    [im2] = APLH_APEIKONISH(im1,image_depth,tones);
    h_A=f_histogram(im1,tones);
   
    subplot(2,2,1);
    imshow(im2,[]);grid on;
    title('original image');
    subplot(2,2,2);plot(h_A/max(h_A));
    title('original image histogram ');
    
    J1=CDF_HistMod_Table(im1,tones);
    subplot(2,2,3);imshow(J1,[]);title('HE (CDF)-Table ')
    h_J1=f_histogram(J1,tones);
    subplot(2,2,4);plot(h_J1/max(h_J1) );title('CDF-Table histogram ')
    set(gcf,'Name','Designed by IasonasXrist','NumberTitle','On')  
    
    case 3
    [im2] = APLH_APEIKONISH(im1,image_depth,tones);
    h_A=f_histogram(im1,tones);
   
    subplot(2,2,1);imshow(im2,[]);grid on;title('original image');
    subplot(2,2,2);plot(h_A/max(h_A));
    title('original image histogram ');
    
    Z=CDF_HistMod_Eqn(im1,tones);
%     
    subplot(2,2,3);imshow(Z,[]);title('HE (CDF)-Equation ')
    h_J1=f_histogram(Z,tones);
    subplot(2,2,4);plot(h_J1/max(h_J1) );title('CDF-Equation histogram ')
    
    set(gcf,'Name','Designed by IasonasXrist','NumberTitle','On')    
    
    case 4
    [im2] = APLH_APEIKONISH(im1,image_depth,tones);
    h_A=f_histogram(im1,tones);
    subplot(2,2,1);imshow(im2,[]);grid on;title('original image');
    subplot(2,2,2);plot(h_A/max(h_A));
    title('original image histogram ');
    
    Z = histeq(uint8(im1));
    subplot(2,2,3);imshow(Z,[]);title('HE (CDF) Matlab ')
    h_J1=f_histogram(Z,tones);
    subplot(2,2,4);plot(h_J1/max(h_J1) );title('CDF Matlab histogram ')
    
    set(gcf,'Name','Designed by IasonasXrist','NumberTitle','On')    
    
    case 5
    [im2] = APLH_APEIKONISH(im1,image_depth,tones);
    h_A=f_histogram(im1,tones);
   
    subplot(2,2,1);
    imshow(im2,[]);
    title('original image ');grid on;
    subplot(2,2,2);plot(h_A/max(h_A));
    title('original image histogram ');    
        
    J2 = adapthisteq(uint8(im1),'clipLimit',0.02,'Distribution','uniform');
    % 'uniform', 'rayleigh', 'exponential'
    subplot(2,2,3);imshow(J2,[]);title('CLAHE');
    h_J2=f_histogram(J2,tones);
    subplot(2,2,4);plot(h_J2/max(h_J2) );
    title('CLAHE histogram');
    set(gcf,'Name','Designed by IasonasXrist','NumberTitle','On');
end






% ----------------- APLH_APEIKONISH-----------------------------
function [im2] = APLH_APEIKONISH(im1,image_depth,tones)

N=size(im1,1);
M=size(im1,2);
im2 = zeros(N,M);
for j=1:M
    for i=1:N
       v=im1(i,j);
       t = ((tones-1)/(image_depth-0)*(v-0));
       im2(i,j) = round(t);
    end
end

% ----------------- f_histogram -----------------------------

function [h]=f_histogram(A,tones)
M=size(A,1);N=size(A,2);
tn=0:(tones-1);
C=reshape(A',M*N,1);%from 2d-->1d matrix
h=hist(C,tn);%find histogram

% ----------------- hEqualization -----------------------------

function [Z]=hEqualization(A,tones,image_depth)
%turn matrix values into image values (pixels)
N=size(A,1);M=size(A,2);
for i=1:N
    for j=1:M
        ival=A(i,j);
        tone_ival=(tones-1)*(double(ival)-0)/(image_depth-0);
        B(i,j)=tone_ival;
    end;
end;
N=size(B,1);M=size(B,2);
k=0;
Bval=zeros(N*M,1);
%from 2-d to 1-d
for i=1:N
    for j=1:M
        k=k+1;
        Bval(k)=round(B(i,j));
    end
end
clear B;
 
%sort 1-d table that holds image values
%p retains original index values in 1-d table Bval
[C,p]=sort(Bval);
clear C;
BL=length(Bval);
clear Bval;
neq=round((N*M)/tones);
zRem=rem(BL,neq);
az=fix(N*M/neq);
k=-1;
for i=1:neq:neq*az
    k=k+1;
    for j=1:neq
        D(i+j-1)=k;
    end
end
if(zRem>0)
    k=k+1;
    for i=neq*az+1:(az*neq)+zRem
        D(i)=k;
    end
end
%reassign equalized values into their proper position
k=0;
for i=1:N
    for j=1:M
        k=k+1;
        L(p(k))=D(k);
    end
end
clear D;
%turn 1-d table into 2-d table
k=0;
for i=1:N
    for j=1:M
        k=k+1;
        Z(i,j)=L(k);
    end
end
clear L;

% ----------------- CDF_HistMod_Table -----------------------------

function [B]=CDF_HistMod_Table(A,tn)
M=size(A,1);N=size(A,2);
h=f_histogram(A,tn);
CDFh=cumsum(h);
tone_values=(N*M)/tn;
q=tone_values*ones(tn,1);
CDFq=cumsum(q);
tones=0:tn-1;
if(M<=4)
    disp(' -----------Table-------------');
    disp(' tones     h    CDFh   q    CDFq  ');
    [tones' h' CDFh' q CDFq];
end
C=reshape(A',M*N,1);
C1=zeros(length(C),1);
 
for i=1:length(C)
    v1=CDFh(C(i)+1);
    for j=1:length(CDFq)
        v2=CDFq(j);
        D(j)=abs(v1-v2);
    end
    [Z,indx]=min(D);
    K(i)=tones(indx);%CDFh - CDFq correspendence
end
B=reshape(K,M,N)';

% ----------------- CDF_HistMod_Eqn -----------------------------


function [C]=CDF_HistMod_Eqn(B,tones)
B=(tones-1)*B/max(max(B));
M=size(B,1);N=size(B,2);
tone_values=(M*M)/tones;
q=tone_values*ones(tones,1);
CDFh=zeros(tones,1);CDFq=zeros(tones,1);
[h]=f_histogram(B,tones);
%form CDFs
for i=1:tones
    for j=1:i
        CDFh(i)=CDFh(i)+h(j);
        CDFq(i)=CDFq(i)+q(j);
    end
end
%calculate CDF_modified image
maxi=max(max(B));
for i=1:M
    for j=1:N
        p=B(i,j);
%         p=(tones-1)*B(i,j)/maxi;
        C(i,j)=(CDFh(round(p+1))/tone_values)-1;
        if(C(i,j)<0) C(i,j)=0;
        end
    end
end
C=round(C);

% ----------------- Load Image -----------------------------

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
