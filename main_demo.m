clc
clear all
addpath(genpath(pwd));
%%
I1 = imread('disk1.png');
I2 = imread('disk2.png');
I1 = rgb2gray(I1);
I2 = rgb2gray(I2);
I1 = im2double(I1);
I2 = im2double(I2);
%%
GA = Focus_Measure(I1);
GB = Focus_Measure(I2);

fire_time_imgA  = PCNN(GA,13,300);
fire_time_imgB  = PCNN(GB,13,300);

sel_logical = double(fire_time_imgA >=fire_time_imgB);
Db = Majority_Filter(sel_logical,8);
Db = Majority_Filter(Db,7);

w = ones(8);
Dp = kron(Db,w);  % expand  matrix
% image_fushion = I1.*Dp + I2.*double(Dp==0);
image_fushion = I1.*Dp + I2.* (1-Dp);
imshow(image_fushion*255,[])



