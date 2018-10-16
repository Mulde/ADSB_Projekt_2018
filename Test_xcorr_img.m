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
kimg(344,271) = 1;
% figure 
%%imshow(kimg);

%% trying to find the location in the picture using the cross correlation
% subtracting the mean value of the image so that there are roughly
% equal parts negative and positive values
nimg = img-mean(mean(img));
brik = brik_2;
crr = normxcorr2(brik,nimg);
[ssr,snd] = max(crr(:));
[ij,ji] = ind2sub(size(crr),snd);
% plot of the cross correlation
figure
subplot(1,2,1)
plot(crr(:))
title('Cross-Correlation')
hold on 
plot(snd,ssr,'or')
hold off
text(snd*1.05,ssr,'maximum')
subplot(1,2,2)
surf(crr)
shading flat
kimg(ij:-1:ij-size(brik,1)+1,ji:-1:ji-size(brik,2)+1) = rot90(brik,2);

%% placing brick 2
brik = brik_2;
% find teori omkring denne funktion da xcorr2 ikke virkede men det gør
% gør denne 
crr = normxcorr2(brik,nimg);
crr2 = xcorr2(nimg,brik);
[ssr,snd] = max(crr(:));
[ij,ji] = ind2sub(size(crr),snd);
% plot of the cross correlation
figure
subplot(2,2,1)
plot(crr(:))
title('Cross-Correlation')
hold on 
plot(snd,ssr,'or')
hold off
text(snd*1.05,ssr,'maximum')
subplot(2,2,2)
surf(crr)
shading flat
% plot xcorr2
subplot(2,2,4)
surf(crr2)
subplot(2,2,3)
plot(crr2(:))
shading flat
kimg(ij:-1:ij-size(brik,1)+1,ji:-1:ji-size(brik,2)+1) = rot90(brik,2);

%% placing brik 3
brik = brik_3;
crr = normxcorr2(brik,nimg);
[ssr,snd] = max(crr(:));
[ij,ji] = ind2sub(size(crr),snd);
% plot of the cross correlation
figure
subplot(1,2,1)
plot(crr(:))
title('Cross-Correlation')
hold on 
plot(snd,ssr,'or')
hold off
text(snd*1.05,ssr,'maximum')
subplot(1,2,2)
surf(crr)
shading flat
kimg(ij:-1:ij-size(brik,1)+1,ji:-1:ji-size(brik,2)+1) = rot90(brik,2);

%% putting in the brick into where it need to go

figure
imagesc(kimg)
axis image off
colormap gray
title('Reconstructed')

%imtool(img);


