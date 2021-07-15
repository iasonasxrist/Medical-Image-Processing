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