% Returns a cell array with all the images in the video.

function frames = readVideo(filename)

v = VideoReader(filename);
frames = cell(1, ceil(v.Duration*v.FrameRate));
pos = 1;

while hasFrame(v)
    frame = readFrame(v);
    frames{pos} = frame;
    pos  = pos + 1;
end
end