function []=DFTofSignal()
clc;close all;
N=256;
n=0:N-1;
x1=sin(2*pi*n/N);
x2=sin(2*pi*n*10/N);
x3=sin(2*pi*n*20/N);
 
y=x1+x2+x3;
subplot(3,1,1);plot(x1);hold on;plot(x2,'r');plot(x3,'k');
legend('x1=1f','x2=10f' , 'x3=20f')
xlabel('time');ylabel('signal x1, x2, x3 intensity');
axis([1 N min(x1) max(x1)]);grid on;
subplot(3,1,2);plot(y);legend('y=x1+x2+x3');grid on;
ylabel('signal y intensity');xlabel('time');
axis([1 N min(y) max(y)]);grid on;
 
Fy=fft(y);
Fy_ampl=abs(Fy);
subplot(3,1,3);stem(Fy_ampl./max(Fy_ampl));
xlabel('frequency');ylabel('y spectrum shifted at N/2,N/2');
axis([1 N 0 1]);grid on;
