% -----------------------------------------------------------
%           Detail about the function parameters            -
% -----------------------------------------------------------

% img :  imread("imag_filename.png");
% plot_title: this is a string variable denoting the title to the image

function image_viewer(img,plot_title)
    figure;
    imshow(img)
    title(plot_title,color='b',fontsize=16)
    pause(1);
end