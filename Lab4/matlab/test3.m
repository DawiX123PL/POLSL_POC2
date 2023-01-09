clear all
close all
clc


I1 = imread("test1.png");

I1 = I1 > 127;

a = regionprops(I1, "all");


area = a.Area
per = a.Perimeter

k = 4 * pi * area / per^2

