function [Local_Estimates, Global_SSE, Plot_Measured, Plot_Fitted, Plot_IDIF]=Gen_IDIF(LV_kBq,LV_PI_Time_Min,Decay_ind,lamda)
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
%plotContour(RT_S_Contour); % just for checking whether the extracting is proceeded well or not 
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
    Image_Acquisition_Time_String_HH{1,i}=num2str(Times(1,i),'%06.f');
    Image_Acquisition_Time_String_HH{1,i}(3:6)=[];
end
for i=1:1:size(Times, 2)
    Image_Acquisition_Time_String_MM{1,i}=num2str(Times(1,i),'%06.f');
    Image_Acquisition_Time_String_MM{1,i}(1:2)=[];
    Image_Acquisition_Time_String_MM{1,i}(3:4)=[];
end
for i=1:1:size(Times, 2)
    Image_Acquisition_Time_String_SS{1,i}=num2str(Times(1,i),'%06.f');
    Image_Acquisition_Time_String_SS{1,i}(1:2)=[];
    Image_Acquisition_Time_String_SS{1,i}(1:2)=[];
end
for i=1:1:size(Times,2)
    Image_Acquisition_Time_Sec(1,i)= (str2num(Image_Acquisition_Time_String_HH{1,i})*3600.00) + (str2num(Image_Acquisition_Time_String_MM{1,i})*60.00) + str2num(Image_Acquisition_Time_String_SS{1,i}) ;
end
% for Radiopharmaceutical injection time (under the assumption that the time is given with the form like this, '120200.00', 6 digits with 2 decimal points)
for i=1:1:size(Times, 2)
    %Tracer_Injection_Time_String_HH{1,i}=temp{1, 1}.RadiopharmaceuticalStartTime;
    Tracer_Injection_Time_String_HH{1,i}=temp{1, 1}.RadiopharmaceuticalInformationSequence.Item_1.RadiopharmaceuticalStartTime;
    Tracer_Injection_Time_String_HH{1,i}(7:9)=[];
    Tracer_Injection_Time_String_HH{1,i}(3:6)=[];
end
for i=1:1:size(Times, 2)
    %Tracer_Injection_Time_String_MM{1,i}=temp{1, 1}.RadiopharmaceuticalStartTime;
    Tracer_Injection_Time_String_MM{1,i}=temp{1, 1}.RadiopharmaceuticalInformationSequence.Item_1.RadiopharmaceuticalStartTime;
    Tracer_Injection_Time_String_MM{1,i}(7:9)=[];
    Tracer_Injection_Time_String_MM{1,i}(1:2)=[];
    Tracer_Injection_Time_String_MM{1,i}(3:4)=[];
end
for i=1:1:size(Times, 2)
    %Tracer_Injection_Time_String_SS{1,i}=temp{1, 1}.RadiopharmaceuticalStartTime;
    Tracer_Injection_Time_String_SS{1,i}=temp{1, 1}.RadiopharmaceuticalInformationSequence.Item_1.RadiopharmaceuticalStartTime;
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
%Post_Injection_Time_Min_from_zero=[0.0, transpose(nonzeros(Post_Injection_Time_Min_from_zero_temp))];
%Image_Derived_Data_from_zero=[0.0; nonzeros(Image_Derived_Data_from_zero_temp)];
Post_Injection_Time_Min_from_zero=Post_Injection_Time_Min_from_zero_temp;
Image_Derived_Data_from_zero=Image_Derived_Data_from_zero_temp;

% Converting [Bq/ml] to [kBq/ml] and plotting
Image_Derived_Data_from_zero_kBq=0.001.*Image_Derived_Data_from_zero;



%% Catenation of LV data from WB and Heart
LV_X=[Post_Injection_Time_Min_from_zero, LV_PI_Time_Min]; % PI Time [min]
LV_Y=[Image_Derived_Data_from_zero_kBq;LV_kBq]; % Mean Concentration  of LV [kBq/ml]


