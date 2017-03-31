function imds = setUpImds(loadFolder)

categories = {'00001', '00002', '00003', '00004', '00005', '00006', '00007', '00008', '00009', '00010'};
imds = imageDatastore(fullfile(loadFolder, categories), 'LabelSource', 'foldernames');

end