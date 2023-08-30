function [rotationMatrix, translationVector, outputTarget, points3D, HorizPlane] = findCheckerboard3DPosition(target, cameraParams, squareSizeInMillimeters)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
debug = false;

points3D = [];

[imagePoints, boardSize] = detectCheckerboardPoints(target);

if size(imagePoints, 1) > 0 % At least one checkerboard point was found.
    outputTarget = insertMarker(target,imagePoints);     
    
    [worldPoints] = generateCheckerboardPoints(boardSize, squareSizeInMillimeters);
    [rotationMatrix, translationVector] = extrinsics(imagePoints, worldPoints, cameraParams);
    
    worldPoints = [worldPoints zeros(size(worldPoints,1), 1) ones(size(worldPoints, 1), 1)];
    
    points3D = worldPoints * [rotationMatrix; translationVector];
    
else
    rotationMatrix = eye(3, 3);
    translationVector = [0 0 0];
    outputTarget = repmat(target,[1 1 3]);
    
end

RT = [rotationMatrix' translationVector'; 0 0 0 1];

HorizPlane = [0 0 1 0]/RT; % transformation of plane z=0
HorizPlane = HorizPlane ./ (HorizPlane(1).^2 + HorizPlane(2).^2 + HorizPlane(3).^2);% normalization to direction cosines

if debug
    K = cameraParams.IntrinsicMatrix; % in K everything is expressed in pixels:[f_x 0 0;s f_y 0;c_x c_y 1]
    
    reprojectedOnImage = points3D * K;
    reprojectedOnImage = [reprojectedOnImage(:,1) ./ reprojectedOnImage(:, 3) reprojectedOnImage(:, 2) ./ reprojectedOnImage(:, 3)];
    
    outputTarget = insertMarker(outputTarget, reprojectedOnImage, 'o', 'color', 'red');
    
    temp = figure;
    
    imshow(outputTarget);
    
    pause;
    
    close(temp);
    
end

end
