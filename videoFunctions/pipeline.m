videoFileName = 'hastighet.mp4';
frames = readVideo(videoFileName); 

% Gj�r noe morsomt her! F�r ut "Matlab-bildefil ved frames{<�nsket index>}.
newFrames = circularSignFrames(net, frames);

processedVideoFileName = 'labeledHastighet.avi';
writeVideo(processedVideoFileName, newFrames);