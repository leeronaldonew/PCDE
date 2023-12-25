function [Bed_Vol_4D, params_300_4D, Exp_params_4D]=Accelerated_PCDE(permutes,Vol_Multi_WB,PI_Times_PCDE, Num_Passes, Num_Beds, Denoising_Ind)


%% Accelerated PCDE code to reduce the comp. time (~8 hr/bed ==> 2 days/patient (with 6 beds) )

for b=1:1:Num_Beds
    Bed_ind=b;
    %PI_Time=transpose(PI_Times_PCDE(:,b));
    %PI_Time_fine=[min(PI_Time):1:max(PI_Time)];

    t1=clock; % Making a 4D Volumes (Ct [kBq/ml], PI_Time [min])
    [Bed_Vol_4D,Bed_PI_Time_Vol_4D,PI_Times_Bed]=pre_Acc_PCDE(Vol_Multi_WB,PI_Times_PCDE, Num_Passes, Num_Beds, Bed_ind, Denoising_Ind);
    t2=clock;
    elapse_Pre=etime(t2,t1)/60/60 % Elapsed time [hr] ==> ~30 [min]
    save("Etime_Pre.mat",'elapse_Pre');

    %Bed_Vol_4D=double(Bed_Vol_4D);
    dims=size(Bed_Vol_4D);
    Num_Vox=dims(1);
    
    t1=clock; % Making necessary inputs for Acceleration
    [Gpu_Input_Bed,true_db_sub]=Gen_Input_Acc_PCDE(Bed_Vol_4D,PI_Times_Bed);
    t2=clock;
    elapse_Gen=etime(t2,t1)/60/60 % Elapsed time [hr] ==> ~1 [min]
    save("Etime_Gen.mat",'elapse_Gen');

    t1=clock; % Selecting top 300 parameter list
    [params_300_4D]=Acc_PCDE(Gpu_Input_Bed,PI_Times_Bed,true_db_sub,dims);
    t2=clock;
    elapse_Acc=etime(t2,t1)/60/60 % Elapsed time [hr]
    save("Etime_Acc.mat",'elapse_Acc');
    
    
    
    %chosen_params=zeros(dims(1),dims(2),dims(3),4, 'single'); % 4: for 2TCM

%    for row_ind=1:1:size(params_ind_update,3)
%        for v=1:1:Num_Vox         
%            i=v;
%            k=ceil(row_ind/dims(2));
%            j=row_ind-(dims(2)*(k-1));
%            sort_ind=transpose(params_ind_update(v,:,row_ind));
%            Meas_Cts_temp=transpose(squeeze(Bed_Vol_4D(i,j,k,:))); % already de-noised if Denoising_Ind==1
%            tic;
%            if Meas_Cts_temp==0
%                chosen_params(i,j,k,:)=[0,0,0,0];
%            else
%                [ind_min]=Similarity_Measure2(permutes, sort_ind, Meas_Cts_temp, PI_Time_temp, PI_Time_fine_temp);
%                chosen_params(i,j,k,:)=permutes(ind_min,:);
%            end
%            toc;
%        end 
%    end

