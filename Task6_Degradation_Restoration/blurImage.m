function [y]=blurImage(A,FH)
FA=fft2(A);
FY=(FA).*fftshift(FH);
y=(real(ifft2(FY)));