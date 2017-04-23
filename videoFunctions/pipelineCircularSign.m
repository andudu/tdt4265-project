% Circular signs.

videoFileName = 'hastighet.mp4';
frames = readVideo(videoFileName); 

for i = 1:(length(frames) - 2)
    % Works by getting an image with marked signs and then displaying the
    % lane lines on top of this image. 
    newCircularSignFigure = circularSignFrame(net, frames{i});

    describingImg = newCircularSignFigure;
    imshow(describingImg);

    [height, width, three] = size(frames{i});
    describingImg = imresize(describingImg, [height, width]); % For some reason the insertObjectAnnotation changes the size slightly.
    
    newFrames{i} = describingImg;
end

processedVideoFileName = 'hastighetLabeled.avi';
writeVideo(processedVideoFileName, newFrames);