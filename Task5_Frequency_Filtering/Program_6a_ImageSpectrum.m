function []=Program_6a_ImageSpectrum()

clc;close all;
A=imread('pelvis.bmp');%DIABASMA EIKONAS
 
A=double(A);%METATROPH SE DOUBLE WSTE NA GINEI EFIKTH H EPE3ERGASIA
y=size(A,1);x=size(A,2);% EYRESH DIASTASEVN EIKONAS  
fprintf('x= %d  y=%d\n',x,y); %EKTYPWSH DIASTASEWN EIKONAS
B=zeros(y,x);%ARXIKOPOIHSE B GIA FASMA EIKONAS
C=zeros(y,x);%ARXIKOPOIHSE C GIA FASMA EIKONAS METATOPISMENO STO (N/2,N/2)
B=ampl_fft2(A,0);% YPOLOGISMOS MH-METATOPISMENOY FASMATOS
C=ampl_fft2(A,1);% YPOLOGISMOS METATOPISMENOY FASMATOS
 
%============PLOT IMAGES===============
colormap('gray');
subplot(1,3,1);imshow(A,[]);title('ARXIKH EIKONA');
subplot(1,3,2);imshow(B,[]);title('FASMA EIKONAS XWRIS METATOPISH');
subplot(1,3,3);imshow(C,[]);title('FASMA EIKONAS ME METATOPISH');
%================================================================
function [C]=ampl_fft2(A,id)
%YPOLOGISMOS FASMATOS EIKONAS id=0 XWRIS METATOPISH id=1--> METATOPISH STO
%(N/2,N/2)
y=size(A,1);x=size(A,2);
%/*--------   2D - FFT  ---------*/
switch id
    case 0
        C=fft2(A);
    case 1
        for i=1:y
            for j=1:x
                A(i,j)=A(i,j)*(-1)^(i+j);
            end
        end
        C=fft2(A);
end
C=round(10.0 * log(abs(C)+1));


