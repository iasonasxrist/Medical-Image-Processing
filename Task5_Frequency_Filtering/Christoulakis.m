function Christoulakis()

clc;close all;
format short g;
% Method Selection
disp('*** Method SELECTION MENU ***');
disp(' ');

disp(' 2.1 ideal LP');
disp(' 2.2 ideal HP');
disp(' 2.3 ideal BR');
disp(' 2.4 ideal BP');

disp(' 3.1 butterworth LP');
disp(' 3.2 butterworth HP');
disp(' 3.3 butterworthl BR');
disp(' 3.4 butterworth BP');

disp(' 4.1 Exponential LP');
disp(' 4.2 Exponential HP');
disp(' 4.3 Exponential BR');
disp(' 4.4 Exponential BP');


disp(' 5.1 Gaussian LP');
disp(' 5.2 Gaussian HP');
disp(' 5.3 Gaussian BR');
disp(' 5.4 Gaussian BP');


selection = input('Select a display method:');


A=loadImage('brain_CT_noisy.bmp');
A=double(A);
[A]=imNormalize(A,256);
M=size(A,1);
N=size(A,2);
Flength=round(sqrt(M^2+N^2));
      
switch selection
    
    case 2.1
        
     lowhigh=1;fco=round(Flength*0.25);trans=0;
     w=0;enh=0.0;
     sText=' Ideal LP filter';
     WC=130;WW=180;
    
        
[fh]=Ideal(Flength,fco,lowhigh,enh,trans,w);
  
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
s=['filter: ' sText]
legend(s, 'axis of symmetry','location','northoutside')
 
%APEIKONISH 2-DIASTATOY FASMATOS FILTROY 
subplot(2,2,4);imshow(FH);
title(['2-D FILTRO' ':' sText]);
  
    case 2.2
        
      lowhigh=2;fco=round(Flength*0.3);
      trans=round(Flength/20);
      w=0;enh=0.4;
      sText=' Ideal HP filter';
      WC=80;WW=200;

[fh]=Ideal(Flength,fco,lowhigh,enh,trans,w);
  
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
s=['filter: ' sText]
legend(s, 'axis of symmetry','location','northoutside')
 
%APEIKONISH 2-DIASTATOY FASMATOS FILTROY 
subplot(2,2,4);imshow(FH);
title(['2-D FILTRO' ':' sText]);

    case 2.3
      x=size(A,1);
      lowhigh=3;fco=0;enh=0.0;
      w=15;trans=N*0.3;
      sText=' Ideal BR filter';
      WC=130;WW=200;

      [fh]=Ideal(Flength,fco,lowhigh,enh,trans,w);
  
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
s=['filter: ' sText]
legend(s, 'axis of symmetry','location','northoutside')
 
%APEIKONISH 2-DIASTATOY FASMATOS FILTROY 
subplot(2,2,4);imshow(FH);
title(['2-D FILTRO' ':' sText]);

    case 2.4
      lowhigh=4;fco=round(Flength*0.01);
      trans=round(Flength/4);
      w=round(Flength/3);enh=0.7;
      sText=' Ideal BP filter';
      WC=130;WW=200;

    
    [fh]=Ideal(Flength,fco,lowhigh,enh,trans,w);
  
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
s=['filter: ' sText]
legend(s, 'axis of symmetry','location','northoutside')
 
%APEIKONISH 2-DIASTATOY FASMATOS FILTROY 
subplot(2,2,4);imshow(FH);
title(['2-D FILTRO' ':' sText]);

    case 3.1
    lowhigh=1;fco=round(Flength*0.3);
    ndegree=1;trans=round(N/5);
    sText=' Butterworth LP filter';
    WC=140;WW=200;
    [fh]=Butterworth(Flength,ndegree,fco,lowhigh,trans);
 
 
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
s=['filter: ' sText]
legend(s, 'axis of symmetry','location','northoutside')
 
%APEIKONISH 2-DIASTATOY FASMATOS FILTROY 
subplot(2,2,4);imshow(FH);
title(['2-D FILTRO' ':' sText]);
        
    case 3.2
     lowhigh=2;fco=round(Flength*0.3);ndegree=2;
     trans=round(Flength*0.25);
     sText=' Butterworth HP filter';
     WC=130;WW=200;
     [fh]=Butterworth(Flength,ndegree,fco,lowhigh,trans);
 
 
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
s=['filter: ' sText]
legend(s, 'axis of symmetry','location','northoutside')
 
