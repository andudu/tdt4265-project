videoFileName = 'hastighet.mp4';
frames = readVideo(videoFileName); 

% Gj�r noe morsomt her! F�r ut "Matlab-bildefil ved frames{<�nsket index>}.
for i = 1:(length(frames) - 2)
    newCircularSignFigure = circularSignFrames(net, frames{i});
    imshow(newCircularSignFigure);
    F = getframe;
    [describingImg, map] = frame2im(F);

    [height, width, three] = size(frames{i});
    describingImg = imresize(describingImg, [height, width]); % For some reason the insertObjectAnnotation changes the size slightly.
    
    newFrames{i} = describingImg;
end

processedVideoFileName = 'labeledHastighet.avi';
writeVideo(processedVideoFileName, newFrames);