%    if b==1
%        chosen_params_WB=chosen_params;
%    else
%        chosen_params_WB=cat(3, chosen_params_WB,chosen_params);
%    end

    %% 1. GPU fit
    t1=clock;
    Starting=[0;0;0]; % A;B;C
    LB=[-10000;-10000;-10000];
    UB=[10000,10000,10000];
    [x_gpu, y_gpu, initial_params, constraints]=Make_GPUfit_Input(Bed_PI_Time_Vol_4D, Bed_Vol_4D, Starting, LB, UB, 3); % for C-A*exp(-B*t) index == 3

    % GPUfit setting
    estimator_id = EstimatorID.LSE;
    model_id = ModelID.EXP;
    tolerance = 1e-9;
    max_n_iterations = 1000;
    constraint_types = int32([ConstraintType.LOWER_UPPER, ConstraintType.LOWER_UPPER, ConstraintType.LOWER_UPPER, ConstraintType.LOWER_UPPER]); % considering both lower & upper bounds

    Size_WB=size(Bed_Vol_4D);
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
        %tic;
        [parameters, states, chi_squares, n_iterations, time]...
            = gpufit_constrained(y_gpu_temp, [], model_id, initial_params_temp, constraints_temp, constraint_types, tolerance, max_n_iterations, [], estimator_id, x_gpu_temp);
        %fprintf('Fitted parameters = [%.2f, %.2f, %.2f, %.2f], SSE = %.2f \n', parameters, chi_squares);
        %toc;

        % Calc. of RE[%] from Jacobian(through calc. of Covariance Matrix)
        %J_slice=Get_Jacobian(parameters,x_gpu_temp,Num_Passes,2); % 2TCM: model index=2
        %[RE_slice, se_slice]=Get_RE(J_slice, parameters, chi_squares, Num_Passes,Num_inlier,inlierIdx,2); % 2TCM: model index=2
        if k==1
            parameters_update=parameters;
            %RE_update=RE_slice;
        else
            parameters_update=cat(2, parameters_update, parameters);
            %RE_update=cat(2, RE_update, RE_slice);
        end
    end
    close(f_waitbar);
    t2=clock;
    etime(t2,t1)


    %% Making Exp_params_4D
    Exp_params_4D=zeros(dims(1),dims(2),dims(3),3, 'single');
    for i=1:1:3
        Exp_params_4D(:,:,:,i)=reshape(parameters_update(i,:), dims(1),dims(2),dims(3)); % 4D array
    end
   
    
    











   % Accelerated Version (selecting a top 10 list by AUC)
   %Num_Rows=size(params_ind_update,3);
   %Num_Vox=size(params_ind_update,1);
   %Num_param_list=size(params_ind_update,2);
   %Num_Times=size(PI_Time_fine,2);

   % making GPU input (per Slice)
   %k=40;
   %for j=1:1:dims(2)
   %    for i=1:1:dims(1)
   %        params_300_Slice(:,i+(j-1)*dims(2))=params_300_4D(i,j,k,:);
   %    end
   %end
   %tic;
   %Ct_DB_Slice=zeros(300,Num_Times,dims(1)*dims(2),'single');
   %for v=1:1:dims(1)*dims(2)
   %    if params_300_Slice(:,v)==0
   %         Ct_DB_Slice(:,:,v)=zeros(300,size(PI_Time_fine,2),'single');
   %    else
   %         Ct_DB_Slice(:,:,v)=TTCM_analytic_Multi(permutes(params_300_Slice(:,v),:),PI_Time_fine); % using TTCM_analytic
   %    end
   %end
   %for j=1:1:dims(2)
   %    for i=1:1:dims(1)
   %        Fitted_Meas_Slice(:,i+(j-1)*dims(2))=transpose(Exp_New(transpose(squeeze(Exp_params_4D(i,j,k,:))),PI_Time_fine));
   %    end
   %end
   %[params_10_AUC]=Rank_AUC_Multi(Ct_DB_Slice,Fitted_Meas_Slice,params_300_Slice); % a top 10 list for a Slice
 

    %% 3. Ranking Physical Features

    %% 4. Eanking Statistical Feature

    %% 5. Calc. of Total Score & Ranking









    %% Selecting 1 Optimal Parameter
    for i=1:1:size(Bed_Vol_4D,1)
        for j=1:1:size(Bed_Vol_4D,2)
            for k=1:1:size(Bed_Vol_4D,3)
               tic;
               sort_ind=transpose(params_ind_update(i,:,j+((k-1)*dims(2)))); 
               if sort_ind==0
                  chosen_params(i,j,k,:)=[0,0,0,0];
               else
                  Meas_Cts_temp=transpose(squeeze(Bed_Vol_4D(i,j,k,:)));

                  %[ind_min]=Similarity_Measure2(permutes, sort_ind, Meas_Cts_temp, PI_Time_temp, PI_Time_fine_temp);
                  
                  [ind_min]=Acc_Similarity_Measure2(permutes, sort_ind, Meas_Cts_temp, PI_Time_temp, PI_Time_fine_temp);
                  
                  chosen_params(i,j,k,:)=permutes(ind_min,:);
               end
               toc;
            end
        end
    end

    if b==1
        chosen_params_WB=chosen_params;
    else
        chosen_params_WB=cat(3, chosen_params_WB,chosen_params);
    end






end % End of b loops







end