%APEIKONISH 2-DIASTATOY FASMATOS FILTROY 
subplot(2,2,4);imshow(FH);
title(['2-D FILTRO' ':' sText]);
    
    case 3.3
     lowhigh=3;fco=round(M*0.05);ndegree=1;
      noise=round(N*0.3);
      trans=noise;
      sText=' Butterworth BR filter';
      WC=130;WW=250;
    
      [fh]=Butterworth(Flength,ndegree,fco,lowhigh,trans);
 
 
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
s=['filter: ' sText]
legend(s, 'axis of symmetry','location','northoutside')
 
%APEIKONISH 2-DIASTATOY FASMATOS FILTROY 
subplot(2,2,4);imshow(FH);
title(['2-D FILTRO' ':' sText]);
     
    case 3.4
     lowhigh=4;fco=round(Flength*0.1);
     ndegree=1;trans=round(Flength*0.2);
     sText=' Butterworth BP filter';
     WC=100;WW=180;
     [fh]=Butterworth(Flength,ndegree,fco,lowhigh,trans);
 
 
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
s=['filter: ' sText]
legend(s, 'axis of symmetry','location','northoutside')
 
%APEIKONISH 2-DIASTATOY FASMATOS FILTROY 
subplot(2,2,4);imshow(FH);
title(['2-D FILTRO' ':' sText]);
        
    case 4.1
      lowhigh=1;fco=round(Flength*0.1)
      ndegree=2;trans=round(N/5);
      sText=' Exponential LP filter';
      WC=140;WW=200;
      
      [fh]=Exponential(Flength,ndegree,fco,lowhigh,trans);
 
 
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

    case 4.2
        %με το ndegree αλλάζει η κλίση 
        lowhigh=2;fco=round(Flength*0.05);ndegree=1.75;
        %ανοιγεί η συνάρτηση μς το trans
        trans=round(Flength*0.005);
        sText=' Exponential HP filter';
        WC=130;WW=200;
        
   [fh]=Exponential(Flength,ndegree,fco,lowhigh,trans);
 
 
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
    
    case 4.3
        lowhigh=3;
        fco=round(M*0.1) 
        ndegree=2;
        noise=round(N*0.2)
        trans=noise;
%         w=10;
        sText=' Exponential BR filter';
        WC=140;WW=200;
        
   [fh]=Exponential(Flength,ndegree,fco,lowhigh,trans);
 
 
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

    case 4.4
          lowhigh=4;
        fco=round(Flength*0.05);
%         w=10;
        ndegree=2;
        trans=round(Flength*0.1);
        sText=' Exponential BP filter';
        WC=180;WW=200;      
        
        
 [fh]=Exponential(Flength,ndegree,fco,lowhigh,trans);
 
 
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



    case 5.1
      
       lowhigh=1;fco=round(Flength*0.1);
        ndegree=1;trans=round(N/6);
        sText=' Gaussian LP filter';
        WC=140;WW=200;
      
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
        
        
      
    case 5.2
        
       lowhigh=2;fco=round(Flength*0.1);ndegree=1;
        %ανοιγεί η συνάρτηση μς το trans
        trans=round(Flength*0.005);
        sText=' Gaussian HP filter';
        WC=130;WW=200;
        
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


    case 5.3
                
        lowhigh=3;
        fco=round(M*0.1) 
        ndegree=1;
        noise=round(N*0.2)
        trans=noise;
%         w=10;
        sText=' Gaussian BR filter';
        WC=140;WW=200;
        
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
        
        
    case 5.4     
         lowhigh=4;
        %Μικραίνει το μέγεθος του κύκλου . Άρα το πλήθος των υψηλών συχνοτήτων
        fco=round(Flength*0.025);
%         w=10;
        ndegree=1;
        %Μικραίνει το εύρος του κύκλου . Άρα το εύρος των υψηλών συχνοτήτων
        trans=round(Flength*0.05);
        sText=' Gaussian BP filter';
        WC=140;WW=200;  
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
end

%-------------------------Ideal Filter----------------------------
function [fh]=Ideal(N,fco,lowhigh,enh,trans,w)
if(rem(N,2)==0), L=round(N/2+1);M=round((N/2)+2);
else L=round(N/2); M=round((N/2)+1);
end
switch lowhigh
    case 1
        fh=ones(L,1);
        for k=fco:L-1
            fh(k+1)=0+enh;%Exp LP
        end
    case 2
        fh=zeros(L,1)+enh;
        for k=fco:L-1
            fh(k+1)=1;%Exp LP
        end
    case 3%BandReject
        d=trans;
        fh=ones(N,1);
        for k=round(d-w/2):round(d+w/2)
            fh(k+1)=0+enh;%Ideal BR
        end
    case 4%Band Pass
        d=trans;
        fh=zeros(N,1)+enh;
        for k=round(d-w/2):round(d+w/2)
            fh(k+1)=1;%Ideal BR
        end
