%% Overlay basic shapes on image
image = imread('peppers.png');
image = insertShape(image,'FilledCircle',[430 70 30],'LineWidth',5,'Color','green');
imshow(image);

%% Overlay one image on another
figure1 = figure;
ax1 = axes('Parent',figure1);
ax2 = axes('Parent',figure1);
set(ax1,'Visible','off');
set(ax2,'Visible','off');

[a,map,alpha] = imread('speedLimit80.png');
I = imshow(a,'Parent',ax2);
set(I,'AlphaData',alpha);

imshow('peppers.png','Parent',ax1);