%% Decay Correction
if Decay_ind ==1
    LV_Cor_X=LV_X;
    for i=1:1:size(LV_X,2)
        LV_Cor_Y(i,1)=LV_Y(i,1)*exp(lamda*LV_X(i));
    end
else
    LV_Cor_X=LV_X;
    LV_Cor_Y=LV_Y;
end

%% 3. Generating Image-Derived Input Function (Using Feng's Model)
% Initial parameter values for the fitting [Tau, A_1, A_2, A_3, Lamda_1, Lamda_2, Lamda_3]
%Starting_Feng= [0.905 767.3 27.43 29.13 -4.195 -0.232 -0.0165]; % referenced from Feng's paper (Avg. value from Table 2 for Model #2)
%Starting_Feng= [0 500 50 50 -5 -0.5 -0.05]; % from me
%Starting_Feng= [0;500;50;50;-5;-0.5;-0.05]; % for nlinfit
%LB_Feng= [0; 0; 0; 0; -200; -50; -1]; % for nlinfit
%UB_Feng= [1; 100000; 1000; 100; 0; 0; 0]; % for nlinfit
%Starting_Mono_expo=[1; 1];
%LB_Mono_expo=[0; 0];
%UB_Mono_expo=[100 10];
%Starting_Surge=[1;1;1];
%LB_Surge=[0; 0; 0];
%UB_Surge=[100; 10; 10];

% Global Optimization!
%Global_optim_problem=createOptimProblem('lsqcurvefit','objective',@Exp_4, 'x0', Starting_Feng, 'lb', LB_Feng,'ub', UB_Feng, 'xdata', transpose(Post_Injection_Time_Min_from_zero),'ydata', Image_Derived_Data_from_zero_kBq);

% Original
%Global_optim_problem=createOptimProblem('lsqcurvefit','objective',@Exp_4, 'x0', [1;1;1;1;1;1;1;1], 'lb', [-1000;-1000;-1000;-1000;-1000;-1000;-1000;-1000],'ub', [1000;1000;1000;1000;1000;1000;1000;1000], 'xdata', transpose(LV_Cor_X),'ydata', LV_Cor_Y);
% Updated for Universality
Global_optim_problem=createOptimProblem('lsqcurvefit','objective',@Exp_4, 'x0', [25;5;25;5;25;5;25;5], 'lb', [-5;0;-5;0;-5;0;-5;0],'ub', [50;50;50;50;50;50;50;50], 'xdata', transpose(LV_Cor_X),'ydata', LV_Cor_Y);

%Global_optim_problem=createOptimProblem('lsqcurvefit','objective',@Exp_4,'x0', [1;1;1;1;1;1;1;1],'xdata', transpose(Post_Injection_Time_Min_from_zero),'ydata', Image_Derived_Data_from_zero_kBq);
%Global_ms=MultiStart("PlotFcn", @gsplotbestf, 'UseParallel', true, 'StartPointsToRun', 'bounds');
Global_ms=MultiStart("PlotFcn", @gsplotbestf);
%global Global_Estimates; % globalization for the future usage!
[Local_Estimates,Global_SSE]=run(Global_ms, Global_optim_problem, 1000);

% Fitting using Feng's Model and Statistical Info. (e.g., Confidence Interval at 95% CL, Standard Error of estimated parameters)
%global Local_Estimates;
%options = optimoptions(@lsqcurvefit,'Algorithm','levenberg-marquardt');
%[Local_Estimates,Local_SSE,Local_Residual,d,e,f,Local_Jacobian]=lsqcurvefit(@Feng, Starting_Feng, transpose(Post_Injection_Time_Min_from_zero), Image_Derived_Data_from_zero_kBq, LB_Feng, UB_Feng);
%[Local_Estimates,Local_SSE,Local_Residual,d,e,f,Local_Jacobian]=lsqcurvefit(@Mono_expo, Starting_Mono_expo, transpose(Post_Injection_Time_Min_from_zero), Image_Derived_Data_from_zero_kBq, LB_Mono_expo, UB_Mono_expo);
%[Local_Estimates,Local_SSE,Local_Residual,d,e,f,Local_Jacobian]=lsqcurvefit(@Surge, Starting_Surge, transpose(Post_Injection_Time_Min_from_zero), Image_Derived_Data_from_zero_kBq, LB_Surge, UB_Surge);

% Original
%[Local_Estimates,Local_SSE,Local_Residual,d,e,f,Local_Jacobian]=lsqcurvefit(@Exp_4, Global_Estimates, transpose(LV_Cor_X), LV_Cor_Y, [-1000;-1000;-1000;-1000;-1000;-1000;-1000;-1000], [1000;1000;1000;1000;1000;1000;1000;1000]);
% Updated for Universality
%[Local_Estimates,Local_SSE,Local_Residual,d,e,f,Local_Jacobian]=lsqcurvefit(@Exp_4, Global_Estimates, transpose(LV_Cor_X), LV_Cor_Y,  [-5;0;-5;0;-5;0;-5;0], [50;50;50;50;50;50;50;50]);

%[Local_CI, Local_SE]=nlparci(Local_Estimates, Local_Residual, 'jacobian', Local_Jacobian);

%[Estimates, Residual, Jacobian, CovM, MSE, ErrorModeInfo]=nlinfit(transpose(Post_Injection_Time_Min_from_zero), Image_Derived_Data_from_zero_kBq, @Feng, Starting_Feng);
%[ci, se]=nlparci(Estimates, residual, 'jacobian', jacob);
%[ci, se]=nlparci(Estimates, Residual, 'jacobian', Jacobian);
%[ci, se]=nlparci(Estimates, Residual, 'Covar', CovM);

Fitted_X=transpose(LV_Cor_X);
%Fitted_Y=Feng(Global_Estimates,transpose(Post_Injection_Time_Min_from_zero));
%Fitted_Y=Feng(Local_Estimates,transpose(Post_Injection_Time_Min_from_zero));
%Fitted_Y=Mono_expo(Local_Estimates,transpose(Post_Injection_Time_Min_from_zero));
%Fitted_Y=Surge(Local_Estimates,transpose(Post_Injection_Time_Min_from_zero));
Fitted_Y=Exp_4(Local_Estimates,transpose(LV_Cor_X));

Plot_Fitted=[Fitted_X, Fitted_Y];
Plot_Measured=[Fitted_X, LV_Cor_Y];

IDIF_X=[0:0.1:90]; % X data of the Image-Derived Input Function, Time Duration: 0~60 [min] 
                   % Be Careful!: this graph is too sharp, thus, you may not find the highest value of the IDIF, depending on the step size of X
%IDIF_Y=Feng(Global_Estimates,transpose(IDIF_X)); % Y data of the Image-Derived Input Function
%IDIF_Y=Feng(Local_Estimates,transpose(IDIF_X)); % Y data of the Image-Derived Input Function
IDIF_Y=Exp_4(Local_Estimates,transpose(IDIF_X));
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

plot(LV_Cor_X', LV_Cor_Y,'r*', IDIF_X', IDIF_Y, 'b' );

title('Image-Derived IF (by Exp4.)', 'FontSize', 15, 'FontWeight', 'bold');
xlabel('PI Time [min]', 'FontSize', 15, 'FontWeight', 'bold');
ylabel('Mean Concentration [kBq/ml]', 'FontSize', 15, 'FontWeight', 'bold');
xlim([0 90]); % setting the time range [min] for the IDIF
ylim([0 150]); % setting the concetnration [kBq/ml] for the IDIF

set(gcf, 'Position', get(0, 'Screensize')); % To make a full-screen figure
saveas(gcf,'IDIF.jpg');

Local_Estimates=single(Local_Estimates);
save("Local_Estimates.mat", "Local_Estimates");
end