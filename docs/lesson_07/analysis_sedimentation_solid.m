%{
About the script
================
This is a typical script of analysing a full sedimentation experiment.

Experiment specification: A solid sphere moving through a viscous liquid
(kinematic viscosity=1000cst ---> Not to be used for calculating Stokes velocity)

Purpose
-------
I have developed this code file to show how a full analysis can be done.

written by: Jishnu Goswami

%}


% //////////////////////////////////////////
%      Stage-1: Setting Parameters        //
% //////////////////////////////////////////

% Read the video file
video_sphere=VideoReader('../../data/data_sedimentation/vid_sphere.mp4');
disp('Number of frame = '+string(video_sphere.NumFrames))
param.video_sphere=video_sphere; 


test_frame_num=[];  % test frame to check for DIP parameters

% Reading the test frame
img=read(video_sphere,test_frame_num);
image_viewer(img,"Test Image with the sphere")
 

% full crop-rect
img_crop_choose=im2gray(read(video_sphere,test_frame_num));
crop_rect_full=[];

% Updating the crop rectangle
crop_rect_physical=crop_rect_full;
crop_rect_physical(3)=crop_rect_physical(3); 

% ////////////////////////////////////
%        Selecting Frame vector     //
% ////////////////////////////////////
first_physical_frame=50;
param.first_physical_frame=first_physical_frame;

final_frame=1800;
param.final_frame=final_frame;

% Cropping the image
crop_rect=crop_rect_physical;
img_crop=imcrop(img,crop_rect);
param.crop_rect=crop_rect;
% image_viewer(img_crop,'Cropped Frame')


% Converting the image to grayscale
img_gray=im2gray(img_crop);
% image_viewer(img_gray,"Grayscale Image")
 

% Adjusting the contrast

contrast_rect=[];
img_adj=imadjust(img_gray,contrast_rect,[0/255,255/255]);
% image_viewer(img_adj,'Contrast Enhanced Image')
param.contrast_rect=contrast_rect;
  

% filtering the image
gaussian_sigma=NaN;
img_filter=imgaussfilt(img_adj,gaussian_sigma);
param.gaussian_sigma=gaussian_sigma;


% applying "Canny" edge detection
canny_threshold_rect=NaN;
canny_sigma=NaN;
param.canny_sigma=canny_sigma;
param.canny_threshold_rect=canny_threshold_rect;

img_canny=edge(img_filter,"canny_old",canny_threshold_rect,canny_sigma);
image_viewer(img_canny,"Canny Detected Image")


% saving the 'param' struct
save('params_sedimentation.mat','param');

%% 

% //////////////////////////////////////////
%          Stage-2: Full Analysis         //
% //////////////////////////////////////////

% loading the parameter struct
load('params_sedimentation.mat');
frame_vec=param.first_physical_frame:param.final_frame;

% FULL ANALYSIS
data_sphere=SphereFullAnalysis(param.video_sphere,param,frame_vec);
writematrix(data_sphere,'raw_data.csv',delimiter=',')
 
%% 

% ////////////////////////////////
%        POST-PROCESSING        //
% ////////////////////////////////

% reading file
data=readmatrix('raw_data.csv',delimiter=',');

load('params_sedimentation.mat');

cal_factor=25;    % need to read from a file
video_fps=29.97;

% extracting variables
frames=data(:,1)-param.first_physical_frame;
x_pixel=data(:,3);
y_pixel=data(:,2);


% Making the vectors dimensional
t_vec=frames/video_fps;
x_vec=x_pixel/cal_factor;
y_vec=y_pixel/cal_factor;
 
 
figure('Position',[100,100,600,500])
scatter(t_vec(1:gap:end),x_vec(1:gap:end),30,'blue','filled')
xlabel('$t$ (s)',fontsize=20,interpreter='latex')
ylabel('$y$ (cm)',fontsize=20,interpreter='latex')
title('Position vs time plot',fontsize=14,color=[0.5,0.5,0.5],FontWeight='normal')
ax=gca;
ax.XAxis.FontSize=18;
ax.YAxis.FontSize=18;
ylim([0,70])
box("on");
grid("on");