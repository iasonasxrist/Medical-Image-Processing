function [C]=ampl_fft2(A,id)
%YPOLOGISMOS FASMATOS EIKONAS id=0 XWRIS METATOPISH id=1--> METATOPISH STO
%(N/2,N/2)
y=size(A,1);x=size(A,2);
%/*--------   2D - FFT  ---------*/
switch id
    case 0
        C=fft2(A);
    case 1
        for i=1:y
            for j=1:x
                %Μετατοπίζει το φάσμα στο κέντρο υψώνοντας στο size της
                %image
                A(i,j)=A(i,j)*(-1)^(i+j);
            end;%j
        end;%i
        C=fft2(A);
end
C=round(10.0 * log(abs(C)+1));