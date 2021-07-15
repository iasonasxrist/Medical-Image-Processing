function []=Seventh_reconstruction_excercise()
clc;close all;
A=imread('HEAD5.BMP');%Pelvis.bmp 
A=double(A);
x=size(A,1);
y=size(A,2);
Start=diag(A);
 
%KANONIKOPOIHSH MHTRAS EIKONAS
max_A=max(max(A));min_A=min(min(A));
A=(A-min_A)*(255/(max_A-min_A));%back to 0-255
disp('*** INTERPOLATION MENU ***');
disp(' ');
disp(' 1. Nearest');
disp(' 2. Linear ');
disp(' 3. Spline ');
disp(' 4. Pchip ');
disp(' ');
selection = input('Select kind of Interpolation: ');
switch selection
    case 1
N_proj=180;
theta=1:N_proj;
R=radon(A,theta); %DHMIOYRGIA PROBOLWN
colormap('gray');
subplot(2,2,1);imshow(A,[]);title('ARXIKH EIKONA');
axis equal;axis([1 size(A,2) 1 size(A,1)]);
%APEIKONISH  PROBOLWN
for theta=1:N_proj,
    X=R(:,theta);
    subplot(2,2,3);plot(normalize(X),'color','red');
    title('PROBOLES APO EIKONA');
    grid on;pause(0.01);
    end;
disp('*** FILTER MENU ***');
disp(' ');
disp(' 1. Ram-Lak');
disp(' 2. Shepp-Logan ');
disp(' 3. Cosine ');
disp(' 4. Hamming ');
disp(' 5. Hann ');
disp(' 6. None ');
disp(' ');
FilterNames= {'Ram Lak','Shepp-Logan','Cosine','Hamming','Hann','None'};
FilterTypes=input('Select Filter Type:');
%TOMOGRAFIKH ANAKATASKEYH EIKONAS APO PROBOLES   
I = iradon(R,1:N_proj,'nearest', FilterNames{FilterTypes}); %ANAKATASKEYH EIKONAS
%APEIKONISEIS PROBOLWN KAI ANAKATASKEYASMENHS EIKONAS
subplot(2,2,4);imshow(R,[]);title('OLES OI PROBOLES ');
axis equal;axis([1 size(R,2) 1 size(R,1)]);
subplot(2,2,2);imshow(I,[]);title(['ANAKATASKEYASMENH EIKONA', ' by ', FilterNames{FilterTypes}]);
axis equal;axis([1 size(I,2) 1 size(I,1)]);
    case 2
N_proj=180;
theta=1:N_proj;
R=radon(A,theta); %DHMIOYRGIA PROBOLWN
colormap('gray');
subplot(2,2,1);imshow(A,[]);title('ARXIKH EIKONA');
axis equal;axis([1 size(A,2) 1 size(A,1)]);
%APEIKONISH  PROBOLWN
for theta=1:N_proj,
    X=R(:,theta);
    subplot(2,2,3);plot(normalize(X),'color','red');
    title('PROBOLES APO EIKONA');
    grid on;pause(0.01);
    end;
disp('*** FILTER MENU ***');
disp(' ');
disp(' 1. Ram-Lak');
disp(' 2. Shepp-Logan ');
disp(' 3. Cosine ');
disp(' 4. Hamming ');
disp(' 5. Hann ');
disp(' 6. None ');
disp(' ');  
FilterNames= {'Ram Lak','Shepp-Logan','Cosine','Hamming','Hann','None'};
FilterTypes=input('Select Filter Type:');
%TOMOGRAFIKH ANAKATASKEYH EIKONAS APO PROBOLES   
I = iradon(R,1:N_proj,'Linear', FilterNames{FilterTypes}); %ANAKATASKEYH EIKONAS
%APEIKONISEIS PROBOLWN KAI ANAKATASKEYASMENHS EIKONAS
subplot(2,2,4);imshow(R,[]);title('OLES OI PROBOLES ');
axis equal;axis([1 size(R,2) 1 size(R,1)]);
subplot(2,2,2);imshow(I,[]);title(['ANAKATASKEYASMENH EIKONA', ' by ',FilterNames{FilterTypes}]);
axis equal;axis([1 size(I,2) 1 size(I,1)]);
    case 3 
