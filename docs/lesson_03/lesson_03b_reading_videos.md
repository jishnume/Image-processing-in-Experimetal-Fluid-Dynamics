
# Reading videos

The script describes simple ways to read videos using MATLAB.

# Reading a video
```matlab
% Reading images
video_file=VideoReader("../../data/data_sedimentation/vid_sphere.mp4");  % Image from curling
```

Once you read a video and before extracting some individual frames, it is often important to check some information about the video file, for example the total number of frames, framerate etc. All such information can be found with the help of the video\_file variable. 

```matlab
% disp(video_file)   % --> for printing everything
fprintf("Total number of frames = %d",video_file.NumFrames)
```

```matlab
fprintf("Total duration = %f seconds",video_file.Duration)
```

```matlab
fprintf("Frame-rate of the video = %f (frames/sec)",video_file.FrameRate)
```
# Extracting image frames from a video
```matlab
img=read(video_file,1000);
image_viewer(img,"Extracted Frame")
```
# Using GUI tool

In MATLAB, you can use the **video\_viewer** app to inspect a video.

```matlab
vid_filename="../../data/data_sedimentation/vid_sphere.mp4";
% implay(vid_filename)  % command for the GUI app
```
# Task

Use the **Video Viewer** app to inspect the video frame by frame.

