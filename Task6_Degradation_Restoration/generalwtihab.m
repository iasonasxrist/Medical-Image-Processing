function [fhh]=generalwithab(fh,a,b)
N=length(fh);
A=0.05;
C=0.0001;

for i=0:N-1
    fhh(i+1) = (((fh(i+1)^2 / ( (fh(i+1)^2 + b*A) ) ) ) ^(1-a)/ fh(i+1));
    if(fh(i+1)<A)
        fhh(i+1) = (((fh(i+1)^2 / ( (fh(i+1)^2+ b*A) ) ) )^(1-a)/ A);
    end
    if (a==1) && (fhh(i)<C)
        fhh(i)=C;
    end
    
        
end
fhh=fhh./max(fhh);

function [fhh]=wienerFilter(fh,C,a,b)
N=length(fh);
A=2*C;
for i=0:N-1
    fhh(i+1) =  ((fh(i+1)^2 / ( (fh(i+1)^2+ b*A) ) )^(1-a))/fh(i+1) ;
    if(fh(i+1)<A)
        fhh(i+1) = ((fh(i+1)^2 / ( (fh(i+1)^2+ b*A) ) )^(1-a))/A ;
    end; 
end;
fhh=fhh./max(fhh);