N_proj=180;
theta=1:N_proj;
R=radon(A,theta); %DHMIOYRGIA PROBOLWN
colormap('gray');
subplot(2,2,1);imshow(A,[]);title('ARXIKH EIKONA');
axis equal;axis([1 size(A,2) 1 size(A,1)]);
%APEIKONISH  PROBOLWN
for theta=1:N_proj,
    X=R(:,theta);
    subplot(2,2,3);plot(normalize(X),'color','red');
    title('PROBOLES APO EIKONA');
    grid on;pause(0.01);
    end;
disp('*** FILTER MENU ***');
disp(' ');
disp(' 1. Ram-Lak');
disp(' 2. Shepp-Logan ');
disp(' 3. Cosine ');
disp(' 4. Hamming ');
disp(' 5. Hann ');
disp(' 6. None ');
disp(' ');
FilterNames= {'Ram Lak','Shepp-Logan','Cosine','Hamming','Hann','None'};
FilterTypes=input('Select Filter Type:');
%TOMOGRAFIKH ANAKATASKEYH EIKONAS APO PROBOLES   
I = iradon(R,1:N_proj,'spline', FilterNames{FilterTypes}); %ANAKATASKEYH EIKONAS
%APEIKONISEIS PROBOLWN KAI ANAKATASKEYASMENHS EIKONAS
subplot(2,2,4);imshow(R,[]);title('OLES OI PROBOLES ');
axis equal;axis([1 size(R,2) 1 size(R,1)]);
subplot(2,2,2);imshow(I,[]);title(['ANAKATASKEYASMENH EIKONA', ' by ',FilterNames{FilterTypes}]);
axis equal;axis([1 size(I,2) 1 size(I,1)]);
    case 4
N_proj=180;
theta=1:N_proj;
R=radon(A,theta);

%DHMIOYRGIA PROBOLWN
colormap('gray');
subplot(2,2,1);imshow(A,[]);title('ARXIKH EIKONA');
axis equal;axis([1 size(A,2) 1 size(A,1)]);
%APEIKONISH  PROBOLWN
for theta=1:N_proj,
    X=R(:,theta);
    subplot(2,2,3);plot(normalize(X),'color','red');
    title('PROBOLES APO EIKONA');
    grid on;pause(0.01);
    end;
    
disp('*** FILTER MENU ***');
disp(' ');
disp(' 1. Ram-Lak');
disp(' 2. Shepp-Logan ');
disp(' 3. Cosine ');
disp(' 4. Hamming ');
disp(' 5. Hann ');
disp(' 6. None ');
disp(' ');
FilterNames= {'Ram Lak','Shepp-Logan','Cosine','Hamming','Hann','None'};
FilterTypes=input('Select Filter Type:');
%TOMOGRAFIKH ANAKATASKEYH EIKONAS APO PROBOLES   
I = iradon(R,1:N_proj,'pchip', FilterNames{FilterTypes}); %ANAKATASKEYH EIKONAS
%APEIKONISEIS PROBOLWN KAI ANAKATASKEYASMENHS EIKONAS
subplot(2,2,4);imshow(R,[]);title('OLES OI PROBOLES ');
axis equal;axis([1 size(R,2) 1 size(R,1)]);
subplot(2,2,2);imshow(I,[]);title(['ANAKATASKEYASMENH EIKONA', ' by ',FilterNames{FilterTypes}]);
axis equal;axis([1 size(I,2) 1 size(I,1)]);
end
%---------------------------------------------
function [y]=normalize(X)
y=(X-min(X))/(max(X)-min(X));

function [stErr]=STDerror (x,y)
stErr=0;
for i=1:length(x)
    stErr=stErr+(x(i)-y(i))^2;
end
stErr=sqrt(stErr)/length(x);
