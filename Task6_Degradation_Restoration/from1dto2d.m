A =[ 15    22     0     0
     28    17     0     0
      0     0     0     0
      0     0     0     0];
 
fh=[1,0.5,0.1,0.5];


y=size(A,1);x=size(A,2);N=length(fh);
z1=1;z2=1;
if (rem(y,2)==0),
    z1=0;
end
if (rem(x,2)==0) 
    z2=0;
end
 FH=zeros(y,x);
for i=0:y-1
    for j=0:x-1
        k=round(y/2-z1)-i;
        m=round(x/2-z2)-j;
        ir = round(( k^2 +m^2 )^0.5);
        FH(i+1,j+1)=fh(ir+1);
    end
end
FH