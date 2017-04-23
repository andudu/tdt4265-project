% Displays the circular signs with a text-box describing the sign and a
% circle surrounding the sign.
function describingFigure = getCircularResult(img, classes, centers, radii)

if (length(classes) ~= length(radii)) % If not the same number of signs were detected as the number of circles.
    fprintf('The number of signs do not match the number of circles');
    return;
end

position = [];
count = 1;

% Looping through all the signs.
for i = 1:length(classes)
    if strcmp(char(classes{i}), 'Unidentified')
        fprintf('Unknown sign.\n');
    else
        labelStr{count} = ['Circular sign: ', char(classes{i})]; % Used to store the predicted labels.
        position = [position; centers(i, 1), centers(i, 2), radii(i)];
        count = count + 1;
    end
end

if size(position, 1) > 0
    describingFigure = insertObjectAnnotation(img, 'circle', position, labelStr, 'LineWidth', 3, 'Color', 'y', 'TextColor', 'black');
else
    describingFigure = -1;
end
end