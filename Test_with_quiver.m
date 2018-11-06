%% one peice cutteing and fitting
clear; close all; clc

%% Subtracting the Background
figure
%Load in white back
Back = imread ('Back1.jpg');
% Convert to Double data type
Back = im2double(Back);
Front = imread ('Ref1 - Brik2.jpg');
Front = im2double(Front);

%subtract the forground from the backround
diffImage = Front - Back;
% finding the highest values over a certain threshold
Threshold = 0.05;
imhist(diffImage)
figure
mask = abs(diffImage) > Threshold;
% Convert to Double data type
mask = im2double(mask);
% detmining if any element of the mask array is non zero
mask = any (mask,3);
%plotting the results
subplot (1,2,1);
mask = all(mask,3);
imshow (mask);

% use the mask to mark the changed area in the picture.
subplot (1,2,2);
box = regionprops(mask,'Area', 'BoundingBox'); 
% cutting the image to fit the size of the mask from values in boundingbox
i = 1;
n = length(box)+1;
while i < n    
        if box(i).Area > 16000
            brik_i = box(i);
        end
    i = i+1;    
end

rect = brik_i(1).BoundingBox;
% Boundingbox [left, top, width, height]

% creating square from values in the image and cutting away the white parts
rect = [rect(1)+45 rect(2)+45 rect(3)-90 rect(4)-90];
%rect = [rect(1) rect(2) rect(3) rect(4)];
% cropping the front image to fit the dimensions given in the rect varible
piece1 = imcrop (Front,rect);
imshow (piece1);

%% 2D cross corlation

% loading in the image of the puzzle
Original = imread('Ref1.jpg');

% converting to grayscale
ref = rgb2gray(Original); 

% converting to double data type
ref = im2double(ref);

% finding the nigative of the image 
nref = ref-mean(mean(ref));

% making the next section easily reuseable
brik = piece1;
brik = rgb2gray(brik);
brik = im2double(brik);
% taking the cross correlation of the piece found earlier with the negative
% of the full puzzle
crr = normxcorr2(brik,nref);

% finding the width and height of the piece
[h,w] = size(brik);

% removing the padding that the cross corelation ads
crr=crr(h:end-h,w:end-w+1);

% finding the maximum value of the cross correlation
% ssr is the pixel index for the highest values
% snd is the highest values, value
[ssr,snd] = max(crr(:));
siz = size(crr);

% converting the pixel index to a subscript that can be used in a
% coordinate system
[Y,X] = ind2sub(siz,snd);

% subtraction of the offset made when cross correlating
Y_offset = Y-size(brik,1);
X_offset = X-size(brik,2);

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

%% Show Placement
figure
% showing the image with scaled colors
Position = [1 1];
Original = insertText(Original,Position,1,'FontSize',60);
imagesc(Original)
hold on 
% pointing from the placement of the text to the middle of the piece
quiver(35, 110, X+1+(w/2), Y+1+(h/2)); 
% drawing a rectangle where the piece is suppossed to go
rectangle ('position',[X+1 Y+1 w h],'EdgeColor','r')
axis image off
colormap gray
title('Show Piece placement')