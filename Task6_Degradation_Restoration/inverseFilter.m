function [Fw]=inverseFilter(Fh)
C=0.0001;
for i=1:length(Fh)
    if(Fh(i)<C), Fh(i)=C;
    end
end
Fw=1./Fh;%ORISMOS ANTISTROFOY FILTROY
