function I=sedimentation_DIP_function(img,param)

% cropping the image
img_crop=imcrop(img,param.crop_rect);

% converting to grayscale
img_gray=im2gray(img_crop);

% Changing the contrast
img_adj=imadjust(img_gray,param.contrast_rect);


% Filtering prior edge-detection
img_filter=imgaussfilt(img_adj,param.gaussian_sigma);

% 'Canny' edge detection
img_canny=edge(img_filter,'canny_old',param.canny_threshold_rect,param.canny_sigma);

% further processing
I=img_canny;
end