function [ L,H,P ] = pluckerLineFromCheckerboarImagePlusLaser(...
                          checkerboardImage,checherboardImagePlusLaser,...
                          cameraParams,squareSizeInMillimeters,...
                          ReferenceRotation,ReferenceTranslation)
% reference rotation and translation represent the rotation and the translation of the camera 
% with respect to a global reference system which is represented by the
% cartesian axis on the first checkerboard image
debug = false;

checkerboardImage=undistortImage(checkerboardImage,cameraParams);
checherboardImagePlusLaser=undistortImage(checherboardImagePlusLaser,cameraParams);
% Href refers to parameters from function arguments
Href=[ReferenceRotation ReferenceTranslation; [0 0 0 1]];
[ rotationMatrix, translationVector] = findCheckerboard3DPosition( checkerboardImage,...
                                                cameraParams,squareSizeInMillimeters );

% Assuming the camera in the origin of the reference system with optical axis along the z axis                                             
Pcam=cameraParams.IntrinsicMatrix'*[eye(3) [0 0 0]'];

% Projection matrix according to the Zisserman formulation (in opposite
% order with respect to Matlab); the projection is performed on the camera
% image plane.
% rotation and translation are evaluated assuming the checkerboard at the
% current frame as the general reference system
P=cameraParams.IntrinsicMatrix'*[rotationMatrix', translationVector'];

% H is the 4x4 Homography projecting 3D points from camera reference frame
% into world reference frame, rotationMatrix and translationVector are
% obtained above from the actual checkerboard image.
H=[rotationMatrix' translationVector'; [0 0 0 1]];

% line is the laser line in the camera image
line = lineExtraction(checherboardImagePlusLaser);

% the plane passing through a line in the image (placed in the 3D
% framework) and the Optical center of the camera
% the reprojection of a line from an image into the space defining this
% plane is obtained premultiplying by the P' :
% line*x=0 -> line*(P*X)=0 -> (line*P)*X=0 -> X'*P'*line'=0
% reprojection is done assuming the coordinate system centered in the
% camera center
reprojectedPlaneFromLaserLine=Pcam'*line;

% The checkerboard Plane in the origin
checkerboardPlaneEquation=[0 0 1 0]'; 

if ~isempty(ReferenceRotation) % I have already defined a reference frame 
    % using .e.g the first image of the checkerboard, to define the
    % reference system and I want to get the 3D Plucker line with respect
    % to that reference system
    % Since for a point Plane*X=0-> Plane * H^-1 *H * X =0
    % then for transformed points H*X the plane transforms accordingly:
    % newPlane=Plane*inv(H) -> newPlane'=inv(H)' * Plane';
    [ ~, L,~] = PluckerLineFromTwoPlanes(Href'*reprojectedPlaneFromLaserLine,...
                                         Href'*(H'\checkerboardPlaneEquation));
else
    % the actual plane plays the role of reference since I have no defined
    % a reference frame. [This is the condition, e.g. for the first frame
    % in the calibration steps], the 3D line will then belong to this plane
    % (its z coordinates will always be zero) in this reference frame.
    [ ~, L,~] = PluckerLineFromTwoPlanes(H'*reprojectedPlaneFromLaserLine,...
                                         checkerboardPlaneEquation);
end
    
if debug
    [closestLinePoint,direction]=getPointDirectionFromPluckerLine( L );
    [closestLinePoint 1]*checkerboardPlaneEquation
    [closestLinePoint+L(1:3) 1]*checkerboardPlaneEquation
    [closestLinePoint 1]*reprojectedPlaneFromLaserLine
    [closestLinePoint+L(1:3) 1]*reprojectedPlaneFromLaserLine
    
    temp=figure ;
    point1=P*[closestLinePoint 1]';point1=point1./point1(3);point1=point1(1:2);
    point2=P*[closestLinePoint+200*direction 1]';point2=point2./point2(3);point2=point2(1:2);
    point3=P*[closestLinePoint+400*direction 1]';point3=point3./point3(3);point3=point3(1:2);
    outputTarget=insertMarker(checherboardImagePlusLaser,[point1';point2';point3'],'*','color','cyan');
    imshow(outputTarget);
    pause;
    close(temp);
    
end
end

