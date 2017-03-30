% https://se.mathworks.com/help/nnet/ref/alexnet.html
% Hadde problem med overfitting.

function netTransfer = transferLearning(trainingData)

net = alexnet;

layersTransfer = net.Layers(1:(end - 3)); % Extracting AlexNet without the last three layers (the classification layers).

numClasses = numel(categories(trainingData.Labels));

% Replacing the last three layers with the correct number of classes.
layers = [...
    layersTransfer
    fullyConnectedLayer(numClasses,'WeightLearnRateFactor',20,'BiasLearnRateFactor',20)
    softmaxLayer('name', 'softMax')
    classificationLayer('name', 'output')];

options = trainingOptions('sgdm',...
    'MiniBatchSize',5,...
    'MaxEpochs',1,...
    'InitialLearnRate',0.0001);

netTransfer = trainNetwork(trainingData, layers, options);

end