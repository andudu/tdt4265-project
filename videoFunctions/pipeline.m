videoFileName = 'panorama.mp4';
frames = readVideo(videoFileName);

% Gjør noe morsomt her! Får ut "Matlab-bildefil ved frames{<ønsket index>).

writeVideo('panorama2.avi', frames);