function B = addNoise(A,Noise)
M=size(A,1);N=size(A,2);
for i=1:M
    for j=1:N
        B(i,j)=( A(i,j)+Noise*A(i,j)*rand() ) ;
    end
end