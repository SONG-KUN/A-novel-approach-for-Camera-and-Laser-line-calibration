function [point, direction] = getPointDirectionFromPluckerLine( line )
% 'point' will be the closest point of the line to the origin while
% 'direction' is its orientation.


point = zeros(size(line,1),3);
direction = zeros(size(line,1),3);

momentVector = zeros(3, size(line,2));

for index = 1:size(line, 1)
    
    % divides the cross product by the square of the magnitude of the direction vector. 
    % this step normalizes the vector obtained from the cross product.
%     point(index, :) = cross(line(index, 4:6), line(index, 1:3)) ./ (line(index, 1:3) * line(index, 1:3)'); 
    
    for index2 = 1:size(line, 1)
        
        momentVector(index2, :) = line(3);
        
    end
    
    point(index, :) = cross(momentVector, line) ./ (line(index, 1) * line(index, 1)'); 
    direction(index, :) = line(index, 1) ./ norm(line(index, 1));
    
end

end

