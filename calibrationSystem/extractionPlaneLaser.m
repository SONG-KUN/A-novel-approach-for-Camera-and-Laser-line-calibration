

debug=false;
systemImagesDir='Users/hal/Documents/Tesina/Code_Laser calibration/ricostruzioneTronco/calibrazioneSistema';
cursor=1;
startImage=30;
endImage=40;
L=zeros(6,endImage-startImage); % 3D line descriptor for each image
H=zeros(4,4,endImage-startImage); % homography for each image
P=zeros(3,4,endImage-startImage); % 3x4 Projection matrix for each image
for index = startImage:endImage
    image=imread(fullfile(systemImagesDir, sprintf('systemCalibration%03d.png', index)));
    if cursor == 1 
        % I am working on the first image
        % the first image is assumed as the global reference system, the
        % checkerbord longest side represents the x axis while its shortest
        % side represents the y axis.
        [ L(:,1),H(:,:,1),P(:,:,1) ]=pluckerLineFromCheckerboarImagePlusLaser(image,image, ...
            cameraParams,60,[],[] );
    else
        [ L(:,cursor),H(:,:,cursor),P(:,:,cursor)]=pluckerLineFromCheckerboarImagePlusLaser(image,image,...
            cameraParams,60,H(1:3,1:3,1),H(1:3,4,1) );
    end
    cursor=cursor+1;
end
[ laserPlane ] = laserPlaneFromMultiplePluckerLines(L);
if debug
    temp=figure;
    [p,v]=getPointDirectionFromPluckerLine( L ) 
    quiver3(p(:,1),p(:,2),p(:,3),v(:,1),v(:,2),v(:,3));
    pause;
    close(temp); 
end 
