%% edge detection
clear; close all; clc

% % we have a known grey back ground around the pieces we want to find the
% % edge on.
% 
% PF = imread('foto puslespilsblad.jpg');
% PF = im2double (PF);
% PF = rgb2gray  (PF);
% 
% GB = imread ('Grey table.jpg');
% GB = im2double (GB);
% GB = rgb2gray  (GB);
% 
% subplot (1,3,1);
% I = PF - GB;
% imshow (I);
% 
% subplot (1,3,2)
% 
% I = abs(PF - GB);
% imshow (I);
% 
% 
% subplot (1,3,3)
% imhist (I)
% 
% figure
% T = 0.25; % Global Treshold
% f = I < T; % make the picture BW whit the treshold.
% f = imcomplement (f); % inverts teh picture.
% imshow (f);
% title(['Treshold = ' num2str(T)]); % disp a variable

%% Subtracting the Background
figure
Back = imread ('White_Back.JPEG');
Back = im2double(Back);
Front = imread ('Object3.JPEG');
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
