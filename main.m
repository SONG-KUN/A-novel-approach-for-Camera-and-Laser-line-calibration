clearvars
close all
clc

%%
im = imread('.calibrationCameraLaserImages/test2.png');

R = double(im(:,:,1));
G = double(im(:,:,2));
B = double(im(:,:,3));

R = R(:);
G = G(:);
B = B(:);

[Y,X,imm] = bluePointExtraction(im);

param = lineExtraction(im);

%% plot
showReprojectionErrors(cameraParams);
