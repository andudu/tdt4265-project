
%----------read image------------
rgb = imread('Bilder/00080.ppm');
figure(1)
imshow(rgb)

%--------find circles in image--------------
[centers, radii] = imfindcircles(rgb,[10 30]) %denne bruker houghtransform - kan eventuelt implementere denne selv
%viscircles(centers, radii,'EdgeColor','b');
for r=1:length(radii)
    fullradius(r)=radii(r)+radii(r)*0.35;
end    

i=1;
maxcorr=zeros(7,1)
figure(1)
viscircles(centers,radii+radii*0.35,'Color','y','LineWidth',1.2);
determinedSign=zeros(length(radii),1);
%--------find position of circle and crop it out---------------
for circlenr=1:length(radii)
    xmin = centers(circlenr,1) - fullradius(circlenr);
    width = 2 * fullradius(circlenr);
    ymin = centers(circlenr,2) - fullradius(circlenr);
    height = 2 * fullradius(circlenr);
    sign_color = imcrop(rgb, [xmin, ymin, width, height]);
    sign_bw=rgb2gray(sign_color);
    figure(2)
    imshow(sign_bw)
%-------for all sircles, find which sign-------
    for speed=1:13
        if speed <= 7 && speed >=1
            filenameSign=strcat(int2str((speed+2)*10),'skilt.jpg');
        else
            filenameSign=strcat(int2str(speed),'skilt.jpg');
        end
        signfullsize=imread(filenameSign);
        sign_template_bw=rgb2gray(signfullsize);
        sign_template_bw_resized = imresize(sign_template_bw,[2*(fullradius(circlenr)) 2*(fullradius(circlenr))]);
        corrSpeed = normxcorr2(sign_template_bw_resized,sign_bw);
        maxcorr(i)=max(corrSpeed(:));
        i=i+1;
    end
    i=1;
    [correlation,index] = max(maxcorr);
    if index <= 7 && index >=1
        determinedSign(i)=(index+2)*10;
        fprintf('A %d speed limit sign was detected \n',(index+2)*10)
    else
        fprintf('A type %d sign was detected \n',index)
        fil=strcat(int2str(index),'skilt.jpg');
        imshow(fil)
        maxcorr
    end
end

