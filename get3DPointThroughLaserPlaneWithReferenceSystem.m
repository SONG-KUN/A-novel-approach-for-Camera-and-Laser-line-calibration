function [ Point ] = get3DPointThroughLaserPlaneWithReferenceSystem( point2D,...
                        cameraParams,LaserPlane,referenceRotation,...
                        referenceTranslation,offset)
% Reference Rotation and Translation represent the displacement with respect to the Global reference system.
% The global reference system is defined by the first checkerboard
% acquired, and in particular the longest direction represents the x axis
% and the shortest side the y axis.
% Set the point in the 3D camera frame 
% It is like assuming that the camera is in the origin so Reference
% rotation and translation are null: P=K[eye(3) ones(3,1)]
% x=PX -> inv(K)*x 
scaledPoint3D=(cameraParams.IntrinsicMatrix')\[point2D 1]';

% Href is the position of the camera in the global reference system; the
% global reference system is defined by the first acquired checkerbord.
Href=[referenceRotation referenceTranslation;[0 0 0 1]];

% Laser Plane is given in the global reference system, so, in order to identify it in the camera coordinate system
% it must be divided by Href'
LaserPlaneFromCamera=Href'\LaserPlane;

% a*lambda*x+b*lambda*y+c*lambda*z+d=0 -> lamda=-d/(ax+by+cz)
intersectionPoint=scaledPoint3D*(-LaserPlaneFromCamera(4)/(scaledPoint3D'*LaserPlaneFromCamera(1:3)));

% evaluate the 3D point in the global reference system
Point=Href\[intersectionPoint;1];
% the offset can be adopted in case of a displacement of the global
% reference system is needed 
Point=Point./Point(4)+[offset' 0]';
end

