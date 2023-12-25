function Gen_Parametric_Vol_Patlak(Num_Passes, Num_Beds, Starting, LB, UB)
%t1=clock;
% Loading the necessary data
%load('kBq.mat');
%load('PI_Time.mat');

load('C_tot_over_C_p.mat');
load('Integ_C_p_over_C_p.mat');

%load('C_tot_over_C_p_half.mat');
%load('Integ_C_p_over_C_p_half.mat');

%load('C_tot_over_C_p_128.mat');
%load('Integ_C_p_over_C_p_128.mat');

Size_WB=size(C_tot_over_C_p);
%Size_WB=[10,10,10,16];

% initialization
%X_data=zeros(Num_Passes,1);
%Y_data=zeros(Num_Passes,1);
%K_i=zeros(Size_WB(1),Size_WB(2),Size_WB(3));
%V_d=zeros(Size_WB(1),Size_WB(2),Size_WB(3));
%SE_K_i=zeros(Size_WB(1),Size_WB(2),Size_WB(3));
%SE_V_d=zeros(Size_WB(1),Size_WB(2),Size_WB(3));

%f_waitbar = waitbar(0,'Please wait...', 'Name','Fitting with Patlak Model');

%for k=1:1:Size_WB(3)
%    waitbar(k/Size_WB(3), f_waitbar, "Current Slice Index: " + num2str(k) + " / " + num2str(Size_WB(3)));
%    for j=1:1:Size_WB(2)
%        for i=1:1:Size_WB(1)
%            for p=1:1:Num_Passes
%                X_data(p)=Integ_C_p_over_C_p(i,j,k,p);
%                Y_data(p)=C_tot_over_C_p(i,j,k,p);
%            end
%            if all(X_data(:) == 0)
%                X_data=zeros(Num_Passes,1)+0.0000001; % to avoid error
%            end
%            if all(Y_data(:) == 0)
%                Y_data=zeros(Num_Passes,1)+0.0000001; % to avoid error
%            end
            %% using polyfitn
%            tic;
%            p_n=polyfitn(X_data, Y_data, 1);
%            toc;
%            K_i(i,j,k)=p_n.Coefficients(1); % for K_i
%            V_d(i,j,k)=p_n.Coefficients(2); % for V_d
%            SE_K_i(i,j,k)= ( p_n.ParameterStd(1) ) / ( p_n.Coefficients(1) )  * 100; % for SE of K_i [% Relative Error]
%            SE_V_d(i,j,k)= ( p_n.ParameterStd(2) ) / ( p_n.Coefficients(2) )  * 100; % for SE of V_d [% Relative Error] 
%            % using anonymous function with lsqcurvefit
%            %% using polyfit
%            %p=polyfit(X_data, Y_data, 1);
%            %K_i(i,j,k)=p(1);
%            %V_d(i,j,k)=p(2);
%            %% using anonymous function with lsqcurvefit (i.e., Linear_Fit)
%            [Estimates,SSE,Residual,d,e,f,Jacobian]=lsqcurvefit(@Linear_Fit, Starting, double(X_data), transpose(Y_data) , LB, UB);
%            [ci, se]=nlparci(Estimates,Residual, 'jacobian', Jacobian);
%            K_i(i,j,k)=Estimates(1);
%            V_d(i,j,k)=Estimates(2);
%            SE_K_i(i,j,k)=  se(1) / Estimates(1) *100;
%            SE_V_d(i,j,k)=  se(2) / Estimates(2) *100;
%        end
%    end
%end

%t2=clock;
%etime(t2,t1)/1000
%% Generation of GPUfit inputs
[x_gpu, y_gpu, initial_params, constraints]=Make_GPUfit_Input(Integ_C_p_over_C_p, C_tot_over_C_p, Starting, LB, UB, 1); % for patlak model index == 1
%% Getting WB Mask
%[WB_mask, WB_mask_vector]=Get_WB_mask();
%% Converting the original GPUfit input into the GPUfit input of VOI using WB Mask
%[x_gpu, y_gpu, initial_params, constraints]=Conv_GPUfit_Input(x_gpu, y_gpu, initial_params, constraints,WB_mask_vector,Num_Passes,Size_WB);

%% Using GPUfit
% GPUfit setting
estimator_id = EstimatorID.LSE;
model_id = ModelID.LINEAR_1D;
%tolerance = 1e-9;
tolerance = 1e-6;
max_n_iterations = 1000;
constraint_types = int32([ConstraintType.LOWER_UPPER, ConstraintType.LOWER_UPPER]); % considering both lower & upper bounds

