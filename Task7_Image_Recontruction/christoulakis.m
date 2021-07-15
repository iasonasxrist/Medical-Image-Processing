function []= christoulakis()

% ******ΤΟ MATLAB ΜΟΥ ΔΕΝ ΕΙΧΕ ΚΑΠΟΙΑ Interpolations όπως το cubic******

A = loadImage('Head5.bmp');
A = double(A);
M=size(A,1);
N=size(A,2);

diamARXIKH = diag(A);

disp('*** INTERPOLATION MENU***');
disp('0.linear');
disp('1.nearest');
disp('2.spline');
disp('3.pchip');


selection = input('Select an Interpolation:');
  switch selection
  
      case 0
          
 %KANONIKOPOIHSH MHTRAS EIKONAS
max_A=max(max(A));min_A=min(min(A));
A=(A-min_A)*(255/(max_A-min_A));%back to 0-255

tic

 %==============PLOT IMAGES================================
N_proj=180;
theta=1:N_proj;
R=radon(A,theta); %DHMIOYRGIA PROBOLWN
    
colormap('gray');
subplot(2,2,1);imshow(A,[]);title('Initial Image');
set(gcf,'Name','Designed by IasonasXrist','NumberTitle','On')     
axis equal;axis([1 size(A,2) 1 size(A,1)]);
    
%APEIKONISH  PROBOLWN

for theta=1:N_proj
    X=R(:,theta);
    subplot(2,2,3);plot(normalize(X),'color','red');
    title('Projections');
    grid on;pause(0.01);
end

fprintf("\n");
disp('*** Filter ***') 
disp('1.Ram-Lak');
disp('2.Hamming');
disp('3.Shepp-Logan');
disp('4.Cosine');
disp('5.Hann');
disp('6.none');

filterNames={'Ram-Lak','Hamming','Shepp-Logan','Cosine','Hann','none'};
filterType=input('select Filter Type:');

if (filterType>6) 
    return;
end

 I = iradon(R,1:N_proj,'linear', filterNames{filterType} ); %ANAKATASKEYH EIKONAS
  
%APEIKONISEIS PROBOLWN KAI ANAKATASKEYASMENHS EIKONAS
subplot(2,2,4);imshow(R,[]);title('Sinogram ');
axis equal;axis([1 size(R,2) 1 size(R,1)]);
 
subplot(2,2,2);imshow(I,[]);title(['Reconstructed Image', ' by ',filterNames{filterType}]);
axis equal;axis([1 size(I,2) 1 size(I,1)]);

diamDegraded  = diag(double(I));

SE = STDerror(diamARXIKH,diamDegraded);


