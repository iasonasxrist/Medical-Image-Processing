clc; close all;
%1.SHMA STON XRONO/XWRO
x=[3,9,0,0];
%2. YPOBA8MISH SHMATOS ME THN MTF SYSTHMATOS
%2.1. MTF SYSTHMATOS STIS SYXNOTHTES
Fh=[1,0.5,0.1,0.5];
%2.2 YPOBA8MISH ME MTF  
Fx=fft(x);%FFT TOY SHMATOS
Fy=Fx.*Fh;%YPOBA8MISH ME MTF STO PEDIO SYXNOTHTAS
y=ifft(Fy); %EYRESH YPOBA8MISMENOY SHMATOS 
            %STO PEDIO TOY XWROY/XRONOY 
%2.3. add noise
noiseLevel=0.00;
ydegraded=y+y*noiseLevel*rand(length(x));
 
%2.4. EKTYPWSH YPOBA8MISMENOY SHMATOS
fprintf('ARXIKO SHMA:');
fprintf('%4.2f ',x)
fprintf('\nYPOBA8MISMENO SHMA: ');
fprintf('%4.2f ',ydegraded)
fprintf('\n');
 
%3. APOKATASTASH SHMΑTOS ME TO ANTISTROFO FILTRO
Fw=1./Fh;%ORISMOS ANTISTROFOY FILTROY
Fydegraded=fft(ydegraded);
yFilt=ifft(Fydegraded.*Fw);%FILTRARISMA SHMATOS
 
fprintf('ARXIKO SHMA:');
fprintf('%4.2f ',x)
 
fprintf('\nFILTRARISMENO SHMA ME 8ORYBO %4.2f%%:',noiseLevel);
fprintf('  %4.2f ',yFilt)
fprintf('\n');

