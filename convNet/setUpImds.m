function imds = setUpImds(loadFolder, wantedFolders)

if isempty(wantedFolders)
    fprintf('Length of wantedFolders is 0.')
    imds = -1;
    return;
end

for i = 1:length(wantedFolders)
    folderName = sprintf('%05d', wantedFolders(i));
    categories{i} = folderName;
end

imds = imageDatastore(fullfile(loadFolder, categories), 'LabelSource', 'foldernames');

end