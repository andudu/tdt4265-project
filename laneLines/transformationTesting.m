img = imread('checkerboard.png');
img = rgb2gray(img);
[height, width] = size(img);
xWorldLimits = [-width/2, width/2];
yWorldLimits = [-height/2, height/2];

Rin = imref2d(size(img), xWorldLimits, yWorldLimits);

shearMat = [1, 0, 0; 0, 1, 0; 0, 0, 1];
shear = projective2d(shearMat);

tImg = imwarp(img, Rin, shear);
figure;
imshow(tImg);

figure;
imshow(img, Rin);