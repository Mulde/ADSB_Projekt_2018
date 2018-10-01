clear; close all; format compact; clc;

%% loading in the image
img = imread('pepperswithsquares.bmp');
img = rgb2gray(img);
img = im2double(img);

figure
imshow(img)
title('original')

%% loading in the piece
brik_1 = imread('brik1MF.jpg'); brik_1 = rgb2gray(brik_1); brik_1 = im2double(brik_1);

figure
imshow(brik_1)
title('brikken')

%% removing brik 1 from the original image
[x,y,z] = size(img);
kimg(x,y) = 1;
% figure 
% imshow(kimg);

%% trying to find the location in the picture using the cross correlation
% subtracting the mean value of the image so that there are roughly
% equal parts negative and positive values
nimg = img-mean(mean(img));
brik = brik_1;
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

%% showing the piece in the image
figure
subplot(1,2,1)
imagesc(kimg)
axis image off
colormap gray
title('Reconstructed')
gray2rgb(kimg);
subplot(1,2,2)
imshow(kimg)


