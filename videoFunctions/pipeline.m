videoFileName = 'vei.mp4';
frames = readVideo(videoFileName); 

% Gjør noe morsomt her! Får ut "Matlab-bildefil ved frames{<ønsket index>}.

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

processedVideoFileName = 'labeledVei.avi';
writeVideo(processedVideoFileName, newFrames);