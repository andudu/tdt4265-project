% Using a 3x3 grid to find the area where the intensity of the
% Hough Space is the highest.
function [x, y, bestNumScale] = findMaxArea(houghSpace)

[rows, cols, numScales] = size(houghSpace);
maxIntensity = 0;
x = 0;
y = 0;
bestNumScale = 1; % The index of the scale that made the template match the best.

for numScale = 1:numScales % Looping through the different scales. Want to find the max independently of which scale.
    % Looping through the image.
    for row = 1:1:(rows - 3)
        for col = 1:1:(cols - 3)
            accumulator = 0; % Resetting the accumulator.

            % Looping through the grid.
            for gridRow = 1:3
                for gridCol = 1:3
                    accumulator = accumulator + ...
                        houghSpace(row + gridRow, col + gridCol, numScale);
                    % Incrementing the accumulator by the value in this
                    % position at Hough Space.
                end
            end

            % If this area is better than the previous best area.
            if accumulator > maxIntensity
                maxIntensity = accumulator;

                % Updating where we think the object is (+1 comes from
                % gridsize).
                x = row + 1;
                y = col + 1;
                bestNumScale = numScale;
            end
        end
    end
end
end