x_gpu_temp=zeros(1, Size_WB(4)*Size_WB(1)*Size_WB(2), 'single');
y_gpu_temp=zeros(Size_WB(4), Size_WB(1)*Size_WB(2), 'single');
initial_params_temp=zeros(size(Starting,1),Size_WB(1)*Size_WB(2), 'single');
constraints_temp=zeros(2*size(Starting,1),Size_WB(1)*Size_WB(2), 'single');

Num_inlier=single(repmat(Size_WB(4),1,size(y_gpu,2)));
inlierIdx=single(ones(Size_WB(4),size(y_gpu,2)));

f_waitbar = waitbar(0,'Please wait...', 'Name','Fitting with Patlak');
for k=1:1:Size_WB(3) % fiitting slice by slice
    tic;
    waitbar(k/Size_WB(3), f_waitbar, "Current Slice Index: " + num2str(k) + " / " + num2str(Size_WB(3)));

    i_start= ((k-1)*Size_WB(1)*Size_WB(2))+1; % initialization
    i_end= k*Size_WB(1)*Size_WB(2);
    i_start_x_gpu_temp=((k-1)*Size_WB(4)*Size_WB(1)*Size_WB(2))+1;
    i_end_x_gpu_temp=k*Size_WB(4)*Size_WB(1)*Size_WB(2);
    x_gpu_temp=x_gpu(1, i_start_x_gpu_temp:i_end_x_gpu_temp);
    y_gpu_temp=y_gpu(:,i_start:i_end);
    initial_params_temp=initial_params(:,i_start:i_end);
    constraints_temp=constraints(:,i_start:i_end);

    if y_gpu_temp==0
        parameters=zeros(2,Size_WB(1)*Size_WB(2),'single');
        chi_squares=zeros(1,Size_WB(1)*Size_WB(2),'single');
        RE_slice=zeros(2,Size_WB(1)*Size_WB(2),'single');
    else
        [parameters, states, chi_squares, n_iterations, time]...
            = gpufit_constrained(y_gpu_temp, [], model_id, initial_params_temp, constraints_temp, constraint_types, tolerance, max_n_iterations, [], estimator_id, x_gpu_temp);
        % Calc. of RE[%] from Jacobian(through calc. of Covariance Matrix)
        J_slice=Get_Jacobian(parameters,x_gpu_temp,Num_Passes,1); % for Patlak: model index=1
        [RE_slice, se_slice]=Get_RE(J_slice, parameters, chi_squares, Num_Passes,Num_inlier,inlierIdx,1); % for Patlak: model index=1
    end

    if k==1
        parameters_update=parameters;
        chi_squares_update=chi_squares;
        RE_update=RE_slice;
    else
        parameters_update=cat(2, parameters_update, parameters);
        chi_squares_update=cat(2,chi_squares_update, chi_squares);
        RE_update=cat(2, RE_update, RE_slice);
    end 
    toc;
end
close(f_waitbar);

K_i=reshape(parameters_update(2,:),Size_WB(1),Size_WB(2),Size_WB(3));
V_d=reshape(parameters_update(1,:),Size_WB(1),Size_WB(2),Size_WB(3));
K_i_RE=reshape(RE_update(2,:), Size_WB(1),Size_WB(2),Size_WB(3));
V_d_RE=reshape(RE_update(1,:), Size_WB(1),Size_WB(2),Size_WB(3));

%Masking (K_i: > 0.001, V_d: > 0.1)
% Settings
%Thre_K_i = 0;
%Thre_V_d = 0;
%K_i_mask= K_i > Thre_K_i;
%V_d_mask= V_d > Thre_V_d;
%K_i=K_i.*K_i_mask;
%K_i_RE=K_i_RE.*K_i_mask;
%V_d=V_d.*V_d_mask;
%V_d_RE=V_d_RE.*V_d_mask;

