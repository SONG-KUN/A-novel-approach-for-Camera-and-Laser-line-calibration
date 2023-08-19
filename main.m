clearvars
close all
clc

%%
im = imread('./images/image_test.png');

R = double(im(:,:,1));
G = double(im(:,:,2));
B = double(im(:,:,3));

R = R(:);
G = G(:);
B = B(:);

[Y,X,imm] = bluePointExtraction(im);
