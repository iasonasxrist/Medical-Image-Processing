close all;clc;
x=[60,54,0,0]';%SHMA
Fx=fft(x); %DFT SHMATOS
disp('DFT SHMATOS');
disp(Fx)
Fh=[1,0.3,0.1,0.3]'; %MTF SYSTHMATOS
disp('MTF SYSTHMATOS');
disp(Fh)
 
%  
Fy=Fx.*Fh; % YPOBA8MISH SHMATOS STHN SYXNOTHTA
y=ifft(Fy);% IDFT SHMATOS 
y
% 
d=[0.0607     -0.1201    0.098      0.1479]';%8ORYBOS d
yd=y+d% add noise to degraded signal in the time domain
disp('YPOBA8MISMENO ME MTF KAI 8ORYBO SHMA ');
disp(yd)


