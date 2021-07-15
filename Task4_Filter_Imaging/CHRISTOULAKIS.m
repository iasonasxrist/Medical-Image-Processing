function []=CHRISTOULAKIS()
clc;close all;
format short g;
% Method Selection
disp('*** Method SELECTION MENU ***');
disp(' ');
disp(' 1. Median Filtering');
disp(' 2.1 Simple Smoothing');
disp(' 2.2 Star Smoothing');
disp(' 2.3 Star Enhanced Smoothing');
disp(' 2.4 Ultra Enhanced Star Smoothing');
disp(' 3.1 Laplacian 1');
disp(' 3.2 Laplacian 2');
disp(' 3.3 Laplacian 3');
disp(' 3.4 Laplacian 4');
disp(' 4.1 High Emphasis');
disp(' 4.2 High Emphasis');
disp(' 4.3 High Emphasis');
disp(' 4.4 High Emphasis');

disp(' ');
disp("Loading");disp(".");disp("..");disp("...");

selection = input('Select a display method:')

% im = imread('brain_CT_noisy.bmp');
im = imread('HEAD5.bmp');
      
switch selection
    
    case 1
 
 [im2,im] = medianfiltering(im);
 subplot(2,2,1);imshow(im,[]);title('original image');  
 subplot(2,2,2);imshow(uint8(im2));title('median filtered image');
        
    case 2.1
      
sm=[1,1,1; 
    1,1,1;
    1,1,1];

