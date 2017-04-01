% Using the CNN to classify 227x227 signs.
function classes = classifySigns(net, signs)

if isempty(signs) % If there are no signs to classify.
    classes{1} = 'Error';
    return;
end

% Looping through all the signs.
for i = 1:length(signs)
    [height, width, three] = size(signs{i});
    fprintf('Width: %d, height: %d\n', width, height);
    
    activation = activations(net, signs{i}, 25); % Checking what the classification-layer looks like.
    if max(activation) > 0.5 % Only classify if more than 50 % certain.
        classes{i} = classifyWindow(net, signs{i});
    else
        classes{i} = 'Unidentified';
    end
end
end