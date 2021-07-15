function [im1]=DIPLO_PARA8YRO(im,ww1,wl1,ww2,wl2,image_depth,tones)
N=size(im,1);M=size(im,2);

half= (tones/2)-1;
ve1=round ( (2.0*wl1+ww1)/2.0 );
vs1=ve1-ww1;
ve2=round ( (2.0*wl2+ww2)/2.0 );
vs2=ve2-ww2;

if(vs2<ve1) 
    new_point=round ( ((vs2+ve1))/2.0);
    ve1=new_point;
    vs2=ve1;
end
if(vs1<0) vs1=0;end
if(ve2>image_depth) ve2=image_depth;end
im1=zeros(N,M);
for i=1:N
    for j=1:M 
        if (im(i,j)<vs1) im1(i,j)=0; end
        if ( im(i,j) >= vs1 && im(i,j)<=ve1 ) 
            t= round ( (  (half-0)/(ve1-vs1) )*(im(i,j)-vs1) + 0.0);
            im1(i,j)=round(t);
        end
        if ( im(i,j)>ve1 && im(i,j)<vs2 )
            im1(i,j)=half+1;
        end
        if ( im(i,j)>=vs2 && im(i,j)<=ve2 )
            t= round ( (  ( (tones-1)-(half+1) )/(ve2-vs2) )*(im(i,j)-vs2) + (half+1));
            im1(i,j)=round(t);
        end
        if (im(i,j)>ve2) 
            im1(i,j)=tones-1;
        end
    end
end
