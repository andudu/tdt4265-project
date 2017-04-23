function saveWindows(img, kernelSize)

global idx;

[height, width, ~] = size(img);

row = 1;

while (row + kernelSize) < height
    col = 1;
    while (col + kernelSize) < width
        window = img(row:(row + kernelSize - 1), col:(col + kernelSize - 1), :);
        
        filename = sprintf('windows\\%d.png', idx);
        imwrite(window, filename);
        
        idx = idx + 1;
        col = col + kernelSize;
    end
    
    row = row + kernelSize;
end
end