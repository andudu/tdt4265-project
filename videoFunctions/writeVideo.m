% Saves a video given a cell array of images of equal size.

function writeVideo(filename, frames)

v = VideoWriter(filename);
open(v);

for numFrame = 1:(length(frames) - 5) % -5 to make sure we are not trying to write some empty frames at the end.
    writeVideo(v, frames{numFrame});
end

close(v);
end