clear all
close all
clc

I1 = imread('../images/triangle.png');
I1 = double(I1)./256;
I1 = rgb2gray(I1);
I1 = imrotate(I1,23);

subplot(1,3,1)
imshow(I1);


subplot(1,3,2);
L1 = fftshift(fft2(I1));
imshow(log(1+abs(L1)),[]);
xlabel('Widmo mocy');


subplot(1,3,3)
imshow(angle(L1),[]);
xlabel('Faza');