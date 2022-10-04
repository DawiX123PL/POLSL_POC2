clear all
close all
clc



I = imread("..\images\baboon_512x512.bmp");
I = double(I) ./ 255;
% 
% I = [0.3 0.32 0.31
%     0.4 1 0.4
%     0.3 0.2 0.23]

%I = rgb2gray(I);

I1 = imnoise(I, "salt & pepper", 0.01);

I2 = filter_median(I1, 1);
I3 = filter_LUM(I1, 1, 2);
I4 = filter_VMF(I, 1);

figure
imshow(I);
figure
imshow(I1);
figure
imshow(I3);
figure
imshow(I4);



psnr1 = psnr(I1,I)
psnr2 = psnr(I2,I)
psnr3 = psnr(I3,I)