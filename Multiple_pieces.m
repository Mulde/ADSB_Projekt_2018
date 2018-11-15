%% one peice cutteing and fitting
clear; close all; clc

%% Global variables
% the minimum pixle size of a piece 
A = 16000;

%% Subtracting the Background
figure
%Load in white back
Back = imread ('Back1.jpg');
% Convert to Double data type
Back = im2double(Back);
Front = imread ('Multiple_pieces_2_2.jpg');
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
mask = all(mask,3);
imshow (mask);

% use the mask to mark the changed area in the picture.
box = regionprops(mask,'Area', 'BoundingBox'); 


% loading in the image of the puzzle
Original = imread('Ref1.jpg');

% converting to grayscale
ref = rgb2gray(Original); 

% converting to double data type
ref = im2double(ref);

% finding the nigative of the image 
nref = ref-mean(mean(ref));

figure
subplot (1,2,1);
i = 1;
m = 1;
n = length(box)+1;
while i < n
        if box(i).Area > A
            
            Position = [1+(150*(m-1)) 1];
            Original = insertText(Original,Position,m,'FontSize',60);
            m = m + 1;
        end
    i = i+1;
end
% showing the image with scaled colors
imagesc(Original)
axis image off
colormap gray
title('Show Piece placement')

i = 1;
m = 1;


while i < n    
        if box(i).Area > A
            brik = box(i);
            % cutting the image to fit the size of the mask from values in boundingbox
            rect(:,m) = brik(1).BoundingBox;
            % Boundingbox [left, top, width, height]
            rect(:,m) = [rect(1,m)+45 rect(2,m)+45 rect(3,m)-90 rect(4,m)-90];
            % creating square from values in the image and cutting away the white parts
            %rect = [rect(1) rect(2) rect(3) rect(4)];
            piece = imcrop (Front,rect(:,m));
            % cropping the front image to fit the dimensions given in the rect varible
            % cross correlation
            piece = rgb2gray(piece);
            piece = im2double(piece);
            % taking the cross correlation of the piece found earlier with the negative
            % of the full puzzle
            crr = normxcorr2(piece,nref);
            % finding the width and height of the piece
            [h,w] = size(piece);

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
            
            hold on
            p1 = [35+(150*(m-1)) 110];                  % First Point
            p2 = [X+1+(w/2) Y+1];                       % Second Point
            dp = p2-p1;                                 % Difference
            % Points from nomeric value to piece placement
            quiver(p1(1),p1(2),dp(1),dp(2),0,'k','LineWidth',1.5);
            
            % numerate the Front image
            Position = [rect(1,m)-120 rect(2,m)];
            Front = insertText(Front,Position,m,'FontSize',60);
            
            % drawing a rectangle where the piece is suppossed to go
            rectangle ('position',[X+1 Y+1 w h],'EdgeColor','r')
            
            % iterating the controlling varible to continue to next piece
            m = m+1;
        end
    i = i+1;    
end

subplot (1,2,2);
imshow (Front);