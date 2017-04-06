% % -----CONVERTING THE DATA TO THE CORRECT FORMAT-----
% 
% loadFolder = 'C:\Users\Krist\Desktop\GTSRB\Final_Training\Images';
% saveFolder = 'C:\Users\Krist\Desktop\preprocessed\';
% wantedFolders = [0, 1, 2, 3, 4, 5, 6, 7, 8, 11, 12, 13, 14, 16, 17, 20, 21, 22, 25, 27, 31, 33, 34, 35, 36, 37, 38, 39, 40]; % Determines which classes we load.
% loadAndPreprocessData(saveFolder, loadFolder, wantedFolders);
% 
% % -----LOADING THE IMDS-----
% 
% loadFolder = 'C:\Users\Krist\Desktop\preprocessed\';
% imds = setUpImds(loadFolder, wantedFolders);
% [testSet, trainingSet] = splitEachLabel(imds, 0.3, 'randomize');
% 
% % -----LOADING ALEXNET, MODIFYING IT TO FIT THE DATA AND TRAIN IT-----
% 
% net = transferLearning(trainingSet);
% 
% -----TEST THE ACCURACY OF THE NET-----

accuracy = checkAccuracy(testSet, net);

% % -----DETECT IN IMAGE----- (not really useful)
% 
% img = imread('50grense.jpg');
% activationMap = detectInImage(img, 70, 2, net);
% 
% % -----DETECT IN WINDOW-----
% 
% class = classifyWindow(net, window);
% 
% % -----COMBINING DIFFERENT METHODS TO DETECT IN IMAGE-----
% 
% img = imread('veimed50.jpg');
% [signs, centers, radii] = getCircularSigns(img);
% classes = classifySigns(net, signs);
% describingImg = getCircularResult(img, classes, centers, radii);