% function []=sharpening(im,lm)

clc;close all;
A=imread('HEAD5.bmp');
A=double(A);
N=size(A,1);M=size(A,2);
sprintf('N= %f  M=%f',N,M);
imageDepth=256 ;tones=256;
%plot original image
%  n=0;
figure(1);
subplot(2,1,1);imshow(A,[]);title('original image');
lm=[0,1,0;1,-4,1;0,1,0]
S=sum(lm(:));
if(S<=0) 
    S=1;
end
B=conv2(A,lm./S,'same'); %filter image
D=A;%equate for keeping frame
M=size(A,1); N=size(A,2);
D(2:M-1,2:N-1)=round(B(2:M-1,2:N-1));%form D
for i=1:N
    for j=1:M
        if(D(i,j)<0)
            
            D(i,j)=0;
%             n=n+1;
        end
        if(D(i,j)>imageDepth)
            
            D(i,j)=imageDepth;
        end
    end
end
subplot(2,1,2);imshow(D,[]);title('filtered image');
