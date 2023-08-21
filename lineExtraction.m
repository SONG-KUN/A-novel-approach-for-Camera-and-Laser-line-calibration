function param = lineExtraction(inputPar)
% this function extracts the 3 line coefficients from blue pixels in an
% image, coefficients are in the pixel format. inputPar could be a file
% name or a previously loaded image.

if ischar(inputPar)
    im = imread(inputPar);
else
    im = inputPar;
end

[Y,X] = bluePointExtraction(im);

%%[Y,X] = find(fileName == 255);

[coeff, score] = pca([X Y]);

normal = coeff(:, 2);

meanPoint = mean([X Y], 1);

param = [normal' -meanPoint * normal]';

end
