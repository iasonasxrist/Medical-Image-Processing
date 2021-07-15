function []=inverseFilterTest()

close all;clc;
x=[2,3,0,0]';%ARXIKO SHMA
Fx=fft(x); %DFT SHMATOS
Fh=[1,0.5,0.2,0.5]'; %MTF SYSTHMATOS
 
Fy=Fx.*Fh; % YPOBA8MISH APO THN MTF
y=ifft(Fy);% METAFORA STON XWRO
%ESTW 8ORYBOS
d=[0.068044     -0.23646     0.099011      0.02189]';
disp('YPOBA8MISMENO SHMA');
yd=y+d% PROS8ESH 8ORYBOY STO YPOBA8MISMENO SHMA
Fyd=fft(yd); %DFT YPOBA8MISMENOY SHMATOS APO MTF + 8ORYBO
disp('ANTISTROFO FILTRO');
Fw=inverseFilter(Fh);
%SXEDIASMOS ANTISTROFOY FILTROY
Fyy=Fyd.*Fw; %APOKATASTASH SHMATOS STHN SYXNOTHTA
disp('FILTRARISMENO SHMA');
yy=ifft(Fyy) %METAFORA TOY FILTARISMENOY SHMATOS STON XWRO
STDdegraded=STDerror(x,yd)
STDrestored=STDerror(x,yy)
 %--------------plot signals-------------------------------
plot(x,'b','LineWidth',2);hold on;plot(yd,'--r','LineWidth',2);
plot(yy,'k','LineWidth',2);grid on;
legend('original','degraded','restored');
 %-----------------------------------------------------------
function [stErr]=STDerror (x,y)
stErr=0;
for i=1:length(x)
    stErr=stErr+(x(i)-y(i))^2;
end
stErr=sqrt(stErr)/length(x);
%------------------------------------------------
function [Fw]=inverseFilter(Fh)
C=0.0001;
for i=1:length(Fh)
    if(Fh(i)<C), Fh(i)=C;
    end
end
Fw=1./Fh;%ORISMOS ANTISTROFOY FILTROY
