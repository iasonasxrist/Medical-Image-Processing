function []=filterTomograph_V01()
close all;clc;
 
%1.DHMIOYRGIA PROBOLHS
A=imread('Pelvis.BMP');%Pelvis.bmp HEAD6.BMP
A=double(A);
theta=45;%PROBOLH SE theta MOIRES
%generate sinogram
projection=radon(A,theta);%SYNARTHSH DHMIOYRGIAS PROBOLWN TOY MATLAB 
X=projection;
%1a.--------APEIKONISH PROBOLHS 
figure(1);
subplot(2,1,1);plot(normalize(X),'LineWidth',2);grid on;
title('FILTRARISMA PROBOLHS STO PEDIO SYXNOTHTAS');
 
%2.FILTRARISMA PROBOLHS STHN SYXNOTHTA
 
%-----2a.SXEDIASMOS FILTROY STHN SYXNOTHTA
x=X;
%EPILOGH EIDOYS FILTROY
filterNames={'Ram-Lak','Hamming','Shep-Logan','Cosine'};
filterType=4;
if (filterType>4) 
    return;
end;
N=length(x);
[filt]=DesignFilter(N,filterType);%SYNARTHSH SXEDIASMOY FILTROY STHN SYXNOTHTA
%------2b. FILTRARISMA ME SXEDIASMENO FILTRO ---------------
Fx=fft(x);%DFT PROBOLHS
Fy=Fx.*filt';%FILTRARISMA STHN SYXNOTHTA
y=real(ifft(Fy));%METAFORA FILTRARISMENOY SHMATOS STON XWRO
 
%------2c. EKTYPWSH APOTELESMATWN FILTRARISMATOS STHN SYXNOTHTA 
subplot(2,1,2);plot(normalize(y),'LineWidth',2);grid on;
s=strcat('filtered sinogram by:  ',filterNames{filterType});
xlabel(s);hold on;plot(normalize(filt),'r','LineWidth',2);
s1=strcat('filter used in freq domain: ',filterNames{filterType});
legend('filtered sinogram', s1);
 
%3.FILTRARISMA PROBOLHS STON XWRO
 
%------3a. SXEDIASMOS FILTROY STON XWRO: EYRESH h(n) APO Fh(k)
xx=X;
N=length(xx);
[filt]=DesignFilter(N,filterType);%SXEDIASMOS FILTROY STHN SYXNOTHTA
FH=real(ifft(filt));%IDT TOY FILTROY 
L=51;%EPI8YMHTO MHKOS FILTROY STON XWRO (PERITTO MHKOS)
[h]=h_design(L,FH);%SXEDIASMOS FILTROY STON XWRO


%--------3b. %FILTRARISMA PROBOLHS STON XWRO.
z=conv(xx,h,'same');%CONVOLUTION GIA FILTRARISMA STON XWRO
 
%------3c. EKTYPWSH APOTELESMATWN FILTARISMATOS STON XWRO
figure(2);
subplot(2,1,1);plot(normalize(xx),'color','b','LineWidth',2);grid on;
title('FILTRARISMA PROBOLHS STON XWRO');
subplot(2,1,2);grid on;
s=strcat('filtered sinogram by:  ',filterNames{filterType});
xlabel(s);hold on;
s1=strcat('filter used in space domain: ',filterNames{filterType});
plot(normalize(z),'color','b','LineWidth',2);
plot(normalize(h),'color','r','LineWidth',2);
legend('filtered sinogram',s1);hold on;
%------------------------------------------
%----------------SYNARTHSEIS----------------
%------------------------------------------
function [filt]=DesignFilter(N,filterType)
wind=Window(N-1,filterType);
for i=1:round(N/2)
    r(i)=(i-1)/N;
end
for i=round(N/2)+1:N
    r(i)=(N-i+1)/N;
end
for i=1:N
    filt(i)=r(i)*wind(i);
end
filt=normalize(filt);
%--------------------------------------------
function [windw]=Window (length,choice)
L=length+1;
for i=1:L
    switch(choice)
        case 1
            windw(i) = 1.0;
            %Ram-Lak
        case 2
            windw(i) = 0.54+0.46*cos(2.0*pi*(i-1)/L);
            %// {Hamming}
        case 3
            windw(i) = sin(pi*round( (i-1)-L/2)/L) / (pi*(round((i-1)-L/2)/L));
            %Shepp-Logan
        case 4
            windw(i) =abs( cos(pi*round( 2*(i-1)-L/2)/L));
            % Cosine:
        otherwise
            windw(i) = 1.0;
    end
end
%------------------------------------------------------
function [filt_func]=h_design(L,fhreal)
L2=L/2.0;
even_odd=mod(L,2);
filt_func=zeros(1,L);
if (even_odd==1), L2=round(L2)+1;
    for n=1:L2
        filt_func(n+L2-even_odd)=fhreal(n);%//shift to L/2 for causality
        filt_func(n)=fhreal(L2-n+1);%// form rest of filter
    end
    % Window for Gibbs phenomenon
    for n=1:L
        h(n)=filt_func(n);
    end
end
%------------------------------------------
function [x]=normalize(y)
mn=min(y);mx=max(y);
for i=1:length(y)
        x(i)=(y(i))/(mx-mn);
end
