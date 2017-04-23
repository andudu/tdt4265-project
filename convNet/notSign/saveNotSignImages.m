function saveNotSignImages(N, kernelSize) % Images must be in same folder and have names 1.jpg, 2.jpg, ...

global idx;
idx = 1;

for i = 1:N
    filename = sprintf('%d.jpg', i);
    img = imread(filename);
    saveWindows(img, kernelSize);
end
end