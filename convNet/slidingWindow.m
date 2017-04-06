% Av en eller annen grunn er den veldig fan av construction work... Kan
% eventuelt si at hvis construction work -> false positive.
% Ser ut som om vi kan skru opp sikkerheten ganske høyt.
function [classes, positions] = slidingWindow(net, img, stride, kernelSize)

[height, width, ~] = size(img);

rows = 1:stride:(height - kernelSize);
cols = 1:stride:(width - kernelSize);

classPos = 1;
positions = [];

for i = 1:length(rows)
    row = rows(i);
    for j = 1:length(cols)
        col = cols(j);       
        window = img(row:(row + kernelSize - 1), col:(col + kernelSize - 1), :);
        
        activation = activations(net, window, 25);
        class = classify(net, window);
        
        if max(activation) > 0.95
            classes{classPos} = changeClassName(class);
            positions = [positions; row, col];
            
            img(row:(row + kernelSize - 1), col:(col + kernelSize - 1), :) = 0; % Deleting the region where a sign was detected from the image.
            classPos = classPos + 1;
        end
    end
end
end