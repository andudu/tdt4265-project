% Using imfindcircles to detect circles and the resizing the sign into
% 227x227.
function [signs, centers, radii] = getCircularSigns(img)

[centers, radii] = imfindcircles(img, [10 30]); % Hough for circles. The last parameters controll which size we are looking for.

if (isempty(radii)) % If no circles were detected.
    signs{1} = -1;
    return;
end

[height, width] = size(img);

pos = 1; % Need this to tell the code in which position in the cell array to place a sign. Can't do this with for-loop since we then will get an entry in the cell array with zero size if one circle is partially outside the image.
extraBoundary = 15; % Often, only the innermost part of the sign is extracted. Can use this variable to let the algorithm extract more of the area around the sign.

% Looping through all the detected circles.
while (pos <= length(radii))
    % The following variables tell us which part of the image we want to
    % extract.
    top = ceil(centers(pos, 2) - radii(pos)) - extraBoundary;
    bottom = floor(centers(pos, 2) + radii(pos)) + extraBoundary;
    left = ceil(centers(pos, 1) - radii(pos)) - extraBoundary;
    right = floor(centers(pos, 1) + radii(pos)) + extraBoundary;
    
    if top < 1 || left < 1 || right > width || bottom > height % if trying to index something outside of the image.
        fprintf('Left: %d, right: %d, top: %d, bottom: %d\n', left, right, top, bottom);
        centers(pos, :) = []; % Deleting the position of the sign outside the image.
        radii(pos) = []; % Deleting the radius of the sign outside the image.
    else
        sign = img(top:bottom, left:right, :); % Extracting the sign.
        signs{pos} = imresize(sign, [227, 227]);
        pos = pos + 1;
    end
end

if pos == 1 % No signs were within the boundaries.
    signs{1} = -1;
end

end