%{
About this script
=================
This is a function written to visualise cropping rectangle over an image

%}

function CropRectViewer(img_gray,crop_rect)
    x = crop_rect(1);  y = crop_rect(2);
    w = crop_rect(3);  h = crop_rect(4);

    figure;
    imshow(img_gray)
    hold on
    hbox = plot([x x+w x+w x x], [y y y+h y+h y], ...
            'b-', 'LineWidth', 1.5, 'DisplayName', 'Crop region');
    legend(hbox,'Location','northeast',fontsize=20)

end