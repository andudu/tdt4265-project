
%% Useful functions
% doc fitgeotrans % Perspective transformation
% https://se.mathworks.com/videos/camera-calibration-with-matlab-81233.html % Camera calibration in MATLAB
% https://se.mathworks.com/products/automated-driving/features.html#vision-system-design

%% Load image
image = imread('whiteCarLaneSwitch.jpg');
grayImage = rgb2gray(image);
[h, w] = size(grayImage);

%% Image masking (ROI) based on camera orientation
roiImage = grayImage .* uint8(roipoly(grayImage,[50 365 590 935],[540 330 330 540]));
%roiImage = roiImage(330:540,1:960);
figure, imshow(roiImage);

%% Perspective transformation
movingPoints = [458 330; 520 330; 165 540; 888 540]; % top left, top right, bottom left, bottom right
fixedPoints = [165 1; 888 1; 165 540; 888 540]; % top left, top right, bottom left, bottom right
tForm = fitgeotrans(movingPoints, fixedPoints, 'Projective');
RA = imref2d([size(image,1) size(image,2)], [1 size(image,2)], [1 size(image,1)]); % rows, cols, limits of x, limits of y
[tImage, ] = imwarp(image, tForm, 'OutputView', RA); % A perspective projection. (1, 3) and (2, 3) is not zero. Also, we have a little translation.

figure, imshow(tImage);

%% Sobel edge detection
sobelThreshold = 0.01;
edgesImage = edge(imgaussfilt(rgb2gray(tImage),5));
figure, imshow(edgesImage);