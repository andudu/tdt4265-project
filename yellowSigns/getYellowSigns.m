% Intended to return windows of an image where the intensity of yellow is
% high. Nor finished.

function windows = getYellowSigns(img)

grayImage = rgb2gray(img);
[height, width] = size(grayImage);

% Color masking (ROI)
yellowRange = {[140 80 0] [210 130 40]};

yellowMaskR = roicolor(img(:,:,1),yellowRange{1}(1),yellowRange{2}(1));
yellowMaskG = roicolor(img(:,:,2),yellowRange{1}(2),yellowRange{2}(2));
yellowMaskB = roicolor(img(:,:,3),yellowRange{1}(3),yellowRange{2}(3));
yellowMask = bitand(yellowMaskR,yellowMaskG);
yellowMask = bitand(yellowMask,yellowMaskB);

colorMaskInt = uint8(yellowMask);
maskedImage = grayImage .* colorMaskInt;
binaryImage = maskedImage > 50;

grid = findIntensityGrid(binaryImage, 227, 25);

end