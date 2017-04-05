img = imread('checkerboard.png');

movingPoints = [1, 1; size(img,2), 1; 1, size(img,1); size(img,2), size(img,1)]; % top left, top right, bottom left, bottom right
fixedPoints = [180, 100; 340, 100; 50, 300; 450, 300]; % top left, top right, bottom left, bottom right
tForm = fitgeotrans(movingPoints, fixedPoints, 'Projective');


RA = imref2d([size(img,1) size(img,2)], [1 size(img,2)], [1 size(img,1)]); % rows, cols, limits of x, limits of y
[tImg,r] = imwarp(img, tForm, 'OutputView', RA);

imshow(tImg, r);
axis off;