% Only finds what it thinks is the single most correct position.
function position = generalisedHoughFunction(template, image)

% Converting to grayscale.
grayTemplate = rgb2gray(template);
grayImage = rgb2gray(image);

% Using Canny to find edges. Note that it converts the image into binary.
edgeTemplate = edge(grayTemplate, 'canny');
edgeImage = edge(grayImage, 'canny');

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

maxAngleBins = 30; % How many angles do we want to discretize down to?
maxPointsPerAngle = numEdgePoints(1);
% The maximum number of vectors per angle is the number of edge points
% in the template.

pointCounter = zeros(maxAngleBins);
% Will be used to count the numberof vectors associated with an angle.

houghTable = zeros(maxAngleBins, maxPointsPerAngle, 2); 
% Initializing the Hough table. We need a 3D-table because we want to
% have the x-values in one layer and the y-values in the other.

% -----TRAINING-----

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

imageSize = size(edgeImage);

scales = [0.125, 0.25, 0.5, 1, 2, 4, 8]; % The scales we use. This needs to be customized to the different scenarios.
houghSpace = zeros(imageSize(1), imageSize(2), length(scales));
% Initializing the Hough Space, which has the same size as the image
% and is used to place votes.

% ------RECOGNITION-----

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

% -----FETCHING SOME STATISTICS-----

[y, x, bestNumScale] = findMaxArea(houghSpace); % Note that we overwrite x and y.

position = [y, x]; % Note the order of y and x.

end