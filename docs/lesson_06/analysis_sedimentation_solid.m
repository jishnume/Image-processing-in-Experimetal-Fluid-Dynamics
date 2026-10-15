%{
About the script
================
This is a typical full script that I use normally to analyse a full
sedimentation experiment.

///////////////////////////////////////////
//             DO IT YOURSELF            //
///////////////////////////////////////////


- Based on our improved understanding from the previous lessons (00-05),
now you will try to analyse a full (sedimentation) experiment.


- The full analysis can be divided into three steps -->
    o - Setting up the image-processing parameters
    o - Use the image-processing parameters to complete a full analysis
    o - Post processing of generated data


- I have intentionally left some of the image processing parameters as NaN
(for numerical values) and [] for empty arrays. The task now will be to
decide on these parameters on your own to build on the analysis routine.

  
- All the places where you will need to add your own values are marked as "decision".

  
- Note that at first stage, you will store all the image-processing
parameters into a struct calling here as "param". In the next stages, you
will extract the choosen parameters (without manually copy and pasting it).



written by: Jishnu Goswami
contact: goswamijishnume@gmail.com

%}


% //////////////////////////////////////////
%      Stage-1: Setting Parameters        //
% //////////////////////////////////////////

% Read the video file
video_filepath="";      % <-- Enter fullpath or relative path to the video.
video_sphere=VideoReader(video_filepath);
disp('Number of frame = '+string(video_sphere.NumFrames))

% storing the video_sphere object into a struct variable 'param'
param.video_sphere=video_sphere; 


% first physical frame (frame @t=0sec)
first_physical_frame=50;
param.first_physical_frame=first_physical_frame;

% final frame for analysis
final_frame=1800;
param.final_frame=final_frame;


%%


% /////////////////////////////////
%         Decision-1             //
% /////////////////////////////////

% Here you will choose a frame from the video to set the processing
% parameters

test_frame_num=NaN;

% Reading the test frame
img=read(video_sphere,test_frame_num);
image_viewer(img,"Selected test frame")

%%


% /////////////////////////////////
%         Decision-2             //
% /////////////////////////////////
% here, the goal is to select a rectangle to crop the image

% crop rectangle
crop_rect=[];
param.crop_rect=crop_rect;

% cropping the image
img_crop=imcrop(img,crop_rect)
image_viewer(img_crop,"Cropped Image")


%%


% Converting the image to grayscale
img_gray=im2gray(img_crop);
image_viewer(img_gray,"Grayscale Image")
 

%%

% /////////////////////////////////
%         Decision-3             //
% /////////////////////////////////
% Adjusting the contrast

contrast_rect=[];
img_adj=imadjust(img_gray,contrast_rect,[0/255,255/255]);
image_viewer(img_adj,'Contrast Enhanced Image')
param.contrast_rect=contrast_rect;
  

%%


% /////////////////////////////////
%         Decision-4             //
% /////////////////////////////////
% applying a gaussian filter

gaussian_sigma=NaN;
img_filter=imgaussfilt(img_adj,gaussian_sigma);
param.gaussian_sigma=gaussian_sigma;
image_viewer(img_filter,"filtered image")


%%


% /////////////////////////////////
%         Decision-5             //
% /////////////////////////////////
% applying "Canny" edge detection

canny_threshold_rect=[];
canny_sigma=NaN;
param.canny_sigma=canny_sigma;
param.canny_threshold_rect=canny_threshold_rect;

img_canny=edge(img_filter,"canny_old",canny_threshold_rect,canny_sigma);
image_viewer(img_canny,"Canny Detected Image")


%%

% saving the 'param' struct
save('params_sedimentation.mat','param');

close all;clear;clc


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

cal_factor=25;
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
