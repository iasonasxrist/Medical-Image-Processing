function [fhh]=general_restoration(fh,a)

% ----wienerFilter----

switch a
    
    case 0
N=length(fh);
A=0.05;
for i=0:N-1
    fhh(i+1) =  (fh(i+1)^2 / ( (fh(i+1)^2+ A) ) )/fh(i+1) ;
    if(fh(i+1)<A)
        fhh(i+1) = (fh(i+1)^2 / ( (fh(i+1)^2+ A) )/A );
    end 
end
fhh=fhh./max(fhh);

    case 0.5
% ----- powerFilter-----
N=length(fh);
A=0.05;
for i=0:N-1
    fhh(i+1) = sqrt( (fh(i+1)^2 / ( (fh(i+1)^2+ A) ) ) )/ fh(i+1) ;
    if(fh(i+1)<A)
        fhh(i+1) = sqrt( (fh(i+1)^2 / ( (fh(i+1)^2+ A) ) ) )/A ;
    end; 
end;
fhh=fhh./max(fhh);
%--------------------------------------------------------------------
case 1
% ----inverseFilter-----
C=0.0001;
for i=1:length(Fh)
    if(Fh(i)<C), Fh(i)=C;
    end
end
Fw=1./Fh;%ORISMOS ANTISTROFOY FILTROY

end