end
 
for k=M-1:N-1
    fh(k+1) = fh(N+1-k);
end;%//i.e. mirror N/2..N-1
fh=fh./max(fh);


%-------------------------Butterworth Filter----------------------------
function [fh]=Butterworth(N,ndegree,fco,lowhigh,trans)
% N=12;trans=0;lowhigh=1;
if(rem(N,2)==0), L=round(N/2+1);M=round((N/2)+2);
else L=round(N/2); M=round((N/2)+1);
end
switch lowhigh
    case 1
        for k=0:L-1
            fh(k+1)=1.0/(1.0+0.414*(k/fco)^(2*ndegree) );
        end
    case 2
        for k=0:L-1
            fh(k+1)=1.0/(1.0+0.414*(fco/(k+0.0002))^(2*ndegree) );
        end
        for k=0:L-1
            if (k<(N/2-trans))  fh(k+1) = fh(k+1+trans);end;%if
            if (k>=(N/2-trans)) fh(k+1) = fh(round(N/2));end;%if
        end;%k
    case 3%BandReject
        d=trans;
        for k=0:L-1
            fh(k+1)=1.0/(1.0+0.414*( fco/(k-d+0.0001))^(2*ndegree) );
        end
    case 4%Band Pass
        d=trans;
        for k=0:L-1
            fh(k+1)=1.0/(1.0+0.414*( (k-d)/fco)^(2*ndegree) );
        end
end
for k=M-1:N-1
    fh(k+1) = fh(N+1-k);
end%//i.e. mirror N/2..N-1
fh=fh./max(fh);
%------------------------Exponential Filter----------------------------
function [fh]=Exponential(N,ndegree,fco,lowhigh,trans)
% N=12;trans=0;lowhigh=1;
 d=trans;
if(rem(N,2)==0)
    L=round(N/2+1);
    M=round((N/2)+2);
else
    L=round(N/2);
    M=round((N/2)+1);
end
switch lowhigh
    case 1
        for k=0:L-1
            fh(k+1)= exp(-(log(2)*(k/fco))^ndegree);
        end
    case 2
        for k=0:L-1
            fh(k+1)=exp(-(log(2)*(fco/k))^ndegree);
        end
        for k=0:L-1
            if (k<(N/2-trans)) 
                fh(k+1) = fh(k+1+trans);
            end
            if (k>=(N/2-trans)) 
                fh(k+1) = fh(round(N/2));
            end
            
        end
    case 3%BandReject
        d=trans;
        fh=zeros(850);
        for k=0:L-1
%             fh(k+1)=1.0/(1.0+0.414*( fco/(k-d+0.0001))^(2*ndegree) );
            fh(k+1)=exp(-(log(2)*(fco/(k-d)))^ndegree);
        end
    case 4%Band Pass
        d=trans;
        for k=0:L-1
%              fh(k+1)= 1 - exp(-(0.347*log(2)*(fco/(k-d)))^ndegree);
            fh(k+1)= exp(-(log(2)*((k-d)/fco))^ndegree);
        end
end
for k=M-1:N-1
    fh(k+1) = fh(N+1-k);
end %//i.e. mirror N/2..N-1
fh=fh./max(fh);

 
%----------------------------------
function [y]=filterImage(A,FH)
FA=fft2(A);
FY=(FA).*fftshift(FH);%METATOPISH GIATI TO FILTRO EXEI SXEDIASTEI 
% METATOPISMENO STO N/2,N/2
y=(abs(ifft2(FY)));
 
%----------------------------------------
function [FH]=from1dTo2dFilter(A,fh)
y=size(A,1);x=size(A,2);
N=length(fh);
z=1:length(fh);
mx=0;
FH=zeros(y,x);
for k=1:y
    for m=1:x
        K=y/2-k+1;
        M=x/2-m+1;
        ir = round(( K^2 +M^2 )^0.5);
        FH(k,m)=fh(ir+1);
    end
end

function [im1]=APLO_PARA8YRO(im,WW,WC,image_depth,tones)
N=size(im,1);
M=size(im,2);
Vb=(2.0*WC+WW)/2.0;
if(Vb>image_depth)
    Vb=image_depth;
end
Va=Vb-WW; 
if(Va<0)
    Va=0;
end
for i=1:N
    for j=1:M
        Vm=im(i,j);
        if (Vm<Va), t=0; end
        if (Vm>Vb), t=tones-1;end
        
        if ( Vm>=Va && Vm<=Vb)
            t=((tones-1)*(Vm-Va))/(Vb-Va);
        end
        im1(i,j)=round(t);
    end
end

