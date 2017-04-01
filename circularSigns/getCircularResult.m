% Displays the circular signs with a text-box describing the sign and a
% circle surrounding the sign.
function describingImg = getCircularResult(img, classes, centers, radii)

if (length(classes) ~= length(radii)) % If not the same number of signs were detected as the number of circles.
    fprintf('The number of signs do not match the number of circles');
    return;
end

labelStr = cell(1, length(classes)); % Used to store the predicted labels.
position = zeros(length(classes), 3); % Storing the position and the radius of signs.

% Looping through all the signs.
for i = 1:length(classes)
    labelStr{i} = ['Sign: ', char(classes{i})];
    position(i, 1) = centers(i, 1);
    position(i, 2) = centers(i, 2);
    position(i, 3) = radii(i);
end

RGB = insertObjectAnnotation(img, 'circle', position, labelStr, 'LineWidth', 3, 'Color', 'y', 'TextColor', 'black');
imshow(RGB);
F = getframe;
[describingImg, map] = frame2im(F);

[height, width, three] = size(img);
describingImg = imresize(describingImg, [height, width]); % For some reason the insertObjectAnnotation changes the size slightly.
end