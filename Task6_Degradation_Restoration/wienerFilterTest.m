function [] = wienerFilterTest()
close all;clc;
 
x=[60,54,0,0]';%ARXIKO SHMA
%YPOBA8MISH SHMATOS
Fx=fft(x) %fft ARXIKOY SHMATOS
Fh=[1,0.3,0.1,0.3]'; %MTF SYSTHMATOS
Fy=Fx.*Fh % YPOBA8MISH SHMATOS ME THN MTF
y=ifft(Fy)% YPOLOGISMOS IDFT GIA METAFORA SHMATOS STON XWRO
d=[0.0607     -0.1201    0.098      0.1479]';%8ORYBOS
yd=y+d% PROS8ESH 8ORYBOY STO HDH YPOBA8MISMENO SHMA APO THN MTF
 
%APOKATASTASH SHMATOS  
Fyd=fft(yd) %DFT TOY YPOBA8MISMENOY SHMATOS
Fw=[0.98039,  1.8519, 3.3333, 1.8519]'% wiener FILTRO
Fyy=Fyd.*Fw %FILTRARISMA STHN SYXNOTHTA
yy=ifft(Fyy) %YPOLOGISMOS IDFT GIA METAFORA FILTRARISMENOY SHMATOS STON XWRO
STDdegraded=STDerror(x,yd)
STDrestored=STDerror(x,yy)
%--------------plot signals-------------------------------
plot(x,'b','LineWidth',2);hold on;plot(yd,'--r','LineWidth',2);
plot(yy,'k','LineWidth',2);grid on;
legend('original','degraded','restored by Wiener')
%--------------------------------------------------------
function [stErr]=STDerror (x,y)
stErr=0;
for i=1:length(x)
    stErr=stErr+(x(i)-y(i))^2;
end
stErr=sqrt(stErr)/length(x);
