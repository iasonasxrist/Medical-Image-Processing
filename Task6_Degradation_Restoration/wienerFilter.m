function [fhh]=wienerFilter(fh)
N=length(fh);
A=0.05;
for i=0:N-1
    fhh(i+1) =  (fh(i+1)^2 / ( (fh(i+1)^2+ A) ) )/fh(i+1) ;
    if(fh(i+1)<A)
        fhh(i+1) = (fh(i+1)^2 / ( (fh(i+1)^2+ A) )/A );
    end; 
end;
fhh=fhh./max(fhh);
