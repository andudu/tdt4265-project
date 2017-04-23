image = imread('roundabout.png');

%% Isolate red color regions [155 92 87]
colorRange = {[130 45 45] [180 110 100]};

colorMaskR = roicolor(image(:,:,1),colorRange{1}(1),colorRange{2}(1));
colorMaskG = roicolor(image(:,:,2),colorRange{1}(2),colorRange{2}(2));
colorMaskB = roicolor(image(:,:,3),colorRange{1}(3),colorRange{2}(3));
colorMask = bitand(colorMaskR,colorMaskG);
colorMask = bitand(colorMask,colorMaskB);

figure, imshow(colorMask);

colorMask = uint8(colorMask);
maskedImage = rgb2gray(image) .* colorMask;
figure, imshow(maskedImage);
