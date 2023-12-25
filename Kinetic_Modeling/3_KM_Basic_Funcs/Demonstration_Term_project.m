%% Demonstration

clear all;
%% 1. Extracting image-derived data values and relavant header data from DICOM RT files
%% Pre-processing for loading DCM files (for Dynamic Data)
[Vol_PET, temp, Times, Num_Times]=Import_Dynamic_DCM_Single(); % Importing tool for Dynamic DCM files (made by Lee)
% Vol_PET: Volume Data with Time
% temp: Raw Data of all imported DCM files
% Times: Times of Image Acquisition
% Num_Times: the # of Times for the Image Acquisition

%% Extracting contour info. from DDCM RT Struct file
[RT_S_file, RT_S_path, RT_S_index]=uigetfile('*.dcm');
RT_S_file_path= [RT_S_path,RT_S_file];
RT_S_Header=dicominfo(RT_S_file_path);
RT_S_Contour=dicomContours(RT_S_Header); % Extracting absolute coordinates of points which make contours
plotContour(RT_S_Contour); % just for checking whether the extracting is proceeded well or not 
image_size=size(Vol_PET{1,1}); % the # of voxels along with Rows X Columns X Z axis
Limit_X=[(temp{1, 1}.ImagePositionPatient(1,1)), (temp{1,1}.PixelSpacing(2,1)*image_size(1,2))+(temp{1, 1}.ImagePositionPatient(1,1))]; % for X-limit
Limit_Y=[(temp{1, 1}.ImagePositionPatient(2,1)), (temp{1,1}.PixelSpacing(1,1)*image_size(1,1))+(temp{1, 1}.ImagePositionPatient(2,1))]; % for Y-limit
for i=1:1:size(temp,2)
    Limit_Z_temp(1,i)=temp{4,i};
end
Limit_Z= [min(Limit_Z_temp), max(Limit_Z_temp)]; % for Z-limit
reference_Info=imref3d(image_size, Limit_X, Limit_Y, Limit_Z);
Struct_Mask=createMask(RT_S_Contour, 1, reference_Info);
%volshow(Struct_Mask); % just for checking whether the logical volume of VOI is made well or not
Struct_Mask_array=double(Struct_Mask); % for making same data type with Vol_PET volume data (for matrix multiplication)
%Struct_Mask_array_flipped=flip(Struct_Mask_array, 3);
%volumeViewer(Vol_PET{1,1}, Struct_Mask_array_flipped);
%volumeViewer(Vol_PET{20,1}, Struct_Mask_array);
%sliceViewer(rtMask);

%% 2. Generating Iamge-Derived data points
% Getting image-derived data points
Num_of_Voxels_VOI=nnz(Struct_Mask_array);
for i=1:1:Num_Times
    Multiplied_matrix{i,1}=Vol_PET{i,1}.*Struct_Mask_array; % for verifying the values in the VOI
    Image_Derived_Data(i,1)= (sum(Multiplied_matrix{i,1}, 'all', 'double')) / (Num_of_Voxels_VOI); % Calc. of Mean Concentration of tracer in the VOI: unit = [Bq/ml]
end
% Converting HH:MM:SS format into seconds
for i=1:1:size(Times, 2)
    Image_Acquisition_Time_String_HH{1,i}=num2str(Times(1,i));
    Image_Acquisition_Time_String_HH{1,i}(3:6)=[];
end
for i=1:1:size(Times, 2)
    Image_Acquisition_Time_String_MM{1,i}=num2str(Times(1,i));
    Image_Acquisition_Time_String_MM{1,i}(1:2)=[];
    Image_Acquisition_Time_String_MM{1,i}(3:4)=[];
end
for i=1:1:size(Times, 2)
    Image_Acquisition_Time_String_SS{1,i}=num2str(Times(1,i));
    Image_Acquisition_Time_String_SS{1,i}(1:2)=[];
    Image_Acquisition_Time_String_SS{1,i}(1:2)=[];
