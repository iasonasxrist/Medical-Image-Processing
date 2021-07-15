function [fh]=Exponential(N,ndegree,fco,lowhigh,trans)
% N=12;trans=0;lowhigh=1;
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
    case 3%BandReject
        d=trans;
        fh=zeros(850);
        for k=0:L-1
%             fh(k+1)=1.0/(1.0+0.414*( fco/(k-d+0.0001))^(2*ndegree) );
            fh(k+1)=exp(-(log(2)*(fco/(k-d)))^ndegree);
        end
    case 4%Band Pass
        d=trans;
        for k=0:L-1
%              fh(k+1)= 1 - exp(-(0.347*log(2)*(fco/(k-d)))^ndegree);
            fh(k+1)= exp(-(log(2)*((k-d)/fco))^ndegree);
        end
end
for k=M-1:N-1
    fh(k+1) = fh(N+1-k);
end %//i.e. mirror N/2..N-1
fh=fh./max(fh);

 