% An implementation of sliding window using the CNN.
function activationMap = detectInImage(img, stride, numClasses, net)

[height, width, channels] = size(img);
activationMap = zeros(height, width, numClasses);

if (height < 227 || width < 227 || channels ~= 3)
    fprintf('Illegal input');
    return;
end

topBorder = 1;
leftBorder = 1;
maxPos = [topBorder, leftBorder];
maxActivation = 0;

while (topBorder + 227 < height)
    leftBorder = 1;
    while(leftBorder + 227 < width)
        window = img(topBorder:(topBorder + 226), leftBorder:(leftBorder + 226), :);
        
        activation = activations(net, window, 25);
        activationMap(topBorder, leftBorder, :) = activation;
        
        if (activation(2) > maxActivation)
            maxActivation = activation(2);
            maxPos = [topBorder, leftBorder];
        end
        
        imshow(window);
        
        leftBorder = leftBorder + stride;
    end
    topBorder = topBorder + stride;
end
        
display(maxPos)

end