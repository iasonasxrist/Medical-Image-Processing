clc;clear all;close all;


% Method Selection
disp('*** Method SELECTION MENU ***');
disp(' ');
disp(' 1. Simple linear Image');
disp(' 2. Simple Window');
disp(' 3. Broken Window');
disp(' 4. Dual   Window');
disp(' 5. Sinus Window');
disp(' 6. Exponential Windowed');
disp(' 7. Inverse Windowed');

disp(' ');
selection = input('Select a method: ');

disp("Loading");disp(".");disp("..");disp("...");

%Input Data
imageFile='Lung_130.bmp';
im1=loadImage(imageFile);
im1=double(im1);
image_depth=256;
tones=256;

%Initialization

switch selection
    
  
case 1
% Simple linear Image


[im2] = APLH_APEIKONISH(im1,image_depth,tones);
figure(1);
subplot(3,1,1);imshow(im1,[]);
title('Initial Image');
hold on;
subplot(3,1,2);imshow(im2,[0 tones-1]);
title('Simple linear Image');
set(gcf, 'Name', 'Designed by IasonasXrist', 'NumberTitle', 'On')
%corr(im2(:),im1(:))==1

case 2
%Simple Window

WW=200;WC=50;
[im3] = APLO_PARA8YRO(im1,WW,WC,image_depth,tones);
figure(1);
subplot(2,1,1);imshow(im1,[]);
title('Initial Image');
hold on;
subplot(2,1,2);imshow(im3,[]);
title(['Simple Window']);
set(gcf, 'Name', 'Designed by IasonasXrist', 'NumberTitle', 'On')

case 3
%Broken Window

gray_val=120;
im_val=80;
[im4] = SPASTO_PARA8YRO(im1,gray_val, im_val,image_depth,tones);
figure(1);
subplot(2,1,1);imshow(im1,[]);
title('Initial Image');
hold on;
subplot(2,1,2);imshow(im4,[]);
title('Broken Window');
set(gcf, 'Name', 'Designed by IasonasXrist', 'NumberTitle', 'On')


case 4
% Dual  Window

ww1=50;wl1=10;
ww2=80;wl2=140;
[im5] = DIPLO_PARA8YRO(im1,ww1,wl1,ww2,wl2,image_depth,tones);
figure(1);
subplot(2,1,1);imshow(im1,[]);
title('Initial Image');
hold on;
subplot(2,1,2);imshow(im5,[]);
title('Dual   Window');
set(gcf, 'Name', 'Designed by IasonasXrist', 'NumberTitle', 'On')


case 5
%Sinus window

im1 = sinwindow(im1,image_depth,tones);
figure(1);
subplot(2,1,1);imshow(im1,[]);
title('Initial Image');
hold on;
subplot(2,1,2);
imshow(im1,[min(min(im1)) max(max(im1))]);
title('Sinus Window');
set(gcf, 'Name', 'Designed by IasonasXrist', 'NumberTitle', 'On')


case 6
%%Exponential window
 im1 = expwindow(im1,image_depth,tones);
 figure(1);
 subplot(2,1,1);imshow(im1,[]);
 title('Initial Image');
 hold on;
 subplot(2,1,2);
 imshow(im1,[min(min(im1)) max(max(im1))]);
 title('Exponential Window');
 set(gcf, 'Name', 'Designed by IasonasXrist', 'NumberTitle', 'On')

case 7
%Inverse window
im1 = inversewindow(im1,image_depth,tones);
figure(1);
subplot(2,1,1);imshow(im1,[]);
title('Initial Image');
hold on;
subplot(2,1,2);
imshow(im1,[min(min(im1)) max(max(im1))]);
title('Inverse Window');
set(gcf, 'Name', 'Designed by IasonasXrist', 'NumberTitle', 'On')

    
end

