%% Alligning two images with cross correlation
clear; close all; format compact; clc;
%% show the original
img = imread('fuldt billede.jpg'); img = rgb2gray(img); img = im2double(img);
White = max(max(img));

imagesc(img)
axis image off
colormap gray
title('original')

%% loading in the pieces
brik_1 = imread('brik 1.jpg'); brik_1 = rgb2gray(brik_1); brik_1 = im2double(brik_1);
brik_2 = imread('brik 2.jpg'); brik_2 = rgb2gray(brik_2); brik_2 = im2double(brik_2);
brik_3 = imread('brik 3.jpg'); brik_3 = rgb2gray(brik_3); brik_3 = im2double(brik_3);
brik_4 = imread('brik 4.jpg'); brik_4 = rgb2gray(brik_4); brik_4 = im2double(brik_4);
brik_5 = imread('brik 5.jpg'); brik_5 = rgb2gray(brik_5); brik_5 = im2double(brik_5);
brik_6 = imread('brik 6.jpg'); brik_6 = rgb2gray(brik_6); brik_6 = im2double(brik_6);
brik_7 = imread('brik 7.jpg'); brik_7 = rgb2gray(brik_7); brik_7 = im2double(brik_7);
brik_8 = imread('brik 8.jpg'); brik_8 = rgb2gray(brik_8); brik_8 = im2double(brik_8);
brik_9 = imread('brik 9.jpg'); brik_9 = rgb2gray(brik_9); brik_9 = im2double(brik_9);


% White = max(max(brik_1));

% the pieces
figure
subplot(3,3,1)
imagesc(brik_1)
axis image off
colormap gray
title('brik 1')

subplot(3,3,2)
imshow(brik_2)
axis image off
colormap gray
title('brik 2')

subplot(3,3,3)
imagesc(brik_3)
axis image off
colormap gray
title('brik 3')

subplot(3,3,4)
imagesc(brik_4)
axis image off
colormap gray
title('brik 4')

subplot(3,3,5)
imshow(brik_5)
axis image off
colormap gray
title('brik 5')

subplot(3,3,6)
imagesc(brik_6)
axis image off
colormap gray
title('brik 6')

subplot(3,3,7)
imagesc(brik_7)
axis image off
colormap gray
title('brik 7')

subplot(3,3,8)
imagesc(brik_8)
axis image off
title('brik 8')

subplot(3,3,9)
imagesc(brik_9)
axis image off
colormap gray
title('brik 9')

%% removing brik 1 from the original image
% x = 230;
% X = 344;
% scx = x:X;
% y = 180;
% Y = 271;
% scy = y:Y;

% hvidx = 0;
% hvidX = 344;
% hvidxs = hvidx:hvidX;
% hvidy = 0;
% hvidY = 271;
% hvidys = hvidy:hvidY;
% 
% % sect = img(scx,scy);
% hvid = img(hvidy:hvidY);
% kimg = img;
% % kimg(scx,scy) = White;
% kimg(hvidxs,hvidys)= White;
kimg(344,271) = 1;
figure 
imshow(kimg);

%% trying to find the location in the picture
% subtracting the mean value of the image so that there are roughly
% equal parts negative and positive values
nimg = img-mean(mean(img));
% brik_1 = im2double(brik_1);

crr = xcorr2(nimg,brik_1);
[ssr,snd] = max(crr(:));
[ij,ji] = ind2sub(size(crr),snd);

figure
plot(crr(:))
title('Cross-Correlation')
hold on 
plot(snd,ssr,'or')
hold off
text(snd*1.05,ssr,'maximum')

kimg(ij:-1:ij-size(brik_1,1)+1,ji:-1:ji-size(brik_1,2)+1) = rot90(brik_1,2);
figure
imagesc(kimg)
axis image off
colormap gray
title('Reconstructed')

imtool(img);