%% Comparison study of RE[%] between lsqcurvefit & GPU_manual_calc ==> Same Results !
%x_data_test=single([1:1:16]);
%y_data_test=single(transpose([1.5, 2.5, 3.4, 4.5, 5.6, 6.7,7.5, 8.1, 9.9, 10.9, 11.2, 12.6, 13.7, 14.6, 15.8, 16.9]));
%initial_params_test=single([0;0]);
%constraints_test=single([0;10;0;1000]);
%[parameters_gpu, states, SSE_gpu, n_iterations, time]...
%        = gpufit_constrained(y_data_test, [], model_id, initial_params_test, constraints_test, constraint_types, tolerance, max_n_iterations, [], estimator_id, x_data_test);
%fprintf('Fitted parameters = [%.2f, %.2f], SSE = %.2f \n', parameters_gpu, SSE_gpu);
%J_gpu=Get_Jacobian(parameters_gpu,x_data_test,Num_Passes,1); % for Patlak: model index=1
%RE_gpu=Get_RE(J_gpu, parameters_gpu, SSE_gpu, Num_Passes,1); % for Patlak: model index=1
%x_data_test=double(transpose(x_data_test));
%y_data_test=double(y_data_test);
%[parameters_cpu,SSE_cpu,residual,exitflag,output,lambda,J_cpu] = lsqcurvefit(@Linear_Fit,[0,0],x_data_test,y_data_test);
%[ci, se_cpu] = nlparci(parameters_cpu,residual,'jacobian',J_cpu);
%RE_cpu=  se_cpu ./ (transpose(parameters_cpu)) *100;
%RE_cpu=flip(RE_cpu);
%% Converting voxel values located outside of WB Mask into zeros
%parameters_update=parameters_update.*repmat(WB_mask_vector,2,1); % for parameters
%RE_update=RE_update.*repmat(WB_mask_vector,2,1); % for RE
%% Finding Voxels that have high RE [%] above the criterion (e.g., 10 %)
%RE_criterion=50;
%Voxel_intercept_logical= RE_update(1,:) > RE_criterion;
%Voxel_slope_logical= RE_update(2,:) > RE_criterion;
%[row,Voxel_index_intercept,value]=find(Voxel_intercept_logical);
%[row,Voxel_index_slope,value]=find(Voxel_slope_logical);
%Voxel_index_intercept=single(Voxel_index_intercept);
%Voxel_index_slope=single(Voxel_index_slope);
%Voxel_index=sort(cat(2,Voxel_index_intercept,Voxel_index_slope)); % voxels that have high RE above the criterion
%% Implementation of Global Search
%t1=clock;
%[K_i_New,V_d_New,K_i_RE_New,V_d_RE_New,REhist_K_i_before,REhist_K_i_after,REhist_V_d_before,REhist_V_d_after]=Perform_GlobalS(K_i, V_d, K_i_RE, V_d_RE, x_gpu, y_gpu,constraints);
%t2=clock;
%etime(t2,t1)/60 % elapsed time [min] 
% 46 [min] for New_Num_Fit=37332 with Nstarts=100 (K_1 > 0.01, V_d >5, RE > 100 %)
%% Implementation of Ransac
%t1=clock;
%[K_i_New,V_d_New,K_i_RE_New,V_d_RE_New,REhist_K_i_before,REhist_K_i_after,REhist_V_d_before,REhist_V_d_after,Parahist_K_i_before,Parahist_K_i_after,Parahist_V_d_before,Parahist_V_d_after]=Perform_Ransac_Patlak(K_i, V_d, K_i_RE, V_d_RE, x_gpu, y_gpu,constraints);
%t2=clock;
%etime(t2,t1)/60 % elapsed time [min]
% 22 [min] for maxd=10 (K_1 > 0.01, V_d >5, RE > 10 %)

%% saving outputs
save("K_i.mat",'K_i');
save("V_d.mat",'V_d');
%save("K_i_RE.mat",'K_i_RE');
%save("V_d_RE.mat",'V_d_RE');

%save("REhist_K_i_before.mat",'REhist_K_i_before');
%save("REhist_K_i_after.mat",'REhist_K_i_after');
%save("REhist_V_d_before.mat",'REhist_V_d_before');
%save("REhist_V_d_after.mat",'REhist_V_d_after');

%save("Parahist_K_i_before.mat",'Parahist_K_i_before');
%save("Parahist_K_i_after.mat",'Parahist_K_i_after');
%save("Parahist_V_d_before.mat",'Parahist_V_d_before');
%save("Parahist_V_d_after.mat",'Parahist_V_d_after');

%save("K_i_New.mat",'K_i_New');
%save("V_d_New.mat",'V_d_New');
%save("K_i_RE_New.mat",'K_i_RE_New');
%save("V_d_RE_New.mat",'V_d_RE_New');

%save("chi_squares.mat", 'chi_squares_update');
%save("RE_update.mat", 'RE_update');

end