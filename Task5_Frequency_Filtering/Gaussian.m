function [fh]=Gaussian(N,ndegree,fco,lowhigh,trans)

%  d=trans;
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
           fh(k+1)=exp(-0.347*(k^2/(2*fco^2))^ndegree);
        end
    case 2
        for k=0:L-1
           fh(k+1)= exp(-0.347*(fco^2/(2*k^2))^ndegree);
        end
        for k=0:L-1
            if (k<(N/2-trans)) 
                fh(k+1) = fh(k+1+trans);
            end
            if (k>=(N/2-trans)) 
                fh(k+1) = fh(round(N/2));
            end
            
        end
          case 3%BandReject
        d=trans;
        
        for k=0:L-1
%             fh(k+1)=1.0/(1.0+0.414*( fco/(k-d+0.0001))^(2*ndegree) );
            fh(k+1)=exp(-0.347*((fco^2/(2*(k-d)^2)))^ndegree);
        end
    case 4%Band Pass
        d=trans;
        for k=0:L-1
%              fh(k+1)= 1 - exp(-(0.347*log(2)*(fco/(k-d)))^ndegree);
            fh(k+1)= exp(-0.347*(((k-d)^2/(2*fco^2)))^ndegree);
        end
end

for k=M-1:N-1
    fh(k+1) = fh(N+1-k);
end %//i.e. mirror N/2..N-1
fh=fh./max(fh);