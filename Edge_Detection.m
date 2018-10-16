%% edge detection
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

subplot (1,3,1);
mask = all(mask,3);
imshow ( mask);

% use the mask to mark the changed area in the picture.
subplot (1,3,2);
box = regionprops(mask,'Area', 'BoundingBox'); 
box(1)
% Boundingbox [left, top, width, height]

rect = box(1).BoundingBox;
result = imcrop (Front,rect);

imshow (result);
