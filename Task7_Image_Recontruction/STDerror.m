function [stErr]=STDerror (x,y)
stErr=0;
for i=1:length(x)
    stErr=stErr+(x(i)-y(i))^2;
end
stErr=sqrt(stErr)/length(x);