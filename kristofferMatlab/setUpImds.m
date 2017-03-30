function imds = setUpImds(loadFolder)

categories = {'00001', '00002'};
imds = imageDatastore(fullfile(loadFolder, categories), 'LabelSource', 'foldernames');

end