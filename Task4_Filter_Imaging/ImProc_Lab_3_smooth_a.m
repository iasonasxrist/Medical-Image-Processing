function []=ImProc_Lab_3_smooth_a()
format short g
%2-D CONVOLUTION
clc;close all;
A=[
30  18  12  27
18  18  23  15 
16  13  10  19 
13  19  22  22
];
sm=[1,1,1
    1,1,1
    1,1,1];
%Η συνέλιξη γίνεται για όλο τον πίνακα ....
.... αλλά εμείς θέλουμε σταθερή την κορνίζα %

B=conv2(A,sm./sum(sm(:)),'same') %filter image

D=A;%equate for keeping frame
M=size(A,1); N=size(A,2);

D(2:M-1,2:N-1)=round(B(2:M-1,2:N-1))%form D
