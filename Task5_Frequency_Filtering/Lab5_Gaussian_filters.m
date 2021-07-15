% function []=Lab5_Gaussian_filters()
clc;close all;
format short g
% A=loadImage('AA1a.bmp');
A=loadImage('brain_CT_noisy.bmp');
A=double(A);
[A]=imNormalize(A,256);
M=size(A,1);
N=size(A,2);
Flength=round(sqrt(M^2+N^2));
type=4;%1:LP,2:HP,3:BR,4:BP
 
switch type
    case 1
       lowhigh=1;fco=round(Flength*0.1);
        ndegree=1;trans=round(N/6);
        sText=' Gaussian LP filter';
        WC=140;WW=200;
    case 2
        %με το ndegree αλλάζει η κλίση 
        
       lowhigh=2;fco=round(Flength*0.1);ndegree=1;
        %ανοιγεί η συνάρτηση μς το trans
        trans=round(Flength*0.005);
        sText=' Gaussian HP filter';
        WC=130;WW=200;
    case 3
                
        lowhigh=3;
        fco=round(M*0.1) 
        ndegree=1;
        noise=round(N*0.2)
        trans=noise;
%         w=10;
        sText=' Gaussian BR filter';
        WC=140;WW=200;
    case 4
        lowhigh=4;
        %Μικραίνει το μέγεθος του κύκλου . Άρα το πλήθος των υψηλών συχνοτήτων
        fco=round(Flength*0.025);
%         w=10;
        ndegree=1;
        %Μικραίνει το εύρος του κύκλου . Άρα το εύρος των υψηλών συχνοτήτων
        trans=round(Flength*0.05);
        sText=' Gaussian BP filter';
        WC=140;WW=200;
end

% [fh] = GaussianLPandHP(Flength,ndegree,fco,lowhigh,trans);
[fh]=Gaussian(Flength,ndegree,fco,lowhigh,trans);
 
 
%SXEDIASMOS DIDIASTATOY FILTROY KAI FILTRARISMA EIKONAS A

[FH]=from1dTo2dFilter(A,fh);
[B]=filterImage(A,FH);
[B]=imNormalize(B,256); 
%APEIKONISH APOTELESMATAWN
[B]=APLO_PARA8YRO(B,WW,WC,255,256);
figure('units','normalized','outerposition',[0.25 0.25 0.5 0.7]) 
subplot(2,2,1);imshow(uint8(A),[]);title('ARXIKH EIKONA');
subplot(2,2,2);imshow(uint8(B),[]);title('FILTRARISMENH EIKONA');
 
%APEIKONISH FILTPOY SE 1-DIASTASH
subplot(2,2,3);plot(fh,'color','red','linewidth',3);hold on;
 
stem(Flength/2,1 ,'m','linewidth',3, 'linestyle','--');
title(['1-D FILTRO' ':' sText]);grid on;
text(Flength/2,0.1,'M/2','color','b','fontsize',12);
axis([0 Flength 0 1.05]);
s=['filter: ' sText];
legend(s, 'axis of symmetry','location','northoutside')
 
%APEIKONISH 2-DIASTATOY FASMATOS FILTROY 
subplot(2,2,4);imshow(FH);
title(['2-D FILTRO' ':' sText]);