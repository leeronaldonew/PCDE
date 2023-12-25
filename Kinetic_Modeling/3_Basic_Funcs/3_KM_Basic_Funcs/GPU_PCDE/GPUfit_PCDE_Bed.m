function []=GPUfit_PCDE_Bed(Bed_4D, PI_Time_4D)



% Fittype: C-A*exp(-B*t)


%% using GPUfit
[x_gpu, y_gpu, initial_params, constraints]=Make_GPUfit_Input(PI_Time, kBq, Starting, LB, UB, 3); % for Fittype: C-A*exp(-B*t) index == 3

% GPUfit setting
estimator_id = EstimatorID.LSE;
model_id = ModelID.TTCM;
tolerance = 1e-9;
max_n_iterations = 1000;
constraint_types = int32([ConstraintType.LOWER_UPPER, ConstraintType.LOWER_UPPER, ConstraintType.LOWER_UPPER, ConstraintType.LOWER_UPPER]); % considering both lower & upper bounds

x_gpu_temp=zeros(1, Size_WB(4)*Size_WB(1)*Size_WB(2), 'single');
y_gpu_temp=zeros(Size_WB(4), Size_WB(1)*Size_WB(2), 'single');
initial_params_temp=zeros(size(Starting,1),Size_WB(1)*Size_WB(2), 'single');
constraints_temp=zeros(2*size(Starting,1),Size_WB(1)*Size_WB(2), 'single');

Num_inlier=single(repmat(Size_WB(4),1,size(y_gpu,2)));
inlierIdx=single(ones(Size_WB(4),size(y_gpu,2)));

f_waitbar = waitbar(0,'Please wait...', 'Name','Fitting with ');
for k=1:1:Size_WB(3) % fiitting slice by slice
    waitbar(k/Size_WB(3), f_waitbar, "Current Slice Index: " + num2str(k) + " / " + num2str(Size_WB(3)));

    i_start= ((k-1)*Size_WB(1)*Size_WB(2))+1; % initialization
    i_end= k*Size_WB(1)*Size_WB(2);
    i_start_x_gpu_temp=((k-1)*Size_WB(4)*Size_WB(1)*Size_WB(2))+1;
    i_end_x_gpu_temp=k*Size_WB(4)*Size_WB(1)*Size_WB(2);
    x_gpu_temp=x_gpu(1, i_start_x_gpu_temp:i_end_x_gpu_temp);
    y_gpu_temp=y_gpu(:,i_start:i_end);
    initial_params_temp=initial_params(:,i_start:i_end);
    constraints_temp=constraints(:,i_start:i_end);
    %tic;
    [parameters, states, chi_squares, n_iterations, time]...
        = gpufit_constrained(y_gpu_temp, [], model_id, initial_params_temp, constraints_temp, constraint_types, tolerance, max_n_iterations, [], estimator_id, x_gpu_temp);
    %fprintf('Fitted parameters = [%.2f, %.2f, %.2f, %.2f], SSE = %.2f \n', parameters, chi_squares);
    %toc;

    % Calc. of RE[%] from Jacobian(through calc. of Covariance Matrix)
    J_slice=Get_Jacobian(parameters,x_gpu_temp,Num_Passes,2); % 2TCM: model index=2
    [RE_slice, se_slice]=Get_RE(J_slice, parameters, chi_squares, Num_Passes,Num_inlier,inlierIdx,2); % 2TCM: model index=2
    if k==1
        parameters_update=parameters;
        RE_update=RE_slice;
    else
        parameters_update=cat(2, parameters_update, parameters);
        RE_update=cat(2, RE_update, RE_slice);
    end
end
close(f_waitbar);













end