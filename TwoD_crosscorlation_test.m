%% 2D crosscorlation test
clear; close all; clc

I = zeros (4);  %create a simple 4x4 matrix with zeroes
I(2,3) = 1;     % set one of them to 1
subplot(3,2,1);
imshow (I);

M = ones (1);   % create a mask
subplot(3,2,3);
imshow(M);
title('Mask 1x1');

D = xcorr2(I,M);% cross corelate the matrix whit the mask
subplot(3,2,5);
stem3(D);

I2 = zeros (10);
I2(4:6,7:8) = 1;
subplot(3,2,2)
imshow(I2);
title('10x10 matrix with a 2x3 block in it');

M2 = ones(2);
subplot(3,2,4);
imshow(M2);
title('Mask 2x2');

D2 = xcorr2(I2,M2);
subplot (3,2,6);
stem3(D2);
title('xcorr2 ');

%surf (X,Y,Z,CO)
