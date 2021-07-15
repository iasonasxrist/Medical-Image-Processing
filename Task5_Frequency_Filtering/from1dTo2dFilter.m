function [FH]=from1dTo2dFilter(A,fh)
y=size(A,1);x=size(A,2);
N=length(fh);
z=1:length(fh);
mx=0;
FH=zeros(y,x);
for k=1:y
    for m=1:x
        K=y/2-k+1;
        M=x/2-m+1;
        ir = round(( K^2 +M^2 )^0.5);
        FH(k,m)=fh(ir+1);
    end
end
