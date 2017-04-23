% Input is the CNN and a sequence of frames. Uses getCircularSigns to get
% 227x227 images containing only the circular signs and also their position
% and radius. Then, the CNN is used to classify each sign and the result is
% saved as a new frame with annotation.

function newFigure = circularSignFrames(net, frame)

[signs, centers, radii] = getCircularSigns(frame);
    
if signs{1} == -1 % Basically means that we have not detected any signs in the frame.
    fprintf('No sign was detected.\n');
    newFigure = frame;
else
    classes = classifySigns(net, signs);
    newFigure = getCircularResult(frame, classes, centers, radii);
    
    if newFigure == -1 % Means that even though a sign has been detected, it was not classified.
        newFigure = frame;
    end
end
end