end
for i=1:1:size(Times,2)
    Image_Acquisition_Time_Sec(1,i)= (str2num(Image_Acquisition_Time_String_HH{1,i})*3600.00) + (str2num(Image_Acquisition_Time_String_MM{1,i})*60.00) + str2num(Image_Acquisition_Time_String_SS{1,i}) ;
end
% for Radiopharmaceutical injection time (under the assumption that the time is given with the form like this, '120200.00', 6 digits with 2 decimal points)
for i=1:1:size(Times, 2)
    Tracer_Injection_Time_String_HH{1,i}=temp{1, 1}.RadiopharmaceuticalStartTime;
    Tracer_Injection_Time_String_HH{1,i}(7:9)=[];
    Tracer_Injection_Time_String_HH{1,i}(3:6)=[];
end
for i=1:1:size(Times, 2)
    Tracer_Injection_Time_String_MM{1,i}=temp{1, 1}.RadiopharmaceuticalStartTime;
    Tracer_Injection_Time_String_MM{1,i}(7:9)=[];
    Tracer_Injection_Time_String_MM{1,i}(1:2)=[];
    Tracer_Injection_Time_String_MM{1,i}(3:4)=[];
end
for i=1:1:size(Times, 2)
    Tracer_Injection_Time_String_SS{1,i}=temp{1, 1}.RadiopharmaceuticalStartTime;
    Tracer_Injection_Time_String_SS{1,i}(7:9)=[];
    Tracer_Injection_Time_String_SS{1,i}(1:4)=[];
end
for i=1:1:size(Times,2)
    Tracer_Injection_Time_Sec(1,i)= (str2num(Tracer_Injection_Time_String_HH{1,i})*3600.00) + (str2num(Tracer_Injection_Time_String_MM{1,i})*60.00) + str2num(Tracer_Injection_Time_String_SS{1,i}) ;
end
% Getting exact post-injection time for each frame
Post_Injection_Time_Sec= Image_Acquisition_Time_Sec - Tracer_Injection_Time_Sec; % PI time in terms of Sec
Post_Injection_Time_Min=Post_Injection_Time_Sec/60.0; % PI time in terms of Min
% Modifyting and Plotting the Image-Derived Data Points [time duration: 0~6 min]
for i=1:1:size(Post_Injection_Time_Min, 2)
    if Post_Injection_Time_Min(1,i) < 0.0
        Image_Derived_Data_from_zero_temp(i,1)=0.0;
        Post_Injection_Time_Min_from_zero_temp(1,i)=0.0;
    else
        Image_Derived_Data_from_zero_temp(i,1)=Image_Derived_Data(i,1);
        Post_Injection_Time_Min_from_zero_temp(1,i)=Post_Injection_Time_Min(1,i);
    end
end
Post_Injection_Time_Min_from_zero=[0.0, transpose(nonzeros(Post_Injection_Time_Min_from_zero_temp))];
Image_Derived_Data_from_zero=[0.0; nonzeros(Image_Derived_Data_from_zero_temp)];
% Converting [Bq/ml] to [kBq/ml] and plotting
Image_Derived_Data_from_zero_kBq=0.001.*Image_Derived_Data_from_zero;

