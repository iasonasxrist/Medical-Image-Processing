tic% function [im1] = DIPLO_PARA8YRO(im,ww1,wl1,ww2,wl2,image_depth,tones)
imageFile='Lung_130.bmp';
im=loadImage(imageFile);
im=double(im);
image_depth=256;tones=256;

wl1=10;ww1=50;
wl2=140;ww2=80;

N=size(im,1);M=size(im,2);
half = ((tones/2)-1);

%οριζω τα ακρα του 1ου παράθυρου
ve1=round((wl1 + 1/2*ww2))
vs1 = wl1 - 1/2*ww1

%οριζω τα ακρα του 2ου παράθυρου

ve2=(round(wl2 + 1/2*ww2))
vs2=wl2- 1/2*ww2

if(vs2<ve1)
    new_point=(round((vs2+ve1)/2.0));
    ve1 = new_point;
    vs2 = ve1;
end
%Θέτει 0 το κατώτατο άκρο του 1ου παράθυρου 
if (vs1<0) vs1=0;end

%Θέτει 255 το ανώτατο άκρο του 2ου παράθυρου σε περίπτωση που ξεφύγει
if (ve2>image_depth) ve2 = image_depth; end

% 0.011737 seconds.
%0.007360 seconds.
im1=zeros(N,M);





for i=1:N
    for j=1:M

        if im(i,j)<vs1 im(i,j)=0; end
        
         if (im(i,j)>=vs1) && (im(i,j)<=ve1)
         
             t= round(((half-0)/(ve1-vs1)*(im(i,j)-vs1) +0.0));
             im1(i,j)=round(t);
         end
         
         if  (im(i,j)>ve1 && im(i,j)<vs2 )
            im1(i,j)=half+1;

         end
         
         if (im(i,j) >=vs2 && im(i,j)<= ve2)
             
           t= round ( (  ( (tones-1)-(half+1) )/(ve2-vs2) )*(im(i,j)-vs2) + (half+1));             
             im1(i,j)=round(t); 
             
         end
         
          if im(i,j)>ve2
             im(i,j)=tones-1;
         end
    end
end
        
        
        
        imshow(im1,[]);
        
        
        
        
toc