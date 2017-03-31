function signs = getCircularSigns(img)

[centers, radii] = imfindcircles(img,[10 30]);

signs = cell(1, length(radii));

for i = 1:length(radii)
    top = ceil(centers(i, 2) - radii(i));
    bottom = floor(centers(i, 2) + radii(i));
    left = ceil(centers(i, 1) - radii(i));
    right = floor(centers(i, 1) + radii(i));
    sign = img(top:bottom, left:right, :);
    signs{i} = imresize(sign, [227, 227]);
end

end