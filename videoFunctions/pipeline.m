% Lane lines and circular signs.

videoFileName = 'Film3.mov';
frames = readVideo(videoFileName); 

for i = 1:(length(frames) - 2)
    % Works by getting an image with marked signs and then displaying the
    % lane lines on top of this image. 
    newCircularSignFigure = circularSignFrame(net, frames{i});
    figureHandle = laneLineFrame(frames{i}, newCircularSignFigure);

    F = getframe;
    [describingImg, map] = frame2im(F);

    [height, width, three] = size(frames{i});
    describingImg = imresize(describingImg, [height, width]); % For some reason the insertObjectAnnotation changes the size slightly.
    
    newFrames{i} = describingImg;
    close(figureHandle);
end

processedVideoFileName = 'Film3Labeled.avi';
writeVideo(processedVideoFileName, newFrames);