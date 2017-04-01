function class = classifyWindow(net, window)

[height, width, layers] = size(window);

if height == 227 && width == 227
    class = classify(net, window);
else
    class = -1;
    fprintf('Illegal window size.');
end
end