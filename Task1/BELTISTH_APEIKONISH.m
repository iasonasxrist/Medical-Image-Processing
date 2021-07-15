function [im3]=BELTISTH_APEIKONISH(im2,tones)
N=size(im2,1);M=size(im2,2);

im2=double(im2);

Vmax=max(im2(:));
Vmin=min(im2(:));

im3=zeros(N,M);

for i=1:N
    for j=1:M
        v=im2(i,j);
        t=((tones-1)/(Vmax-Vmin)*(v-Vmin));
        im3(i,j)=t;
    end
end

