function []=shiftTheorem()
clc;close all; 
X=load('ecg.txt');
x=X(200:400);
N=length(x);
subplot(3,1,1);plot(x);grid on;
xlabel('time');ylabel('signal x');
axis([1 N min(x) max(x)]);grid on;

Fx=fft(x);

%Κάνει το complex => real 
Fx_ampl=abs(Fx);

subplot(3,1,2);plot(Fx_ampl./max(Fx_ampl));grid on;hold on;
N=length(Fx_ampl);
xaxis=[N/2+1 N/2+1];yaxis=[0 max(Fx_ampl)];
line(xaxis, yaxis,'color','r');
xlabel('frequency');ylabel('Amplitude spectrum');
axis([1 N 0 1]);grid on;

% Η μετατόπιση 
y1=fftshift(Fx_ampl');
subplot(3,1,3);plot(y1./max(y1));hold on; line(xaxis, yaxis,'color','r');
axis([1 N 0 1]);grid on;    
xlabel('frequency');ylabel('spectrum shifted at N/2,N/2');
