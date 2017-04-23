% Sliding window.

videoFileName = 'Film3.mov';
frames = readVideo(videoFileName);


for i = 1:(length(frames) - 2)
    img = frames{i};
    img = imresize(img, [2160, 3840]);
    
    [classes, positions] = slidingWindow(net, img, 100, 227);
    
    drawSlidingWindowResult(classes, positions, 227, img);
    
    F = getframe;
    [describingImg, map] = frame2im(F);

    [height, width, three] = size(img);
    describingImg = imresize(describingImg, [height, width]); % For some reason the insertObjectAnnotation changes the size slightly.
    
    newFrames{i} = describingImg;
end

processedVideoFileName = 'Film3LabeledSW.avi';
writeVideo(processedVideoFileName, newFrames);