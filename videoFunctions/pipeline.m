videoFileName = 'panorama.mp4';
frames = readVideo(videoFileName);

% Gj�r noe morsomt her! F�r ut "Matlab-bildefil ved frames{<�nsket index>).

writeVideo('panorama2.avi', frames);