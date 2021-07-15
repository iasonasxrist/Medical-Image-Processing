function []=imPro_nonlinearWindow_image()

clc;echo on;close all;

im=imread('Pelvis.bmp');
im=double(im);

N=size(im,1);M=size(im,2);

choice=1;
subplot(2,1,1);
imshow(im,[])
im1=im;
image_depth=255 ;tones=256;
L=image_depth;

switch choice
    case 1
        %------------construct sin non-linear window--------------
        for i=0:L
            w(i+1)=sin(2*pi*(i)/(4*L));
        end
        s='sin-windowed image im1';
    case 2
        %------------construct exp non-linear window--------------
        for i=0:L
            w(i+1)=exp(i/100);
        end
        s='exp-windowed image im1';
    case 3
        %------------construct inverse linear window--------------
        for i=0:L
            w(i+1)=(-(tones-1)/(image_depth))*(i-0)+(tones-1);
        end
        s='inverse-windowed image im1';
end


%---normalize window between 0 and tones-1
mx=max(w);mn=min(w);
for i=0:L
    w(i+1)=(tones-1)*(w(i+1)-mn)/(mx-mn);
end
 
 x=0:L;plot(x,w);grid on;
 for i=1:N
    for j=1:M
        v=im(i,j);
        t=w(v+1);
        im1(i,j)=round(t);
    end
end
        
subplot(2,1,2);
imshow(im1,[min(min(im1)) max(max(im1))]);
xlabel(s);

 