function  [B]=imNormalize(A,tones)
mn=min(A(:));mx=max(A(:));
B=(tones-1)*(A-mn)/(mx-mn);

function [im]=loadImage(imName)
if(imName(end-1:end) == 'cm')
    im = dicomread(imName);
else
    im = imread(imName);
end
if (size(im,3)>1)
    im=rgb2gray(im);
else
    im=im;
end

% function filtered_image = gaussianbpf(I,d0,d1)
% % Butterworth Bandpass Filter
% % This simple  function was written for my Digital Image Processing course
% % at Eastern Mediterranean University taught by
% % Assoc. Prof. Dr. Hasan Demirel
% % for the 2010-2011 Spring Semester
% % for the complete report:
% % http://www.scribd.com/doc/51981950/HW4-Frequency-Domain-Bandpass-Filtering
% %
% % Written By:
% % Leonardo O. Iheme (leonardo.iheme@cc.emu.edu.tr)
% % 24th of March 2011
% %
% %   I = The input grey scale image
% %   d0 = Lower cut off frequency
% %   d1 = Higher cut off frequency
% 
% % Usage GAUSSIANBPF(I,DO,D1)
% % Example
% % ima = imread('brain_CT_noisy.bmp');
% % ima = rgb2gray(ima);
% % filtered_image = gaussianbpf(ima,13,77);
% 
% % Gaussian Bandpass Filter
% f = double(I);
% [nx ny] = size(f);
% f = uint8(f);
% fftI = fft2(f,2*nx-1,2*ny-1);
% fftI = fftshift(fftI);
% subplot(2,2,1)
% imshow(f,[]);
% title('Original Image')
% 
% % fftshow(fftI,'log')
% % title('Fourier Spectrum of Image')
% % Initialize filter.
% filter1 = ones(2*nx-1,2*ny-1);
% filter2 = ones(2*nx-1,2*ny-1);
% filter3 = ones(2*nx-1,2*ny-1);
% for i = 1:2*nx-1
%     for j =1:2*ny-1
%         dist = ((i-(nx+1))^2 + (j-(ny+1))^2)^.5;
%         % Use Gaussian filter.
%         filter1(i,j) = exp(-dist^2/(2*d1^2));
%         filter2(i,j) = exp(-dist^2/(2*d0^2));
%         filter3(i,j) = 1.0 - filter2(i,j);
%         filter3(i,j) = (filter1(i,j).*filter3(i,j));
%     end
% end
% % subplot(2,2,2)
% % 
% % plot(dist,'color','red','linewidth',3);hold on;
% % Update image with passed frequencies
% filtered_image = fftI + filter3.*fftI;
% 
% filtered_image = ifftshift(filtered_image);
% filtered_image = ifft2(filtered_image,2*nx-1,2*ny-1);
% filtered_image = real(filtered_image(1:nx,1:ny));
% filtered_image = uint8(filtered_image);
% subplot(2,2,2)
% imshow(filtered_image,[])
% title('Bandpass Filtered Image')
% 
% subplot(2,2,3)
% fftshow(filter3,'log')
% title('Frequency Domain Filter Function Image')

%-----------------------------Gaussian-------------------------------------------

function [fh]=Gaussian(N,ndegree,fco,lowhigh,trans)

%  d=trans;
if(rem(N,2)==0)
    L=round(N/2+1);
    M=round((N/2)+2);
else
    L=round(N/2);
    M=round((N/2)+1);
end

switch lowhigh
    case 1
       
        for k=0:L-1
           fh(k+1)=exp(-0.347*(k^2/(2*fco^2))^ndegree);
        end
    case 2
        for k=0:L-1
           fh(k+1)= exp(-0.347*(fco^2/(2*k^2))^ndegree);
        end
        for k=0:L-1
            if (k<(N/2-trans)) 
                fh(k+1) = fh(k+1+trans);
            end
            if (k>=(N/2-trans)) 
                fh(k+1) = fh(round(N/2));
            end
            
        end
          case 3%BandReject
        d=trans;
        
        for k=0:L-1
%             fh(k+1)=1.0/(1.0+0.414*( fco/(k-d+0.0001))^(2*ndegree) );
            fh(k+1)=exp(-0.347*((fco^2/(2*(k-d)^2)))^ndegree);
        end
    case 4%Band Pass
        d=trans;
        for k=0:L-1
%              fh(k+1)= 1 - exp(-(0.347*log(2)*(fco/(k-d)))^ndegree);
            fh(k+1)= exp(-0.347*(((k-d)^2/(2*fco^2)))^ndegree);
        end
end

for k=M-1:N-1
    fh(k+1) = fh(N+1-k);
end %//i.e. mirror N/2..N-1
fh=fh./max(fh);