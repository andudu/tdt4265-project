
%% Useful functions
I = imread('test_images/solidYellowLeft.jpg');
I = rgb2gray(I); % Convert RGB image to grayscale
I = rgb2hsv(I); % Convert RGB colormap to HSV colormap
I = edge(I,'canny'); % Canny edge detection (for greyscale images only)
I = imgaussfilt(I,sigma,'FilterSize',oddNumber); % Gaussian blur 
doc line; % Documentation for the line function
imshow(I) % Show the image
% <https://se.mathworks.com/help/images/roi-based-processing.html>  % ROI-based processing - for masking out the interesting parts of an image
doc houghlines; % Documentation; extract line segments based on Hough transform
%lh.Color = [0,0,0,0.5] % Set line color and transparency

%% Lane detection
image = imread('test_images/solidYellowCurve.jpg');
grayImage = rgb2gray(image);
hsvImage = rgb2hsv(image);
indexedImage = rgb2ind(image,65536);

% Insert color masking here
yellowRange = {[20 100 100] [30 255 255]};
whiteRange = {[0 0 235] [255 255 255]};

%yellowMask = roicolor(image,0.4);

% Blur the image
kernelSize = 5;
blurredImage = imgaussfilt(grayImage,5);

% Canny edge detection
cannyThreshold = [0.24, 0.59];
edgesImage = edge(blurredImage,'Canny',cannyThreshold);

% Insert image masking (ROI) based on canny edges here

% Extract hough lines
houghFillGap    = 70;
houghMinLength  = 100;

[houghImage,houghTheta,houghRho] = hough(edgesImage);
houghPeaks = houghpeaks(houghImage,5,'threshold',ceil(0.3*max(houghImage(:))));

lines = houghlines(edgesImage,houghTheta,houghRho,houghPeaks,'FillGap',houghFillGap,'MinLength',houghMinLength);
figure, imshow(image), hold on
for k = 1:length(lines)
    xy = [lines(k).point1; lines(k).point2];
    plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');
end

% Insert line extrapolation here


%% Colormap
N = 127;
y = 1:127;
Y = repmat(y,50,1);
imagesc(Y); colormap;