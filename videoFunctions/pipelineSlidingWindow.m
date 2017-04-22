videoFileName = 'Film3.mov';
% frames = readVideo(videoFileName); % Remember to comment/uncomment!

% Gjør noe "morsomt" her! Får ut "Matlab-bildefil ved frames{<ønsket index>}.

for i = 1:(length(frames) - 2)
    [classes, positions] = slidingWindow(net, frames{i}, 100, 227);
    
    drawSlidingWindowResult(classes, positions, 227, frames{i});
    
    F = getframe;
    [describingImg, map] = frame2im(F);

    [height, width, three] = size(frames{i});
    describingImg = imresize(describingImg, [height, width]); % For some reason the insertObjectAnnotation changes the size slightly.
    
    newFrames{i} = describingImg;
end

processedVideoFileName = 'Film3LabeledSW.avi';
writeVideo(processedVideoFileName, newFrames);