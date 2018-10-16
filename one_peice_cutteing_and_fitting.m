%% one peice cutteing and fitting
clear; close all; clc

%% Subtracting the Background
figure
Back = imread ('hvid_baggrund.jpg');
Back = im2double(Back);
Front = imread ('brik 1 reel.jpg');
Front = im2double(Front);

diffImage = Front - Back;
mask = abs(diffImage) > 0.35;
mask = im2double(mask);

mask = any (mask,3);

subplot (1,2,1);
mask = all(mask,3);
imshow (mask);

% use the mask to mark the changed area in the picture.
subplot (1,2,2);
box = regionprops(mask,'Area', 'BoundingBox'); 
% Boundingbox [left, top, width, height]

rect = box(1).BoundingBox;
% Boundingbox [left, top, width, height]
rect = [rect(1)+45 rect(2)+45 rect(3)-90 rect(4)-90];

piece1 = imcrop (Front,rect);
imshow (piece1);

%% 2D cross corlation

Original = imread('med hvid baggrund.jpg'); 
ref = rgb2gray(Original); 
ref = im2double(ref);

nref = ref-mean(mean(ref));

brik = piece1;
brik = rgb2gray(brik);
brik = im2double(brik);

crr = normxcorr2(brik,nref);

[ssr,snd] = max(crr(:));
siz = size(Original);
[I,J] = ind2sub(siz,snd);
%I = 2048-I;
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

kimg(I:-1:I-size(brik,1)+1,J:-1:J-size(brik,2)+1) = rot90(brik,2);
%% Show Placement
figure
imagesc(Original)
hold on 
[w,h] = size(brik);
rectangle ('position',[I J w h],'EdgeColor','r')
axis image off
colormap gray
title('Show Piece placement')