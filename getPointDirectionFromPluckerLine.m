function [ point,direction ] = getPointDirectionFromPluckerLine( line )
% 'point' will be the closest point of the line to the origin while
% 'direction' is its orientation.

point = zeros(size(line,1),3);

direction = zeros(size(line,1),3);

for index = 1:size(line, 1)
    
    point(index, :) = cross(line(index, 4:6), line(index, 1:3)) ./ (line(index, 1:3) * line(index, 1:3)');
    direction(index, :) = line(index, 1:3) ./ norm(line(index, 1:3));
    
end

end

