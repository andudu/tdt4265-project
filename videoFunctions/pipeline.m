videoFileName = 'hastighet.mp4';
frames = readVideo(videoFileName); 

% Gjør noe morsomt her! Får ut "Matlab-bildefil ved frames{<ønsket index>}.
newFrames = circularSignFrames(net, frames);

processedVideoFileName = 'labeledHastighet.avi';
writeVideo(processedVideoFileName, newFrames);