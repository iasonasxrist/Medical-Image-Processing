function [im1]=SPASTO_PARA8YRO(im,gray_val, im_val,image_depth,tones)
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
        end%if
    end%j
end%i