[im2]=smoothing(im, sm);
title('Original noisy image');
subplot(2,2,1);imshow(uint8(im));title('original image');
subplot(2,2,2);imshow(uint8(im2));
strm = num2str(sm(:)');
s=sprintf('Smoothing mask:\n %s ', num2str(sm(:)));
title(s);
WW=100;WC=150;image_depth=255;tones=256;

[im3]=APLO_PARA8YRO(im2,WW,WC,image_depth,tones);

subplot(2,2,3);imshow(uint8(im3));
title('windowed smoothed-image'); 

subplot(2,2,3);imshow(uint8(im3));
title('windowed smoothed-image'); 

        
     case 2.2
      
      sm=[0,1,0; 
          1,1,1;
          0,1,0];
      
[im2]=smoothing(im, sm);
title('Original noisy image');
subplot(2,2,1);imshow(uint8(im));title('original image');
subplot(2,2,2);imshow(uint8(im2));
strm = num2str(sm(:)');
s=sprintf('Smoothing mask:\n %s ', num2str(sm(:)));
title(s);
WW=100;WC=150;image_depth=255;tones=256;
[im3]=APLO_PARA8YRO(im2,WW,WC,image_depth,tones);

subplot(2,2,3);imshow(uint8(im3));
title('windowed smoothed-image'); 

subplot(2,2,3);imshow(uint8(im3));
title('windowed smoothed-image');  

     case 2.3
      
      sm=[1,1,1 
          1,2,1
          1,1,1];
      
[im2]=smoothing(im, sm);
title('Original noisy image');

subplot(2,2,1);imshow(uint8(im));title('original image');
subplot(2,2,2);imshow(uint8(im2));

strm = num2str(sm(:)');
s=sprintf('Smoothing mask:\n %s ', num2str(sm(:)));
title(s);
WW=100;WC=150;image_depth=255;tones=256;
[im3]=APLO_PARA8YRO(im2,WW,WC,image_depth,tones);

subplot(2,2,3);imshow(uint8(im3));
title('windowed smoothed-image'); 

     case 2.4
      
      sm=[1,2,1 
          2,4,2
          1,2,1];
      
[im2]=smoothing(im, sm);
title('Original noisy image');

subplot(2,2,1);imshow(uint8(im));title('original image');
subplot(2,2,2);imshow(uint8(im2));

strm = num2str(sm(:)');
s=sprintf('Smoothing mask:\n %s ', num2str(sm(:)));
title(s);
WW=100;WC=150;image_depth=255;tones=256;
[im3]=APLO_PARA8YRO(im2,WW,WC,image_depth,tones);

subplot(2,2,3);imshow(uint8(im3));
title('windowed smoothed-image'); 

subplot(2,2,3);imshow(uint8(im3));
title('windowed smoothed-image'); 


    case 3.1
        
 lm=[0,1,0 
     1,-4,1
     0,1,0];
 
D = sharpening(im,lm);
      
subplot(2,1,1);imshow(uint8(im));title('original image');
subplot(2,1,2);imshow(uint8(D));title('filtered image');

    case 3.2    
      lm=[1,1,1
          1,-8,1
          1,1,1];
      
D=sharpening(im,lm);
      
subplot(2,1,1);imshow(uint8(im));title('original image');
subplot(2,1,2);imshow(uint8(D));title('filtered image');

    case 3.3
      lm=[-1,2,-1
            2,4, 2
           -1,2,-1];
       
D=sharpening(im,lm);
      
subplot(2,1,1);imshow(uint8(im));title('original image');
subplot(2,1,2);imshow(uint8(D));title('filtered image');


    case 3.4
      lm=[1,2,1 
          2,-12,2
          1,2,1];
           
D=sharpening(im,lm);
      
subplot(2,1,1);imshow(uint8(im));title('original image');
subplot(2,1,2);imshow(uint8(D));title('filtered image');

    case 4.1
Lmask1=[0,-1,0
       -1,5,-1
        0,-1,0];
    
        high_emphasis(im,Lmask1)
    case 4.2
Lmask1=[-1,-1,-1
        -1,9,-1;
         -1,-1,-1];
     
        high_emphasis(im,Lmask1)
    case 4.3
Lmask1=[-1,-2,-1
       -2,13,-2
        -1,-2,-1];

        high_emphasis(im,Lmask1)
    case 4.4
Lmask1=[1,-2,1
       -2,5,-2
        1,-2,1];

        high_emphasis(im,Lmask1)
end 



set(gcf, 'Name', 'Designed by IasonasXrist', 'NumberTitle','On')

function [im2,im] = medianfiltering(im)

clc;close all;

if (size(im,3)>1)
    im1 = rgb2gray(im);
end
 
 im1 = double(im);
 im1 = im1*255/max(im1(:));
 im2 = medfilt2(im1); 


 

function [im2]=smoothing(im, sm)



clc; close all;
        
% 2-D CONVOLUTION


if (size(im,3)>1)
   im1=rgb2gray(im);
else 
    im1=im;
end
im1 = double(im1);
size(im1);
        
%  Mask definition
sm2 = sm./sum(sm(:));

% Convolution

im2=conv2(im1,sm2,'same'); 



function [D]=sharpening(A,lm)

clc;close all;

if (size(A,3)>1)
   A=rgb2gray(A);
else 
    A=A;
end
A=double(A);
N=size(A,1);M=size(A,2);
sprintf('N= %f  M=%f',N,M);
imageDepth=256 ;tones=256;
%plot original image
 Lmask1=lm;
figure(1);
subplot(2,1,1);imshow(A,[]);title('original image');
S=sum(sum(Lmask1));if(S<=0) S=1;end
B=conv2(A,Lmask1./S,'same'); %filter image
D=A;%equate for keeping frame
M=size(A,1); N=size(A,2);
D(2:M-1,2:N-1)=round(B(2:M-1,2:N-1));%form D
for i=1:N
    for j=1:M
        if(D(i,j)<0) 
            D(i,j)=0;end
        if(D(i,j)>imageDepth) 
            D(i,j)=imageDepth;end
    end
end
subplot(2,1,2);imshow(D,[]);title('filtered image');

function  high_emphasis(A,Lmask1)

A=double(A);
N=size(A,1);M=size(A,2);
sprintf('N= %f  M=%f',N,M);

imageDepth=256;
tones=256;
%plot original image
 
figure(1);
subplot(2,1,1);imshow(A,[]);title('original image');
 

 
S=sum(sum(Lmask1));
if(S<=0) 
    S=1;
end

B=conv2(A,Lmask1./S,'same'); %filter image
D=A;%equate for keeping frame
M=size(A,1); N=size(A,2);
D(2:M-1,2:N-1)=round(B(2:M-1,2:N-1));%form D
for i=1:N
    for j=1:M
        if(D(i,j)<0) 
        
            D(i,j)=0;
        end
        if(D(i,j)>imageDepth)
            D(i,j)=imageDepth;
        end
    end
end
subplot(2,1,2);imshow(D,[]);title('filtered image');

function [im1]=APLO_PARA8YRO(im,WW,WC,image_depth,tones)
N=size(im,1);
M=size(im,2);
Vb=(2.0*WC+WW)/2.0;
% Vb=1/2*WW+ WC;
if(Vb>image_depth), Vb=image_depth;end

Va=Vb-WW;

if(Va<0), Va=0;end

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


