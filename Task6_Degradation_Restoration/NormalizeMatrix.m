function [B] =NormalizeMatrix(A,maxVal)
M=size(A,1);N=size(A,2);
minA=min(min(A));maxA=max(max(A));
for i=1:M
    for j=1:N
        B(i,j)=maxVal*((A(i,j)-minA)/(maxA-minA));
    end
end