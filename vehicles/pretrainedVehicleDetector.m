% Load vehicle data set
data = load('fasterRCNNVehicleTrainingData.mat');

% Load pretrained detector
detector = data.detector;

%% Test!
% Read a test image
%I = imread('yellowSign.jpg');

videoFileName = 'Film3.mov';
frames = readVideo(videoFileName);  

%% Run the detector
[bboxes, scores] = detect(detector, cell2mat(frames(250)), 'SelectStrongest', true, 'MinSize', [100 150]);

%%
%scores = scores(scores > 0.99);
newScores = [];
newBboxes = [];
for i = 1:length(scores)
    if scores(i) > 0.999
        newScores = [newScores; scores(i)];
        newBboxes = [newBboxes; bboxes(i,:)];
    end
end

%% Annotate detections in the image
annotation = cell(length(newScores),1);
for i = 1:length(newScores)
    annotation{i} = ['Vehicle: ' num2str(100*newScores(i),'%0.2f') '%'];
end

I = insertObjectAnnotation(I, 'rectangle', newBboxes, annotation);
figure
imshow(I)

%% Annotate detections in the image
annotation = cell(length(scores),1);
for i = 1:length(scores)
    annotation{i} = ['Vehicle: ' num2str(100*scores(i),'%0.2f') '%'];
end

I = insertObjectAnnotation(cell2mat(frames(250)), 'rectangle', bboxes, annotation);
figure
imshow(I)