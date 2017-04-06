function drawGeneralisedHoughResult(position, img, net, kernelSize, signShape)

[height, width] = size(img);
padding = ceil(kernelSize/2);
row = position(2);
col = position(1);

top = row - padding;
bottom = row + padding;
left = col - padding;
right = col + padding;

if ~(top > 0 && bottom <= height && left > 0 && right <= width)
    if top < 1
        top = 1;
        bottom = kernelSize - 1;
    end

    if left < 1
        left = 1;
        right = kernelSize - 1;
    end
    
    if bottom > height
        bottom = height;
        top = height - kernelSize + 1;
    end
    
    if right > width
        right = width;
        left = width - kernelSize + 1;
    end
end

window = img(top:bottom, left:right, :);
window = imresize(window, [kernelSize, kernelSize]); % Just to be sure.

class = classify(net, window);
activation = activations(net, window, 25);

if max(activation) > 0.3
    classStr = sprintf('%s: %s', signShape, changeClassName(char(class(1))));
    RGB = insertObjectAnnotation(img, 'rectangle', [left, top, kernelSize, kernelSize], classStr, 'LineWidth', 2);
    imshow(RGB);
end
end