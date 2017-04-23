% Using the CNN to classify a 227x227 window.
function class = classifyWindow(net, window)

[height, width, ~] = size(window);

if height == 227 && width == 227
    class = classify(net, window);
    
    if strcmp(char(changeClassName(class)), 'Non-sign')
        class = 'Unidentified';
    else
        class = changeClassName(class);
    end
else
    class = 'Illegal window size.';
    fprintf('Illegal window size.');
end
end