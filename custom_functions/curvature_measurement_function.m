% /////////////// Agenda ///////////////
% This function fits a circle to a sector extracted from edge detection
% function. The output is the centre of the fitted circle with its
% radius/curvature.
% 
% 
% //////////// Input Variables ///////////////////
% 1. data: corresponds to pixel coordinates of an edge in a binary image.
% The binary image should be the output of a edge finding algorithm such as
% Canny.

function data_fit=curvature_measurement_function(data,I_test,is_visualisation,is_visualise_initial_guess)

% extracting the vectors from the imported data
x_data=data(:,1);
y_data=data(:,2);

% utilising the read image(BW) to set the x & y limit on the axes
frame_width=size(I_test,2);
frame_height=size(I_test,1);


% initial guess of parameters
circ_x_ini=mean(x_data);
circ_y_ini=mean(y_data);
circ_R_ini=std(x_data-circ_x_ini);
initial_guess=[circ_x_ini,circ_y_ini,circ_R_ini];


% viewing the initial guess for fitting the circle
if is_visualise_initial_guess==true
    figure('Position',[100,100,800,300])
    scatter(y_data,x_data,30,'blue','filled','o',DisplayName="Data")
    hold on
    scatter(circ_y_ini,circ_x_ini,100,'red','x',linewidth=2,DisplayName="Initial guess (centre)")
    ax=gca;
    ax.XAxis.FontSize=14;
    ax.YAxis.FontSize=14;
    set(ax,'YDir','Reverse')
    xlabel("Frame Width",fontsize=14)
    ylabel("Frame Height",fontsize=14)
    legend(fontsize=14,location="northeast")
    box on;grid on;
end

% fitting a circle to the extracted sector
% equation of the circle: (x-a)^2+(y-b)^2=R^2
% while fitting the circle, I will have x and x data.
% The outcome of the fitting will be to determine the unknown parameters:
% a,b and R.

% Annonymous function for lsqcurvefit function in matlab
circle_fit_function=@(param,~) abs(sqrt((x_data-param(1)).^2+(y_data-param(2)).^2)-param(3)); % minimising absolute of the error
xdata=[];ydata=zeros(size(x_data));

% running lsqcurvefit
options=optimoptions('lsqcurvefit','Display','off');
param_fit=lsqcurvefit(circle_fit_function,initial_guess,xdata,ydata,[],[],options);

% extracting the fitting results
% I am getting here the estimate of a,b & R from the fitting.
a_fit=param_fit(1);
b_fit=param_fit(2);
R_fit=param_fit(3);


% ---------------------------------------
%         visualising the fit           -
% ---------------------------------------
theta=linspace(0,2*pi,100);
x_fit=a_fit+R_fit*cos(theta);
y_fit=b_fit+R_fit*sin(theta);


% ---------------------------------------
%             Goodness of fit           -
% ---------------------------------------
% calculating the residue
residual=sqrt((x_data-a_fit).^2+(y_data-b_fit).^2)-R_fit; 

% Root mean square error(RMSE)
RMSE=sqrt(mean(residual.^2));
nRMSE=RMSE/R_fit;   % normalised RMSE value


if is_visualisation==true
    % plotting the original data with the fitted data
    figure('Position',[100,100,800,300]);
    scatter(y_data,x_data,30,'blue','filled','o')
    hold on
    plot(y_fit,x_fit,color='red',linestyle='--',LineWidth=1)
    hold on
    scatter(b_fit,a_fit,100,'magenta','x',LineWidth=2)
    axis equal
    lgd=legend('Original Data','Fit Data','Centre',fontsize=14);
    lgd.Location='northwest';
    xlabel("Pixels",fontsize=18);
    ylabel("Pixels",fontsize=18);
    ax=gca;
    ax.XAxis.FontSize=16;
    ax.YAxis.FontSize=16;
    set(ax,'YDir','reverse')
    title('Fitting a circle through data',fontsize=14,fontweight='normal')
    box on;grid on;
end

% returning the result of fitting parameters
data_fit=[a_fit,b_fit,R_fit,nRMSE];

end