%% edge detection
clear; close all; clc

% we have a known grey back ground around the pieces we want to find the
% edge on.

PF = imread('foto puslespilsblad.jpg');
PF = im2double (PF);
PF = rgb2gray  (PF);

GB = imread ('Grey table.jpg');
GB = im2double (GB);
GB = rgb2gray  (GB);

subplot (1,3,1);
I = PF - GB;
imshow (I);

subplot (1,3,2)

I = abs(PF - GB);
imshow (I);


subplot (1,3,3)
imhist (I)

figure
T = 0.25; % Global Treshold
f = I < T; % make the picture BW whit the treshold.
f = imcomplement (f); % inverts teh picture.
imshow (f);
title(['Treshold = ' num2str(T)]); % disp a variable

%%
figure
piece = imread('foto puslespilsblad.jpg');
piece = rgb2gray(piece);
back = imread ('Grey table.jpg');

t = 0.0751;
h = fspecial('laplacian',0);
J = edge(piece,'zerocross',t,h);

imshow (J);