function []=ImProLab1_PARA8YRA_matrix()
clc;close all;


im1=[ 17    19    17    25
    13    21    21    21
    27    21    21    12
    28    18    27    13];


im1=double(im1);
N=size(im1,1);M=size(im1,2);
fprintf('ARXIKH MHTRA EIKONAS\n')
im1
image_depth=31;tones=8;
[im2]=APLH_APEIKONISH(im1,image_depth,tones);
fprintf('GRAMMIKH APEIKONISH EIKONAS:\n')
im2 %calculate image to be optimally displayed
%2.APLO PARA8YRO

WW=20;WC=15;
[im3]=APLO_PARA8YRO(im1,WW,WC,image_depth,tones);
fprintf('APLO PARA8YRO\n');
im3
 
%3. SPASTO PARA8YRO
gray_val=5;im_val=19;
[im4]=SPASTO_PARA8YRO(im1,gray_val, im_val,image_depth,tones);
fprintf('SPASTO PARA8YRO\n');
im4
 
%4. DIPLO  PARA8YRO
ww1=10;wl1=10;%1st window
ww2=10;wl2=25;%2nd window
[im5]=DIPLO_PARA8YRO(im1,ww1,wl1,ww2,wl2,image_depth,tones);
fprintf('DIPLO PARA8YRO\n');
im5
 
%-------------------------------------------------------
%--------------SYNARTHSH: APLH_APEIKONISH----------------
%-------------------------------------------------------
function [im2]=APLH_APEIKONISH(im1,image_depth,tones)
N=size(im1,1);
M=size(im1,2);
im2=zeros(N,M);%ORISMOS NEOY PINAKA POY 8A APO8HKEY8EI TO APOTELESMA
for i=1:N
    for j=1:M
        v=im1(i,j);
        t=( (tones-1)/(image_depth-0) ) * (v-0);
        im2(i,j)=round(t);
    end;
end;
%-------------------------------------------------------
%--------------SYNARTHSH: APLO PARA8YRO----------------
%-------------------------------------------------------
function [im1]=APLO_PARA8YRO(im,WW,WC,image_depth,tones)
N=size(im,1);
M=size(im,2);
Vb=(2.0*WC+WW)/2.0;if(Vb>image_depth), Vb=image_depth;end;
Va=Vb-WW; if(Va<0), Va=0;end;
for i=1:N
    for j=1:M
        Vm=im(i,j);
        if (Vm<Va), t=0; end;
        if (Vm>Vb), t=tones-1;end;
        
        if ( Vm>=Va && Vm<=Vb)
            t=((tones-1)*(Vm-Va))/(Vb-Va);
        end;
        im1(i,j)=round(t);
    end;
end;
 
%-------------------------------------------------------
%--------------SYNARTHSH: SPASTO PARA8YRO----------------
%-------------------------------------------------------
function [im1]=SPASTO_PARA8YRO(im,gray_val, im_val,image_depth,tones)
N=size(im,1);M=size(im,2);
im1=zeros(N,M);
for i=1:N
    for j=1:M
        if (im(i,j)<=im_val)
            t=((gray_val-0)/(im_val-0) )*(im(i,j)-0) + 0;
            im1(i,j)=round(t);
        end;%if
        if (im(i,j)>im_val)
            t=(  ((tones-1)-(gray_val+1))/...
                (image_depth-(im_val+1)) )*(im(i,j)-(im_val+1)) + (gray_val+1);
            im1(i,j)=round(t);
        end;%if
    end;%j
end;%i
 %-------------------------------------------------------
%--------------SYNARTHSH: DIPLO PARA8YRO----------------
%-------------------------------------------------------
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

