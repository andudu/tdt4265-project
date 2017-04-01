% From the dataset-website.
function loadAndPreprocessData(saveFolder, loadFolder, wantedFolders)

sBasePath = loadFolder; % For simplicity (not having to change name of variables).

for nNumFolder = wantedFolders % 0:42 if we want all classes.
    sFolder = num2str(nNumFolder, '%05d');
    
    sPath = [sBasePath, '\', sFolder, '\'];
    
    mkdir([saveFolder, sFolder, '\']); % Creating a new folder for the new class.

    if isdir(sPath)
        [ImgFiles, Rois, Classes] = readSignData([sPath, '\GT-', num2str(nNumFolder, '%05d'), '.csv']);
        
        for i = 1:numel(ImgFiles)
            ImgFile = [sPath, '\', ImgFiles{i}];
            Img = imread(ImgFile);
            
            fprintf(1, 'Currently processing: %s Class: %d Sample: %d / %d\n', ImgFiles{i}, Classes(i), i, numel(ImgFiles));
            
            Img = imresize(Img, [227, 227]);
            
            fullSavePath = sprintf('%s%s\\%i.png', saveFolder, sFolder, i);
            imwrite(Img, fullSavePath);
        end
    end
end
end

