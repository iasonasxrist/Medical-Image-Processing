%clc;clear;

% Method Selection
disp('*** Method SELECTION MENU ***');
disp(' ');
disp(' 1. Simple linear Image');
disp(' 2. Optimized Image');

disp(' ');
selection = input('Select a method: ');

imageFile='mri256.jpg';
im1=loadImage(imageFile);
im1=double(im1);
image_depth=256;
tones=256;

switch selection
    
case 1
% Simple linear Image


[im2] = APLH_APEIKONISH(im1,image_depth,tones);
figure(1);
subplot(2,1,1);imshow(im1,[]);
title('Initial Image');
hold on;
subplot(2,1,2);imshow(im2,[0 tones-1]);
title('Simple linear Image');

case 2
% Optimized Image

[im3]=BELTISTH_APEIKONISH(im1,tones);
figure(1);
subplot(2,1,1);imshow(im1,[]);
title('Initial Image');
hold on;
subplot(2,1,2);
imshow(im3,[min(im1(:)) max(im1(:))]);
title('Optimized Image');
end

