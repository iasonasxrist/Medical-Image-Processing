function filtered_image = expbrf(I,d0,d1)
%   I = The input grey scale image
%   d0 = Lower cut off frequency
%   d1 = Higher cut off frequency

% Example
% ima = imread('brain_CT_noisy.bmp');
% ima = rgb2gray(ima);
% filtered_image = gaussianbrf(ima,13,77);

% Gaussian Bandpass Filter
f = double(I);
[nx ny] = size(f);
f = uint8(f);
fftI = fft2(f,2*nx-1,2*ny-1);
fftI = fftshift(fftI);
subplot(2,2,1)
imshow(f,[]);
title('Original Image')

% fftshow(fftI,'log')
% title('Fourier Spectrum of Image')
% Initialize filter.
filter1 = ones(2*nx-1,2*ny-1);
filter2 = ones(2*nx-1,2*ny-1);
filter3 = ones(2*nx-1,2*ny-1);

for i = 1:2*nx-1
    for j =1:2*ny-1
        dist = ((i-(nx+1))^2 + (j-(ny+1))^2)^.5;
        % Use Gaussian filter.
        filter1(i,j) = exp(-0.347*(dist/(d1)));
        filter2(i,j) = exp(-0.347*(dist/(d0)));
        filter3(i,j) = 1.0 - filter2(i,j);
        filter3(i,j) =(filter1(i,j).*filter3(i,j));
    end
end
% subplot(2,2,2)
% 
% plot(dist,'color','red','linewidth',3);hold on;
% Update image with passed frequencies
filtered_image = fftI + filter3.*fftI;

filtered_image = ifftshift(filtered_image);
filtered_image = ifft2(filtered_image,2*nx-1,2*ny-1);
filtered_image = real(filtered_image(1:nx,1:ny));
filtered_image = uint8(filtered_image);
subplot(2,2,2)
imshow(filtered_image,[])
title('Bandpass Filtered Image')

subplot(2,2,3)
fftshow(filter3,'log')
title('Frequency Domain Filter Function Image')