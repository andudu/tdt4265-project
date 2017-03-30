% From the dataset-website

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
            
            % Img = Img(Rois(i, 2) + 1:Rois(i, 4) + 1, Rois(i, 1) + 1:Rois(i, 3) + 1);
            % Img = cat(3, Img, Img, Img); % Need to have three layers for AlexNet. Still looks grayscale since R, G and B intensities are equal for all pixels.
            Img = imresize(Img, [227, 227]);
            
            fullSavePath = sprintf('%s%s\\%i.png', saveFolder, sFolder, i);
            imwrite(Img, fullSavePath);
        end
    end
end
end

