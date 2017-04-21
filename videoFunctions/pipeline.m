videoFileName = 'hastighet.mp4';
frames = readVideo(videoFileName); 

% Gjør noe "morsomt" her! Får ut "Matlab-bildefil ved frames{<ønsket index>}.

for i = 1:(length(frames) - 2)
    % Works by getting an image with marked signs and then displaying the
    % lane lines on top of this image. 
    newCircularSignFigure = circularSignFrame(net, frames{i});
    figureHandle = laneLineFrame(frames{i}, newCircularSignFigure);

    F = getframe;
    [describingImg, map] = frame2im(F);

    [height, width, three] = size(frames{i});
    describingImg = imresize(describingImg, [height, width]); % For some reason the insertObjectAnnotation changes the size slightly.
    
    % Mulig det er best å lage én describingImg for hver
    % gjenkjenningsmetode og så slå sammen bildene til ett.
    
    newFrames{i} = describingImg;
    close(figureHandle);
end

processedVideoFileName = 'labeledHastighet2.avi';
writeVideo(processedVideoFileName, newFrames);