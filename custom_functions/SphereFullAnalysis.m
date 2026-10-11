function data_sphere=SphereFullAnalysis(video_sphere,param,frame_vec)
    % Reading a blank image
    img_blank=read(video_sphere,video_sphere.NumFrames);
    
    % temporary variables to store trajectory of the sphere
    x_temp=[];
    y_temp=[];
    r_temp=[];
    
    
    for k=frame_vec(1):frame_vec(end)
        % Reading a frame
        img=read(video_sphere,k);
        I=sedimentation_DIP_function(img,param);

        % Fitting a circle to find the centre
        x_co=[];y_co=[];
            
        % Checking no of components
        cc=bwconncomp(I);
        n_objs=cc.NumObjects;

        % Code will throw error if it cannot find anything on the
        % edge-detected object. The if-else condition prevents that and
        % store a NaN.
        if n_objs~=0
            % finding the points
            for i=1:size(I,1)
                for j=1:size(I,2)
                    if I(i,j)==1
                        x_co=[x_co,i];
                        y_co=[y_co,j];
                    end
                end
            end

            % Least square fitting
            circle_data=[y_co',x_co'];
            d=curvature_measurement_function(circle_data,I,false,false);
            x_temp=[x_temp,d(1)];   % x-coordinate of fitted circle
            y_temp=[y_temp,d(2)];   % y-coordinate of fitted circle
            r_temp=[r_temp,d(3)];   % radius of fitted circle
            disp('Centroid calculated for frame = '+string(k))
        else
            x_temp=[x_temp,NaN];
            y_temp=[y_temp,NaN];
            disp('Centroid calculation failed for frame = '+string(k))
        end
        
        
    end

    % saving data in form of table
    data_sphere=[frame_vec',y_temp',x_temp'];

    %{
    ----- variable names ------
    frames: instance of frames analysed. This needs to be converted to time by
    suitably deciding on the t=0 frame.
    pos_width: vectors along the the horizontal direction (along width)
    pos_ver: vectors along the vertical direction (along height)
    
    %}
end