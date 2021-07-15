function []=tomoReconstructionImage() 
clc;clear;close all;
A=imread('Head5.BMP');
A=double(A);
x=size(A,1);
y=size(A,2);

%KANONIKOPOIHSH MHTRAS EIKONAS
max_A=max(max(A));min_A=min(min(A));
A=(A-min_A)*(255/(max_A-min_A));%back to 0-255
tic
 %==============PLOT IMAGES================================
N_proj=180;
theta=1:N_proj;
R=radon(A,theta); %DHMIOYRGIA PROBOLWN
    
colormap('gray');
subplot(2,2,1);imshow(A,[]);title('ARXIKH EIKONA');
axis equal;axis([1 size(A,2) 1 size(A,1)]);
    
%APEIKONISH  PROBOLWN
for theta=1:N_proj
    X=R(:,theta);
    subplot(2,2,3);plot(normalize(X),'color','red');
    title('PROBOLES APO EIKONA');
    grid on;pause(0.01);
end
 
%TOMOGRAFIKH ANAKATASKEYH EIKONAS APO PROBOLES
    
strFilter='Cosine'; %ORISMOS FILTROY ANAKATASKEYHS
 
I = iradon(R,1:N_proj,'nearest',    strFilter ); %ANAKATASKEYH EIKONAS
  
%APEIKONISEIS PROBOLWN KAI ANAKATASKEYASMENHS EIKONAS
subplot(2,2,4);imshow(R,[]);title('OLES OI PROBOLES ');
axis equal;axis([1 size(R,2) 1 size(R,1)]);
 
subplot(2,2,2);imshow(I,[]);title(['ANAKATASKEYASMENH EIKONA', ' by ',strFilter]);
axis equal;axis([1 size(I,2) 1 size(I,1)]);
toc
%---------------------------------------------
function [y]=normalize(X)
y=(X-min(X))/(max(X)-min(X));


