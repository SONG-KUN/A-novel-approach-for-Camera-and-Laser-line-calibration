function [ laserPlane ] = laserPlaneFromMultiplePluckerLines( LBlock )
debug=true;
%   in LBlock every row represents a 3D line in the Plcuker notation

[ points,directions ] = getPointDirectionFromPluckerLine( LBlock )

[V,D] = eig(directions'*directions);
if debug 
    temp=figure;
    quiver3(zeros(size(LBlock,1),1),zeros(size(LBlock,1),1),zeros(size(LBlock,1),1),LBlock(:,1),LBlock(:,2),LBlock(:,3));
    pause;
    close(temp);
    
end

PlaneNormal=V(:,1);
averageDistance=mean(points*PlaneNormal);
laserPlane=[PlaneNormal; -averageDistance];
end

