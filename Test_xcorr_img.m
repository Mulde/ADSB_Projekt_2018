%% Alligning two images with cross correlation
clear; close all; format compact; clc;
%% show the original
load durer
img = X;
White = max(max(img));

imagesc(img)
axis image off
colormap gray
title('original')

%% loading in the pieces
brik_1 = imread('brik 1.jpg');
brik_2 = imread('brik 2.jpg');
brik_3 = imread('brik 3.jpg');
brik_4 = imread('brik 4.jpg');
brik_5 = imread('brik 5.jpg');
brik_6 = imread('brik 6.jpg');
brik_7 = imread('brik 7.jpg');
brik_8 = imread('brik 8.jpg');
brik_9 = imread('brik 9.jpg');

White = max(max(brik_1));
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



