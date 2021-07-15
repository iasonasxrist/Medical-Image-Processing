function []=tomoReconExample()
clc;close all; 
A=[ 30 18 
    12 27]
N=size(A,1);M=size(A,2);
%DHMIOYRGIA PROBOLWN SE 0,-45,-90,-135 MOIRWN
proj0=sum(A,2)';
 
B=rot90(A,2);
proj45=diagonal(B');
 
B=rot90(A,0);
proj90=sum(B,1);
 
B=rot90(A,3);
proj135=diagonal(B');
 
fprintf('\nPROBOLH    0  MOIRES:' );fprintf('%4d',proj0);
fprintf('\nPROBOLH  -45 MOIRES :' );fprintf('%4d',proj45);
fprintf('\nPROBOLH  -90 MOIRES :' );fprintf('%4d',proj90);
fprintf('\nPROBOLH -135 MOIRES :' );fprintf('%4d',proj135);
 
c=zeros(size(A,1),size(A,2));
[bproj0]=backproj(c,proj0);
[bproj45]=backprojDiag45(bproj0,proj45);
[bproj90]=backproj(bproj45',proj90)';
[bproj135]=backprojDiag135(bproj90,proj135);
fprintf('\nMETA APO OPIS8O-PROBOLH   0  MOIRES:\n' );disp(bproj0);
fprintf('\nMETA APO OPIS8O-PROBOLH -45  MOIRES:\n' );disp(bproj45);
fprintf('\nMETA APO OPIS8O-PROBOLH -90  MOIRES:\n' );disp(bproj90);
fprintf('\nMETA APO OPIS8O-PROBOLH -135 MOIRES:\n' );disp(bproj135);
ReconA=(bproj135-sum(proj135) )/(N+M-1);
fprintf('\nANAKATASKEYASMENH APO PROBOLES EIKONA  :\n' );disp(ReconA);
 
 
 
% //---------------------------------------------------
function  [c]=backproj(c, proj0)
for i=1:size(c,1)
    for j=1:size(c,2)
    c(i,j)=c(i,j)+proj0(i);
    end
end
 
% //---------------------------------------------------
function  [c]=backprojDiag45(c, proj0)
 
for j=1:size(c,2)
    ic=0;
    for i=size(c,1):-1:1
        ic=ic+1;
        c(i,j)=c(i,j)+proj0(ic+j-1);
    end
end
% //---------------------------------------------------
function  [c]=backprojDiag135(c, proj0)
 
for j=1:size(c,2)
    ic=0;
    for i=1:size(c,1)
        ic=ic+1;
        c(i,j)=c(i,j)+proj0(ic+j-1);
    end
end
 
% //-----------------------------------------------------------
function [proj45]=diagonal(B)
N=size(B,1);M=size(B,2);
K=N+M-1;ic=0;
for i=-(K-1)/2:1:(K-1)/2
    ic=ic+1;
    proj45(ic)=sum(diag(B,i));
end
