function im1 = expwindow(im,image_depth,tones)

im=double(im);
L=image_depth;
N=size(im,1);
M=size(im,2);
% 1-D όσες και οι τόνοι του γκρι
 for i=0:L
    w(i+1)=exp(i/100);
 end
 
 mx=max(w); mn=min(w);

 %Κανονικοποιεί τις τιμές από 0-255 μέσω εκθετική παρεμβολής
%Δηλαδή τις τροποποιεί π.χ 253=252.5
 for i=0:L

     w(i+1) = (tones-1)*(w(i+1)-mn)/(mx-mn);
 end
    
 for j=1:M
     for i=1:N
        v=im(i,j);
        t=w(v+1);
        im1(i,j) = round(t);
     end
 end

im1;