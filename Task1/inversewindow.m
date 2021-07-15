function im1 = inversewindow(im,image_depth,tones)
im=double(im);
L=image_depth;
N=size(im,1);
M=size(im,2);


for i=0:L
   w(i+1)=(-(tones-1)/(image_depth))*(i-0)+(tones-1);
       
end
      

mx=max(w);mn=min(w);
for i=0:L
    w(i+1)=(tones-1)*(w(i+1)-mn)/(mx-mn);
end
 
% x=0:L;plot(x,w);grid on;
 for i=1:N
    for j=1:M
        v=im(i,j);
        t=w(v+1);
        im1(i,j)=round(t);
    end
 end
 
 im1;