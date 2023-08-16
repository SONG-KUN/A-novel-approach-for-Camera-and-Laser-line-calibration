function [Y,X,im] = bluePointExtraction(inputPar)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
if ischar(inputPar)
    im=imread(inputPar);
else
    im=inputPar;
end
thresholdBlu=10;
[Y, X] = find((im(:, :, 3) - im(:, :, 2) > thresholdBlu) & (im(:,:,3) - im(:, :, 1) > thresholdBlu));
end
