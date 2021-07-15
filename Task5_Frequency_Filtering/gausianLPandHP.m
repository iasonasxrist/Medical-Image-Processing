function [fh]=gausianLPandHP(N,ndegree,fco,lowhigh,trans)

 d=trans;
if(rem(N,2)==0)
    L=round(N/2+1);
    M=round((N/2)+2);
else
    L=round(N/2);
    M=round((N/2)+1);
end

switch lowhigh
    case 1
        for k=0:L-1
            fh(k+1)= exp(-(log(2)*(k/fco))^ndegree);
        end
    case 2
        for k=0:L-1
            fh(k+1)=exp(-(log(2)*(fco/k))^ndegree);
        end
        for k=0:L-1
            if (k<(N/2-trans)) 
                fh(k+1) = fh(k+1+trans);
            end
            if (k>=(N/2-trans)) 
                fh(k+1) = fh(round(N/2));
            end
            
        end
end

for k=M-1:N-1
    fh(k+1) = fh(N+1-k);
end %//i.e. mirror N/2..N-1
fh=fh./max(fh);