%% 3. Generating Image-Derived Input Function (Using Feng's Model)
% Initial parameter values for the fitting [Tau, A_1, A_2, A_3, Lamda_1, Lamda_2, Lamda_3]
%Starting_Feng= [0.905 767.3 27.43 29.13 -4.195 -0.232 -0.0165]; % referenced from Feng's paper (Avg. value from Table 2 for Model #2)
%Starting_Feng= [0 500 50 50 -5 -0.5 -0.05]; % from me
Starting_Feng= [0;500;50;50;-5;-0.5;-0.05]; % for nlinfit
LB_Feng= [0; 0; 0; 0; -200; -50; -1]; % for nlinfit
UB_Feng= [1; 100000; 1000; 100; 0; 0; 0]; % for nlinfit
%Starting_Mono_expo=[1; 1];
%LB_Mono_expo=[0; 0];
%UB_Mono_expo=[100 10];
%Starting_Surge=[1;1;1];
%LB_Surge=[0; 0; 0];
%UB_Surge=[100; 10; 10];

% Setting the fitting process
%options = optimoptions('lsqcurvefit','Display', 'iter', 'FunctionTolerance', 1e-15, 'Algorithm','levenberg-marquardt','MaxFunctionEvaluations',1000000, 'MaxIterations', 1000000);
%[Estimates,fval,residual,d,e,f,jacob]=lsqcurvefit(@Feng, Starting_Feng, Post_Injection_Time_Min, Image_Derived_Data, Lower_Feng, Upper_Feng, options);
%[Estimates,SSE,residual,d,e,f,jacob]=lsqcurvefit(@Feng, Starting_Feng, Post_Injection_Time_Min, Image_Derived_Data, [], [], options);
%ft = fittype( 'Feng(x, tau, A_1, A_2, A_3, Lamda_1, Lamda_2, Lamda_3)' );
%[fitobject, gof, output]=fit(transpose(Post_Injection_Time_Min), Image_Derived_Data, ft, 'StartPoint', Starting_Feng);
%plot(fitobject, transpose(Post_Injection_Time_Min), Image_Derived_Data);
%[Estimates,residual,jacob,CovB,MSE,ErrorModelInfo] =nlinfit(Post_Injection_Time_Min, Image_Derived_Data, @Feng, Starting_Feng);
%Image_Derived_Data_Scaled=Image_Derived_Data_from_zero/max(Image_Derived_Data_from_zero)*100;
%problem=createOptimProblem('lsqcurvefit','objective',@Feng, 'x0', Starting_Feng, 'lb', LB_Feng,'ub', UB_Feng, 'xdata', Post_Injection_Time_Min,'ydata', Scaled_data, 'options', options);

% Global Optimization!
%Global_optim_problem=createOptimProblem('lsqcurvefit','objective',@Feng, 'x0', Starting_Feng, 'lb', LB_Feng,'ub', UB_Feng, 'xdata', transpose(Post_Injection_Time_Min_from_zero),'ydata', Image_Derived_Data_from_zero_kBq);
%Global_ms=MultiStart("PlotFcn", @gsplotbestf);
%global Global_Estimates; % globalization for the future usage!
%[Global_Estimates,Global_SSE]=run(Global_ms, Global_optim_problem, 50);

% Fitting using Feng's Model and Statistical Info. (e.g., Confidence Interval at 95% CL, Standard Error of estimated parameters)
global Local_Estimates;

[Local_Estimates,Local_SSE,Local_Residual,d,e,f,Local_Jacobian]=lsqcurvefit(@Feng, Starting_Feng, transpose(Post_Injection_Time_Min_from_zero), Image_Derived_Data_from_zero_kBq, LB_Feng, UB_Feng);
%[Local_Estimates,Local_SSE,Local_Residual,d,e,f,Local_Jacobian]=lsqcurvefit(@Mono_expo, Starting_Mono_expo, transpose(Post_Injection_Time_Min_from_zero), Image_Derived_Data_from_zero_kBq, LB_Mono_expo, UB_Mono_expo);
%[Local_Estimates,Local_SSE,Local_Residual,d,e,f,Local_Jacobian]=lsqcurvefit(@Surge, Starting_Surge, transpose(Post_Injection_Time_Min_from_zero), Image_Derived_Data_from_zero_kBq, LB_Surge, UB_Surge);


[Local_CI, Local_SE]=nlparci(Local_Estimates, Local_Residual, 'jacobian', Local_Jacobian);

% Fitting using Surge Model (just testing purpose!)
%Starting_Surge= [0;50;10]; % for nlinfit
%LB_Surge= [-10000; 0; 0]; % for nlinfit
%UB_Surge= [10000; 100; 100]; % for nlinfit
%[Local_Estimates,Local_SSE,Local_Residual,d,e,f,Local_Jacobian]=lsqcurvefit(@Surge, Starting_Surge, transpose(Post_Injection_Time_Min_from_zero), Image_Derived_Data_from_zero_kBq, LB_Surge, UB_Surge);
%[Local_CI, Local_SE]=nlparci(Local_Estimates, Local_Residual, 'jacobian', Local_Jacobian);
% Global Optimization!
%Global_optim_problem=createOptimProblem('lsqcurvefit','objective',@Surge, 'x0', Starting_Surge, 'lb', LB_Surge,'ub', UB_Surge, 'xdata',transpose(Post_Injection_Time_Min_from_zero),'ydata', Image_Derived_Data_from_zero_kBq);
%Global_ms=MultiStart("PlotFcn", @gsplotbestf);
%global Global_Estimates; % globalization for the future usage!
%[Global_Estimates,Global_SSE]=run(Global_ms, Global_optim_problem, 50);

%[Estimates, Residual, Jacobian, CovM, MSE, ErrorModeInfo]=nlinfit(transpose(Post_Injection_Time_Min_from_zero), Image_Derived_Data_from_zero_kBq, @Feng, Starting_Feng);
%[ci, se]=nlparci(Estimates, residual, 'jacobian', jacob);
%[ci, se]=nlparci(Estimates, Residual, 'jacobian', Jacobian);
%[ci, se]=nlparci(Estimates, Residual, 'Covar', CovM);

Fitted_X=transpose(Post_Injection_Time_Min_from_zero);
%Fitted_Y=Feng(Global_Estimates,transpose(Post_Injection_Time_Min_from_zero));
Fitted_Y=Feng(Local_Estimates,transpose(Post_Injection_Time_Min_from_zero));
%Fitted_Y=Mono_expo(Local_Estimates,transpose(Post_Injection_Time_Min_from_zero));
%Fitted_Y=Surge(Local_Estimates,transpose(Post_Injection_Time_Min_from_zero));

Plot_Fitted=[Fitted_X, Fitted_Y];
Plot_Measured=[Fitted_X, Image_Derived_Data_from_zero_kBq];

IDIF_X=[0:0.001:60]; % X data of the Image-Derived Input Function, Time Duration: 0~60 [min] 
                   % Be Careful!: this graph is too sharp, thus, you may not find the highest value of the IDIF, depending on the step size of X
%IDIF_Y=Feng(Global_Estimates,transpose(IDIF_X)); % Y data of the Image-Derived Input Function
IDIF_Y=Feng(Local_Estimates,transpose(IDIF_X)); % Y data of the Image-Derived Input Function
Plot_IDIF=[transpose(IDIF_X), IDIF_Y];

% Plotting Image-Derived IF
%p_IDIF=plot(PIF_X, PIF_Y, 'color', [1, 0, 0], 'LineStyle','-', 'Color', [1, 0, 0]);
%p_IDIF=fplot(@(x) Feng(Global_Estimates,x), [0 60], '-r');
%p_IDIF=fplot(@(x) Feng(Local_Estimates,x), [0 60], '-r');
%title('Imaged-Derived IF (by Feng Model)', 'FontSize', 15, 'FontWeight', 'bold');
%xlabel('Post-Injection Time [Min]', 'FontSize', 15, 'FontWeight', 'bold');
%ylabel('Mean Concentration [kBq/ml]', 'FontSize', 15, 'FontWeight', 'bold');
%xlim([0 60]); % setting the time range [min] for the IDIF
%ylim([0 150]); % setting the concetnration [kBq/ml] for the IDIF

plot(Fitted_X, Image_Derived_Data_from_zero_kBq,'r*', transpose(IDIF_X), IDIF_Y, 'b' );
title('Image-Derived IF (by Feng Eq.)', 'FontSize', 15, 'FontWeight', 'bold');
xlabel('Post-Injection Time [min]', 'FontSize', 15, 'FontWeight', 'bold');
ylabel('Mean Concentration [kBq/ml]', 'FontSize', 15, 'FontWeight', 'bold');
xlim([0 60]); % setting the time range [min] for the IDIF
ylim([0 150]); % setting the concetnration [kBq/ml] for the IDIF

clear Fitted_X Fitted_Y Image_Derived_Data Image_Derived_Data_from_zero_temp Image_Derived_Data_from_zero image_size index Injection_Time_Sec Injection_Time_String_HH Injection_Time_String_MM Injection_Time_String_SS i j LB_Feng Limit_X Limit_Y Limit_Z Limit_Z_temp Multiplied_matrix Num_files Num_of_Voxels_VOI Num_Times path PIF_X PIF_Y Post_Injection_Time_Min_from_zero_temp Post_Injection_Time_Sec reference_Info RT_S_Contour RT_S_file RT_S_file_path RT_S_index RT_S_path Starting_Feng Struct_Mask Struct_Mask_array temp temp_index_SL temp_ranked_index temp_ranked_SL temp_sort_time temp_times Times Tracer_Injection_Time_String_HH Tracer_Injection_Time_String_MM Tracer_Injection_Time_String_SS UB_Feng;
clear ms p;
clear Tracer_Injectin_Time_Sec files;
clear Image_Derived_Data_from_zero_kBq;
clear Post_Injection_Time_Min Post_Injection_Time_Min_from_zero Post_Injection_Time_from_zero;
clear Global_ms Global_optim_problem ;
clear Tracer_Injection_Time_Sec;
clear Vol_PET RT_S_Header;
clear Image_Acquisition_Time_Sec Image_Acquisition_Time_String_HH Image_Acquisition_Time_String_MM Image_Acquisition_Time_String_SS;
clear IDIF_X IDIF_Y;
clear Vol_Dynamic;
clear d e f;
clear Local_CI Local_Jacobian Local_Residual Local_SE;

%% 4. Estimation of kinetic parameters
% Importing Multiple WB data
tic;
[Num_Passes,Num_Beds,Vol_WB,Vol_Multi_WB,Raw_Data_Multi_WB,Times_Multi_WB,Num_Times_Multi_WB]=Import_Dynamic_DCM_Multiple();
toc; % 2.15 [min] for 16 Passes
% Testing
%volumeViewer(Vol_WB.Pass_1{1,1});
%volumeViewer(Vol_WB.Pass_2{1,1});

% Making 4D Arrays of WB_kBq [kBq/ml], PI_Time [min], C_tot_over_C_p, and Integ_C_t_over_C_p  
%tic;
%Make_4D_Array(Num_Passes,Num_Beds,Vol_WB,Vol_Multi_WB,Times_Multi_WB, Raw_Data_Multi_WB.Pass_1{1, 1}.RadiopharmaceuticalStartTime);
%toc; % 60 [min] for 16 Passes


%% 4.1. Generation of Parametric Volume through Fitting (with Patlak)
tic;
Starting_Patlak=[0.5;0.05]; % K_i:net influx rate (slope), V_d: volume of dist. (intercept)
LB_Patlak=[0;0]; % Lower Bound of the Kinetic Parameters (i.e., Rate Constants)
UB_Patlak=[1;1]; % Upper Bound of the Kinetic Parameters (i.e., Rate Constants)
Gen_Parametric_Vol_Patlak(Num_Passes, Num_Beds, Starting_Patlak, LB_Patlak, UB_Patlak); % approx. 0.0001 [sec] for a single fitting
toc; % 49 [min] for 16 Passes

load('K_i.mat');
load('V_d.mat');

volumeViewer(K_i); % to see the rendered volume
VolumeViewer3D(K_i); % to see the slices at each plane

%% 5. Saving the parametric volume into DCM files
Vol_to_DCM_Patlak(K_i,V_d, Raw_Data_Multi_WB);

