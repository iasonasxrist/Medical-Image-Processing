function [fh]=gaussianMTF(N)
if(rem(N,2)==0)
    L=round(N/2+1);M=round((N/2)+2);
else
    L=round(N/2); M=round((N/2)+1);
end
sigma=L/2-1;
for k=0:L-1
    fh(k+1)=exp( (-k^2/(2*sigma^2) ) );
end
% fh=gaussmf([0:L-1],[sigma 0] ); %SYNARTHSH TOY MATLAB
for k=M-1:N-1
    fh(k+1) = fh(N+1-k);
end%//i.e. mirror N/2..N-1
fh=fh./max(fh);