index=1;
systemImagesDir='Users/hal/Documents/Tesina/Code_Laser calibration/ricostruzioneTronco/ricostruzioneTronco1';
startImage=41;
endImage=81;
offsetBetweenFrames=[10 0 0]';% log displacement between frames
pointsCluster=cell(endImage-startImage+1,1);
reconFig=figure;
for frame = startImage:endImage
    image=imread(fullfile(systemImagesDir, sprintf('tronco%03d.png', frame)));
    [Y,X,im] = bluePointExtraction(image);
    Points=zeros(size(X,1),4);
    for cursor=1:size(X,1)
        p=[X(cursor) Y(cursor)];
         Points(cursor,:)  =  get3DPointThroughLaserPlaneWithReferenceSystem( p,...
                                cameraParams,laserPlane,H(1:3,1:3,1),H(1:3,4,1),...
                                offsetBetweenFrames.*(frame-1))';
    end
    hold on
    plot3(Points(:,1),Points(:,2),-Points(:,3),'+');
    pointsCluster(index)={Points};
    index=index+1;
    
 end