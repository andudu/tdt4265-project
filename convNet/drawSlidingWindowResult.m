function drawSlidingWindowResult(classes, positions, kernelSize, img)

if positions == -1
    imshow(img);
    return;
end

plotInfo = zeros(length(classes), 4);

for i = 1:length(classes)
    classStr{i} = sprintf('Sliding window: %s', char(classes{i}));
    
    plotInfo(i, 1) = positions(i, 2);
    plotInfo(i, 2) = positions(i, 1);
    plotInfo(i, 3) = kernelSize;
    plotInfo(i, 4) = kernelSize;
end

RGB = insertObjectAnnotation(img, 'rectangle', plotInfo, classStr, 'LineWidth', 2);
imshow(RGB);

end