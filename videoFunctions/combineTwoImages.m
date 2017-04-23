function combinedImg = combineTwoImages(img0, img1, img2) % img0 is the original image without any marking.

combinedImg = img0;
allowedMargin = 5;

[height, width, ~] = size(img0);

if any(size(img0) ~= size(img1)) || any(size(img0) ~= size(img2))
    fprintf('The dimension of the images are not equal.');
    return;
end

for row = 1:height
    for col = 1:width
        similar = 1;
        for colour = 1:3
            if img0(row, col, colour) > (img1(row, col, colour) + allowedMargin) || img0(row, col, colour) < (img1(row, col, colour) - allowedMargin)
                similar = 0;
            end
        end
        
        if ~similar
            combinedImg(row, col, :) = img1(row, col, :);
        end
        
        similar = 1;
        for colour = 1:3
            if img0(row, col, colour) > (img2(row, col, colour) + allowedMargin) || img0(row, col, colour) < (img2(row, col, colour) - allowedMargin)
                similar = 0;
            end
        end
        
        if ~similar
            combinedImg(row, col, :) = img2(row, col, :);
        end
    end
end      

end