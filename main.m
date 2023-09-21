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

%% get the intrinsic parameters
images = imageSet('./cameraIntrinsic/intrinsic_imageSet');

imageFileNames = images.ImageLocation;

[imagePoints, boardSize] = detectCheckerboardPoints(imageFileNames);

squareSizeInMM = 60;
worldPoints = generateCheckerboardPoints(boardSize,squareSizeInMM);

I = readimage(images,1); 
imageSize = [size(I, 1),size(I, 2)];
cameraParams = estimateCameraParameters(imagePoints,worldPoints, ...
                                  'ImageSize',imageSize);  

%% plot
showReprojectionErrors(cameraParams);
