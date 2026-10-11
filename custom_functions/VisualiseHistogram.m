%{
About this script
=================
I am writing a function here to visualise the histogram of an image

inputs
======
img_gray: grayscale image
b_width: bin width

%}

function VisualiseHistogram(img_gray,b_width)
    % Custom bin edges (for uint8 images, range 0-255)
    edges = 0:b_width:255;

    figure('Position',[100,100,600,500]);
    histogram(img_gray(:), 'BinEdges', edges, ...
        'FaceColor', [0.5,0.5,0.5], 'EdgeColor', 'k')
    xlabel('Intensity',fontsize=20)
    ylabel('Pixel count',fontsize=20)
    ax=gca;ax.XAxis.FontSize=16;ax.YAxis.FontSize=16;
    xlim([0 255])
    grid on;
    ax.GridLineWidth=1;ax.GridColor=[0.25,0.25,0.25];
end