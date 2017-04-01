% Using the CNN to classify a 227x227 window.
function class = classifyWindow(net, window)

[height, width, layers] = size(window);

if height == 227 && width == 227
    class = classify(net, window);
else
    class = 'Illegal window size.';
    fprintf('Illegal window size.');
end
end