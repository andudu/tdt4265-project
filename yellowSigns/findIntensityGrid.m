function grid = findIntensityGrid(binaryImg, kernelSize, stride)

[height, width] = size(binaryImg);

grid = zeros(floor(height/stride), floor(width/stride));

rows = 1:stride:height; % Top border
cols = 1:stride:width; % Left border

while sum(sum(binaryImg)) > 0
    maxIntensity = 0;
    maxRow = 0;
    maxCol = 0;
    for i = 1:(length(rows) - floor(kernelSize/stride))
        row = rows(i);
        for j = 1:(length(cols) - floor(kernelSize/stride))
            col = cols(j);
            window = binaryImg(row:(row + kernelSize - 1), col:(col + kernelSize - 1));
            grid(i, j) = sum(sum(window));
        end
    end
end
end