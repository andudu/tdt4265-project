function drawlines(img, lines)
    imgsize=size(img);
    x_max=imgsize(1);
    y_max=imgsize(2);
    figure,imshow(img), hold on
    for k = 1:length(lines)
        j=3;
        x1=lines(k).point1(2);
        y1=lines(k).point1(1);
        x2=lines(k).point2(2);
        y2=lines(k).point2(1);
        gradient=(y2-y1)/(x2-x1);
        y(1)=y1;
        y(2)=y2;
        x(1)=x1;
        x(2)=x2;
        while x2 > x_max/1.6
            y(j)=y2-gradient*1;
            x(j)=x2-1;
            x2=x(j);
            y2=y(j);
            j=j+1;
        end
        while x1 < x_max-1
            y(j)=y1+gradient*1;
            x(j)=x1+1;
            x1=x(j);
            y1=y(j);
            j=j+1;
        end
        plot(y,x,'LineWidth',3,'Color','green');
    end
end

