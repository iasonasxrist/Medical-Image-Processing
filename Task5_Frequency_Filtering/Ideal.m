function [fh]=Ideal(N,fco,lowhigh,enh,trans,w)
if(rem(N,2)==0), L=round(N/2+1);M=round((N/2)+2);
else L=round(N/2); M=round((N/2)+1);
end
switch lowhigh
    case 1
        fh=ones(L,1);
        for k=fco:L-1
            fh(k+1)=0+enh;%Exp LP
        end
    case 2
        fh=zeros(L,1)+enh;
        for k=fco:L-1
            fh(k+1)=1;%Exp LP
        end
    case 3%BandReject
        d=trans;
        fh=ones(N,1);
        for k=round(d-w/2):round(d+w/2)
            fh(k+1)=0+enh;%Ideal BR
        end
    case 4%Band Pass
        d=trans;
        fh=zeros(N,1)+enh;
        for k=round(d-w/2):round(d+w/2)
            fh(k+1)=1;%Ideal BR
        end
end
 
for k=M-1:N-1
    fh(k+1) = fh(N+1-k);
end;%//i.e. mirror N/2..N-1
fh=fh./max(fh);
