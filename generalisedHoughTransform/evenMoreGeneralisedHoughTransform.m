%% -----PRE-PROCESSING-----

templateFilename = input('Template filename: ', 's');
% A color image the template you want to train the Hough-table on.

imageFilename = input('Image filename: ', 's');
% A color image where you want to find the template.

% Loading the images.
template = imread(templateFilename);
image = imread(imageFilename);

% Converting to grayscale.
grayTemplate = rgb2gray(template);
grayImage = rgb2gray(image);

% Using Canny to find edges. Note that it converts the image into binary.
edgeTemplate = edge(grayTemplate, 'canny');
edgeImage = edge(grayImage, 'canny');

imshow(edgeTemplate);
imshow(edgeImage);

[x, y] = find (edgeTemplate > 0);
% x to the right and y downwards.
% Finding all the edge points in the template. (y1, x1), (y2, x2), ...

numEdgePoints = size(x);
% Number of edge points in the template.

[refX, refY] = findCenter(edgeTemplate);
% Defining the referance point of the template (upper left corner).
% edgeTemplate must not be an RGB image. Then, size() will not work.

templateGradientMap = gradientDirection(edgeTemplate);
% Calculates a 2D-table showing the angle of the edge at each point.

imshow(templateGradientMap, []);

maxAngleBins = 30; % How many angles do we want to discretize down to?
maxPointsPerAngle = numEdgePoints(1);
% The maximum number of vectors per angle is the number of edge points
% in the template.

pointCounter = zeros(maxAngleBins);
% Will be used to count the numberof vectors associated with an angle.

houghTable = zeros(maxAngleBins, maxPointsPerAngle, 2); 
% Initializing the Hough table. We need a 3D-table because we want to
% have the x-values in one layer and the y-values in the other.

%% -----TRAINING-----

% Looping through all the edge points. "edgePoint" is just an index.
for edgePoint = 1:1:maxPointsPerAngle
    gradientAtPoint = templateGradientMap(x(edgePoint), y(edgePoint))/pi();
    % Normalized into [0, 1].
    
    binAngle = round(gradientAtPoint * (maxAngleBins - 1)) + 1;
    % Tells us which bin the continuous angle at the point belongs to.
    
    pointCounter(binAngle) = pointCounter(binAngle) + 1;
    % Noting that this angle now wil point to one more vector.
    
    % Filling the houghTable with the vector between the edge point
    % and the reference point.
    houghTable(binAngle, pointCounter(binAngle), 1) = refX - x(edgePoint);
    houghTable(binAngle, pointCounter(binAngle), 2) = refY - y(edgePoint);
end

% Finding all the edge points in the image. (y1, x1), (y2, x2), ...
[x, y] = find(edgeImage > 0);
% Note that we are now overwriting the x's and y's of the template.

numEdgePoints = size(x);
% Again, overwriting the template's variable.

imageGradientMap = gradientDirection(edgeImage);
imshow(imageGradientMap, []);

imageSize = size(edgeImage);

scales = [0.125, 0.25, 0.5, 1, 2]; % The scales we use. This needs to be customized to the different scenarios.
houghSpace = zeros(imageSize(1), imageSize(2), length(scales));
% Initializing the Hough Space, which has the same size as the image
% and is used to place votes.

%% ------RECOGNITION-----

for edgePoint = 1:1:numEdgePoints
    gradientAtPoint = imageGradientMap(x(edgePoint), y(edgePoint))/pi();
    binAngle = round(gradientAtPoint*(maxAngleBins - 1)) + 1;
    % Discretizing the gradient at the edge point down to one of the bins.
    
    % Looping through all the vectors associated with this particular bin
    for vectorNum = 1:1:pointCounter(binAngle)
        % Fetching the vector from the Hough Table and adding that to
        % the position of the edge point
%         xVote = houghTable(binAngle, vectorNum, 1) + x(edgePoint);
%         yVote = houghTable(binAngle, vectorNum, 2) + y(edgePoint);
        
        for numScale = 1:length(scales) % Looping through the wanted scales.
            xVote = round(houghTable(binAngle, vectorNum, 1)*scales(numScale)) + x(edgePoint); % Altering the xVote according to the scale.
            yVote = round(houghTable(binAngle, vectorNum, 2)*scales(numScale)) + y(edgePoint); % Altering the yVote according to the scale.
            
            % What if we end up outside the boundaries of the image?
            if xVote > 0 && xVote < imageSize(1) && yVote > 0 && ...
                    yVote < imageSize(2)
                houghSpace(xVote, yVote, numScale) = houghSpace(xVote, yVote, numScale) + 1;
                % Incrementing the number of votes at the position the 
                % vector points to.
            end
        end
    end
end

%% -----FETCHING SOME STATISTICS-----

[x, y, bestNumScale] = findMaxArea(houghSpace); % Note that we overwrite x and y.

%Plotting the image with a marker at the spot we believe the figure is at.
markerImage = insertMarker(image, [y, x], 'size', 15);
imshow(markerImage);

% Finding the x's and the y's for the vectors in a specific bin and
% visualizing the result.
xVecsBin8 = houghTable(8, :, 1);
yVecsBin8 = houghTable(8, :, 2);

% Could probably do something cool with the plot below by not using
% zeros and lowering the number of vectors in order to make it more tidy.
quiver(zeros(1, maxPointsPerAngle), zeros(1, maxPointsPerAngle), ...
    yVecsBin8, -xVecsBin8);

bar(pointCounter, 20);
imshow(log(houghSpace(:, :, bestNumScale)), []);

%% -----FUNCTIONS-----

% Retuns a map with the same size as the image where the pixel values
% indicates the direction of the edge gradients.
function gradientMap = gradientDirection(image)

sobelFilterX = [-1, 0, 1; -2, 0, 2; -1, 0, 1];
sobelFilterY = [-1, -2, -1; 0, 0, 0; 1, 2, 1];

% Finding the derivatives in the x- and y-direction.
Dx = imfilter(double(image), sobelFilterX, 'same');
Dy = imfilter(double(image), sobelFilterY, 'same');

% Finding the angle of the gradient based on the derivatives in the 
% x- and % y-direction. Some trickery with modulo and pi.
gradientMap = mod(atan2(Dy, Dx) + pi(), pi());

end

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

% Simply returns the center of a square.
function [xCenter, yCenter] = findCenter(template)

[rows, cols] = size(template);

xCenter = round(rows/2);
yCenter = round(cols/2);
end