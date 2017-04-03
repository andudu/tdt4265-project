img = imread('stripeOgSkilt.JPG');

newCircularSignFigure = circularSignFrame(net, img);
laneLineFrame(img, newCircularSignFigure);

F = getframe;
[describingImg, map] = frame2im(F);

[height, width, three] = size(img);
describingImg = imresize(describingImg, [height, width]); % For some reason the insertObjectAnnotation changes the size slightly.