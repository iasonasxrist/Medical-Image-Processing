function [im1]=APLO_PARA8YRO(im,WW,WC,image_depth,tones)
N=size(im,1);
M=size(im,2);
Vb=(2.0*WC+WW)/2.0;
if(Vb>image_depth)
    Vb=image_depth;
end
Va=Vb-WW; 
if(Va<0)
    Va=0;
end
for i=1:N
    for j=1:M
        Vm=im(i,j);
        if (Vm<Va), t=0; end
        if (Vm>Vb), t=tones-1;end
        
        if ( Vm>=Va && Vm<=Vb)
            t=((tones-1)*(Vm-Va))/(Vb-Va);
        end
        im1(i,j)=round(t);
    end
end