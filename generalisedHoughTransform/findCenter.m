% Simply returns the center of a square.
function [xCenter, yCenter] = findCenter(template)

[rows, cols] = size(template);

xCenter = round(rows/2);
yCenter = round(cols/2);
end