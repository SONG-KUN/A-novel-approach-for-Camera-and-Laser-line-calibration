clearvars
close all
clc

%%


debug=false;

[ L1,H1,P1 ]=pluckerLineFromCheckerboarImagePlusLaser('./calibrationCameraLaserImages/image_0001.png', './calibrationCameraLaserImages/image_0001.png', cameraParams,60,[],[] );
[ L2,H2,P2 ]=pluckerLineFromCheckerboarImagePlusLaser('./calibrationCameraLaserImages/image_0002.png', './calibrationCameraLaserImages/image_0002.png', cameraParams,60,H1(1:3,1:3),H1(1:3,4) );
[ L3,H3,P3 ]=pluckerLineFromCheckerboarImagePlusLaser('./calibrationCameraLaserImages/image_0003.png', './calibrationCameraLaserImages/image_0003.png', cameraParams,60,H1(1:3,1:3),H1(1:3,4) ); 
[ L4,H4,P4 ]=pluckerLineFromCheckerboarImagePlusLaser('./calibrationCameraLaserImages/image_0004.png', './calibrationCameraLaserImages/image_0004.png', cameraParams,60,H1(1:3,1:3),H1(1:3,4) );

 [ laserPlane ] = laserPlaneFromMultiplePluckerLines( [L1;L2;L3;L4] );
%[ laserPlane ] = laserPlaneFromMultiplePluckerLines( [L1;L2] );
if debug
    temp=figure;
    [p,v]=getPointDirectionFromPluckerLine( [L1;L2;L3;L4] ) 
    quiver3(p(:,1),p(:,2),p(:,3),v(:,1),v(:,2),v(:,3));
    pause;
    close(temp); 
end

 [Y,X,im] = bluePointExtraction(oggetto);
%[ rotationMatrix, translationVector,outputTarget,points3D ] = findCheckerboard3DPosition( image_0001,cameraParams,60 );
Point=zeros(size(X,1),4);
for index=1:size(X,1)
    p=[X(index) Y(index)];
     Point(index,:)  =  get3DPointThroughLaserPlaneWithReferenceSystem( p,cameraParams,laserPlane,H1(1:3,1:3),H1(1:3,4) )';
     plot3(Point(:,1),Point(:,2),Point(:,3),'+');
    
end