function [Exp_params_4D]=GPUfit_Exp(Time_4D,kBq_4D)    

    %% Fittype: C-A*exp(-B*t)

    %% 1. GPU fit
    %t1=clock;
    Starting=[0;0;0]; % A;B;C ==> This Strarting point is not meaningful b/c starting points will be determined by Slope of TAC. Please refer to the "Make_GPUfit_Input" function.
    LB=[-10000;-10000;-10000];
    UB=[10000,10000,10000];
    [x_gpu, y_gpu, initial_params, constraints]=Make_GPUfit_Input(Time_4D, kBq_4D, Starting, LB, UB, 3); % for C-A*exp(-B*t) index == 3

    % GPUfit setting
    estimator_id = EstimatorID.LSE;
    model_id = ModelID.EXP;
    tolerance = 1e-9;
    max_n_iterations = 1000;
    constraint_types = int32([ConstraintType.LOWER_UPPER, ConstraintType.LOWER_UPPER, ConstraintType.LOWER_UPPER, ConstraintType.LOWER_UPPER]); % considering both lower & upper bounds

    Size_WB=size(kBq_4D);

    x_gpu_temp=zeros(1, Size_WB(4)*Size_WB(1)*Size_WB(2), 'single');
    y_gpu_temp=zeros(Size_WB(4), Size_WB(1)*Size_WB(2), 'single');
    initial_params_temp=zeros(size(Starting,1),Size_WB(1)*Size_WB(2), 'single');
    constraints_temp=zeros(2*size(Starting,1),Size_WB(1)*Size_WB(2), 'single');

    Num_inlier=single(repmat(Size_WB(4),1,size(y_gpu,2)));
    inlierIdx=single(ones(Size_WB(4),size(y_gpu,2)));

    f_waitbar = waitbar(0,'Please wait...', 'Name','Fitting with C-A*exp(-B*t)');
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

        if y_gpu_temp==0
            parameters=zeros(3,Size_WB(1)*Size_WB(2),'single');
        else
            [parameters, states, chi_squares, n_iterations, time]...
                = gpufit_constrained(y_gpu_temp, [], model_id, initial_params_temp, constraints_temp, constraint_types, tolerance, max_n_iterations, [], estimator_id, x_gpu_temp);
        end

        if k==1
            parameters_update=parameters;
        else
            parameters_update=cat(2, parameters_update, parameters);
        end
    end
    close(f_waitbar);
    %t2=clock;
    %etime(t2,t1)


    %% Making Exp_params_4D
    Exp_params_4D=zeros(Size_WB(1),Size_WB(2),Size_WB(3),3, 'single');
    for i=1:1:3
        Exp_params_4D(:,:,:,i)=reshape(parameters_update(i,:), Size_WB(1),Size_WB(2),Size_WB(3)); % 4D array
    end