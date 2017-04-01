%% RANSAC - detect object in a scene

% Load both the template and scene image
template = rgb2gray(imread('prioritySign.png'));
%sceneImage = imread(fullfile('..', 'circularSigns', 'templates', 'roadPrioritySign.jpg'));
sceneImage = rgb2gray(imread('road70.jpg'));

% Extract SURF features for both images
templatePoints = detectSURFFeatures(template);
scenePoints = detectSURFFeatures(sceneImage);

% Extract feature descriptors
[templateFeatures, templatePoints] = extractFeatures(template, templatePoints);
[sceneFeatures, scenePoints] = extractFeatures(sceneImage, scenePoints);

% Find putative point matches
templatePairs = matchFeatures(templateFeatures, sceneFeatures);
matchedTemplatePoints = templatePoints(templatePairs(:, 1), :);
matchedScenePoints = scenePoints(templatePairs(:, 2), :);

% Locate the object in the scene
[tform, inlierTemplatePoints, inlierScenePoints] = ...
    estimateGeometricTransform(matchedTemplatePoints, matchedScenePoints, 'affine');

% Show the matched points
figure;
showMatchedFeatures(template, sceneImage, inlierTemplatePoints, ...
    inlierScenePoints, 'montage');
title('Matched Points (Inliers Only)');

% Display a box around the template found in the scene image
boxPolygon = [1, 1;...                           % top-left
        size(template, 2), 1;...                 % top-right
        size(template, 2), size(template, 1);... % bottom-right
        1, size(template, 1);...                 % bottom-left
        1, 1];                   % top-left again to close the polygon
    
newBoxPolygon = transformPointsForward(tform, boxPolygon);

figure; imshow(sceneImage); hold on;
line(newBoxPolygon(:, 1), newBoxPolygon(:, 2), 'Color', 'y');
title('Detected Template');