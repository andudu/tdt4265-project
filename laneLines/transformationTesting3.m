img = imread('road.jpg');

% Doing the transformation
movingPoints = [514, 530; 743, 530; 1, 782; 1278, 782]; % top left, top right, bottom left, bottom right
fixedPoints = [1, 1; size(img,2), 1; 1, size(img,1); size(img,2), size(img,1)]; % top left, top right, bottom left, bottom right
tForm = fitgeotrans(movingPoints, fixedPoints, 'Projective');
RA = imref2d([size(img,1) size(img,2)], [1 size(img,2)], [1 size(img,1)]); % rows, cols, limits of x, limits of y
[tImg, r] = imwarp(img, tForm, 'OutputView', RA); % A perspective projection. (1, 3) and (2, 3) is not zero. Also, we have a little translation.

% Doing the inverse transformation
tForm2 = fitgeotrans(fixedPoints, movingPoints, 'Projective');
[tImg2,r] = imwarp(tImg, tForm2, 'OutputView', RA);

figure;
imshow(img, RA);

figure;
imshow(tImg, r);
axis off;

figure;
imshow(tImg2);