fprintf('SE ARXIKHS VS RECONSTRUCTED IS : %.2f',SE');
%Όσο πιο μικρό είναι το MSE τόσο πιο καλό είναι το αποτέλεσμα της
%ανακατασκευής

      case 1
          
%KANONIKOPOIHSH MHTRAS EIKONAS
max_A=max(max(A));min_A=min(min(A));
A=(A-min_A)*(255/(max_A-min_A));%back to 0-255
tic
 %==============PLOT IMAGES================================
N_proj=180;
theta=1:N_proj;
R=radon(A,theta); %DHMIOYRGIA PROBOLWN
    
colormap('gray');
subplot(2,2,1);imshow(A,[]);title('Initial Image');
set(gcf,'Name','Designed by IasonasXrist','NumberTitle','On')     
axis equal;axis([1 size(A,2) 1 size(A,1)]);
    
%APEIKONISH  PROBOLWN
for theta=1:N_proj
    X=R(:,theta);
    subplot(2,2,3);plot(normalize(X),'color','red');
    title('Projections');
    grid on;pause(0.01);
end

fprintf("\n");
disp('*** Filter ***') 
disp('1.Ram-Lak');
disp('2.Hamming');
disp('3.Shepp-Logan');
disp('4.Cosine');
disp('5.Hann');
disp('6.none');

filterNames={'Ram-Lak','Hamming','Shepp-Logan','Cosine','Hann','none'};
filterType=input('select Filter Type:');
if (filterType>6) 
    return;
end

 I = iradon(R,1:N_proj,'nearest', filterNames{filterType} ); %ANAKATASKEYH EIKONAS
  
%APEIKONISEIS PROBOLWN KAI ANAKATASKEYASMENHS EIKONAS
subplot(2,2,4);imshow(R,[]);title('Sinogram ');
axis equal;axis([1 size(R,2) 1 size(R,1)]);
 
subplot(2,2,2);imshow(I,[]);title(['Reconstructed Image', ' by ',filterNames{filterType}]);
axis equal;axis([1 size(I,2) 1 size(I,1)]);

diamDegraded  = diag(double(I));

SE = STDerror(diamARXIKH,diamDegraded);

fprintf('SE ARXIKHS VS RECONSTRUCTED IS : %.2f',SE');
%Όσο πιο μικρό είναι το MSE τόσο πιο καλό είναι το αποτέλεσμα της
%ανακατασκευής

      case 2
%KANONIKOPOIHSH MHTRAS EIKONAS

max_A=max(max(A));min_A=min(min(A));
A=(A-min_A)*(255/(max_A-min_A));%back to 0-255
tic

 %==============PLOT IMAGES================================
N_proj=180;
theta=1:N_proj;
R=radon(A,theta); %DHMIOYRGIA PROBOLWN
    
colormap('gray');
subplot(2,2,1);imshow(A,[]);title('Initial Image');
set(gcf,'Name','Designed by IasonasXrist','NumberTitle','On')     
axis equal;axis([1 size(A,2) 1 size(A,1)]);
    
%APEIKONISH  PROBOLWN
for theta=1:N_proj
    X=R(:,theta);
    subplot(2,2,3);plot(normalize(X),'color','red');
    title('Projections');
    grid on;pause(0.01);
end

fprintf("\n");
disp('*** Filter ***') 
disp('1.Ram-Lak');
disp('2.Hamming');
disp('3.Shepp-Logan');
disp('4.Cosine');
disp('5.Hann');
disp('6.none');
filterNames={'Ram-Lak','Hamming','Shepp-Logan','Cosine','Hann','none'};
filterType=input('select Filter Type:');

if (filterType>6) 
    return;
end


 I = iradon(R,1:N_proj,'spline', filterNames{filterType} ); %ANAKATASKEYH EIKONAS
  
%APEIKONISEIS PROBOLWN KAI ANAKATASKEYASMENHS EIKONAS
subplot(2,2,4);imshow(R,[]);title('Sinogram ');
axis equal;axis([1 size(R,2) 1 size(R,1)]);
 
subplot(2,2,2);imshow(I,[]);title(['Reconstructed Image', ' by ',filterNames{filterType}]);
axis equal;axis([1 size(I,2) 1 size(I,1)]);


diamDegraded  = diag(double(I));

SE = STDerror(diamARXIKH,diamDegraded);


fprintf('SE ARXIKHS VS RECONSTRUCTED IS : %.2f',SE');
%Όσο πιο μικρό είναι το MSE τόσο πιο καλό είναι το αποτέλεσμα της
%ανακατασκευής


      case 3
          
%KANONIKOPOIHSH MHTRAS EIKONAS

max_A=max(max(A));min_A=min(min(A));
A=(A-min_A)*(255/(max_A-min_A));%back to 0-255
tic

 %==============PLOT IMAGES================================
N_proj=180;
theta=1:N_proj;
R=radon(A,theta); %DHMIOYRGIA PROBOLWN
    
colormap('gray');
subplot(2,2,1);imshow(A,[]);title('Initial Image');
set(gcf,'Name','Designed by IasonasXrist','NumberTitle','On')     
axis equal;axis([1 size(A,2) 1 size(A,1)]);
    
%APEIKONISH  PROBOLWN

for theta=1:N_proj
    X=R(:,theta);
    subplot(2,2,3);plot(normalize(X),'color','red');
    title('Projections');
    grid on;pause(0.01);
end

fprintf("\n");
disp('*** Filter ***') 
disp('1.Ram-Lak');
disp('2.Hamming');
disp('3.Shepp-Logan');
disp('4.Cosine');
disp('5.Hann');
disp('6.none');

filterNames={'Ram-Lak','Hamming','Shepp-Logan','Cosine','Hann','none'};
filterType=input('select Filter Type:');

if (filterType>6) 
    return;
end

I = iradon(R,1:N_proj,'pchip', filterNames{filterType} ); %ANAKATASKEYH EIKONAS
  
%APEIKONISEIS PROBOLWN KAI ANAKATASKEYASMENHS EIKONAS
subplot(2,2,4);imshow(R,[]);title('Sinogram');
axis equal;axis([1 size(R,2) 1 size(R,1)]);
 
subplot(2,2,2);imshow(I,[]);title(['Reconstructed Image', ' by ',filterNames{filterType}]);
axis equal;axis([1 size(I,2) 1 size(I,1)]);


diamDegraded  = diag(double(I));

SE = STDerror(diamARXIKH,diamDegraded);

fprintf('SE ARXIKHS VS RECONSTRUCTED IS : %.2f ',SE);
%Όσο πιο μικρό είναι το MSE τόσο πιο καλό είναι το αποτέλεσμα της
%ανακατασκευής
  end
  
  function [y]=normalize(X)
y=(X-min(X))/(max(X)-min(X));

function [stErr]=STDerror (x,y)
stErr=0;
for i=1:length(x)
    stErr=stErr+(x(i)-y(i))^2;
end
stErr=sqrt(stErr)/length(x);
  