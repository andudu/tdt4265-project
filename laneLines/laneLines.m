
%% Useful functions
%I = imread('test_images/solidYellowCurve.jpg');
%I = rgb2gray(I); % Convert RGB image to grayscale
%I = rgb2hsv(I); % Convert RGB colormap to HSV colormap
%I = edge(I,'canny'); % Canny edge detection (for greyscale images only)
%I = imgaussfilt(I,sigma,'FilterSize',oddNumber); % Gaussian blur 
%doc line; % Documentation for the line function
%imshow(I) % Show the image
% <https://se.mathworks.com/help/images/roi-based-processing.html>  % ROI-based processing - for masking out the interesting parts of an image
%doc houghlines; % Documentation; extract line segments based on Hough transform
%lh.Color = [0,0,0,0.5] % Set line color and transparency

%% Lane detection
image = imread('test_images/whiteCarLaneSwitch.jpg');
%figure, imshow(image);
grayImage = rgb2gray(image);
hsvImage = rgb2hsv(image); % Possibly not needed

% Color masking (ROI)
yellowRange = {[200 170 50] [255 210 150]};
whiteRange = {[200 200 200] [255 255 255]};

yellowMaskR = roicolor(image(:,:,1),yellowRange{1}(1),yellowRange{2}(1));
yellowMaskG = roicolor(image(:,:,2),yellowRange{1}(2),yellowRange{2}(2));
yellowMaskB = roicolor(image(:,:,3),yellowRange{1}(3),yellowRange{2}(3));
yellowMask = bitand(yellowMaskR,yellowMaskG);
yellowMask = bitand(yellowMask,yellowMaskB);

%figure, imshow(yellowMask); title('yellowMask');

whiteMaskR = roicolor(image(:,:,1),whiteRange{1}(1),whiteRange{2}(1));
whiteMaskG = roicolor(image(:,:,2),whiteRange{1}(2),whiteRange{2}(2));
whiteMaskB = roicolor(image(:,:,3),whiteRange{1}(3),whiteRange{2}(3));
whiteMask = bitand(whiteMaskR,whiteMaskG);
whiteMask = bitand(whiteMask,whiteMaskB);

%figure, imshow(whiteMask); title('whiteMask');

colorMask = bitor(yellowMask,whiteMask);
colorMaskInt = uint8(colorMask);

maskedImage = grayImage .* colorMaskInt;
%figure, imshow(maskedImage); title('colorMask');

%% Blur the image
kernelSize = 5;
blurredImage = imgaussfilt(maskedImage,5);
%figure, imshow(blurredImage)

%% Canny edge detection
%cannyThreshold = [0.24, 0.59];
cannyThreshold = [0.1, 0.2];
%blurredImage = imgaussfilt(grayImage,5);
edgesImage = edge(blurredImage,'Canny',cannyThreshold);
figure, imshow(edgesImage)

%% Image masking (ROI) based on camera orientation
roiImage = edgesImage .* roipoly(edgesImage,[50 365 590 935],[540 330 330 540]);
imshow(roiImage);

%% Find Hough parameters
[houghImage,houghTheta,houghRho] = hough(roiImage,'RhoResolution',0.10);
houghPeaks = houghpeaks(houghImage,5,'threshold',ceil(0.3*max(houghImage(:))));

%% Plot Hough space
figure, imshow(log(houghImage),[],'XData',houghTheta,'YData',houghRho,'InitialMagnification','fit');
xlabel('\theta'), ylabel('\rho'); axis on, axis normal, hold on;
x = houghTheta(houghPeaks(:,2)); y = houghRho(houghPeaks(:,1));
plot(x,y,'s','color','white');

%% Extract Hough lines and project them on the original image
houghFillGap    = 70;
houghMinLength  = 100;

lines = houghlines(edgesImage,houghTheta,houghRho,houghPeaks,'FillGap',houghFillGap,'MinLength',houghMinLength);
figure, imshow(image), hold on
for k = 1:length(lines)
    xy = [lines(k).point1; lines(k).point2];
    plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');
end

%% Insert line extrapolation here
