function [Prob_k1_fit_2TCM,Prob_k2_fit_2TCM,Prob_k3_fit_2TCM,Prob_k4_fit_2TCM,k1_predicted_2TCM,k1_RE_2TCM,k2_predicted_2TCM,k2_RE_2TCM,k3_predicted_2TCM,k3_RE_2TCM,k4_predicted_2TCM,k4_RE_2TCM,Ki_pred_2TCM,Ki_RE_2TCM,Ki_pred, Ki_pred_Patlak,Ki_RE,Ki_RE_Patlak,Ki_true,Prob_k1_fit,Prob_k2_fit,Prob_k3_fit,Prob_k4_fit,Mean_Bias,Mean_Bias_P,Mean_REs,k1_true,k2_true,k3_true,k4_true,k1_predicted,k2_predicted,k3_predicted,k4_predicted,k1_RE,k2_RE,k3_RE,k4_RE,overall_noise_P,overall_noise_Patlak_P]=virtual_phantom_simul(scale_factor)
% Sigma Level ==> Enter relative [%] with respect to the mean value(i.e., pixel value)!!!

% Loading necessary data
load("Local_Estimates.mat");

%% Generating virtual volume having randomly generated k values (Homogeneousl! k1,k2,k3,k4:0.01~1)
%vec=single(randi([1,100],125,4))*single(0.01);
%k1_true=reshape(vec(:,1),5,5,5);
%k2_true=reshape(vec(:,2),5,5,5);
%k3_true=reshape(vec(:,3),5,5,5);
%k4_true=reshape(vec(:,4),5,5,5);
%vec_cell=mat2cell(vec,[ones(1,125)],[4]);

%% Generating virtual volume having randomly generated k values (Non-Homogeneousl! k1,k3:0.5~1, k2,k4:0.01~0.5)
k1_true=reshape(single(randi([50, 100],125,1))*single(0.01), 5,5,5);
k2_true=reshape(single(randi([50, 100],125,1))*single(0.01), 5,5,5);
k3_true=reshape(single(randi([1, 100],125,1))*single(0.01), 5,5,5);
k4_true=reshape(single(randi([1, 50],125,1))*single(0.01), 5,5,5);
vec=[reshape(k1_true,125,1), reshape(k2_true,125,1), reshape(k3_true,125,1), reshape(k4_true,125,1)];
vec_cell=mat2cell(vec,[ones(1,125)],[4]);

% Generating measured PET volume
PI_Time=single([10:10:90]); % measured PI Times (from 10 to 90 [min] with 10 [min] duration)
%for i=1:1:125
%    vec_PET{i,1}=single(TTCM_analytic_Multi(vec(i,:),PI_Time));
%end
vec_PET_mat=single(TTCM_analytic_Multi(vec, PI_Time));
vec_PET=mat2cell(vec_PET_mat,[ones(1,125)],[size(PI_Time,2)]);
vol_PET=reshape(vec_PET, 5,5,5);

% vec_PET_mat_4D
for p=1:1:size(PI_Time,2)
    vec_PET_mat_4D(:,:,:,p)=reshape(vec_PET_mat(:,p), 5,5,5);
end
% Adding noise
T_half=109.8; % assumed isotope: 18F
T_frame= 0.75; % Time duration for a frame: 45 [sec] = 0.75 [min]
for i=1:1:5
    for j=1:1:5
        for k=1:1:5
            for p=1:1:size(PI_Time,2)
                %vec_PET_mat_4D_noisy(i,j,k,p)=vec_PET_mat_4D(i,j,k,p) + (vec_PET_mat_4D(i,j,k,p)*sigma_level*0.01*randn(1,1));
                % Zero-Mean Gaussian noise for PET (Wu and Carlson, 2002)
                vec_PET_mat_4D_noisy(i,j,k,p)=vec_PET_mat_4D(i,j,k,p) + ( scale_factor*((vec_PET_mat_4D(i,j,k,p)*exp((log(2))/T_half*PI_Time(p))/T_frame)^(0.5))*randn(1,1));
            end
        end
    end
end
overall_noise_P=100*mean(abs(vec_PET_mat_4D_noisy-vec_PET_mat_4D)./vec_PET_mat_4D, 'all'); % overall noise level [%]

% Reshaping
for p=1:1:size(PI_Time,2)
    real_signal(:,p)=reshape(vec_PET_mat_4D_noisy(:,:,:,p),125,1);
end
% Adding noise to the signal
%sigma_level [%] =sigma / signal *100 ;
%real_signal=vec_PET_mat+awgn(vec_PET_mat,10);

%real_signal=vec_PET_mat+((vec_PET_mat*sigma_level*0.01).*randn(1,1)); % for gaussian noise
%real_signal=vec_PET_mat + (poissrnd( vec_PET_mat*(sigma_level*0.01)^(2) )); % for poisson noise

%for v=1:1:size(vec_PET_mat,1)
%    for p=1:1:size(vec_PET_mat,2)
%        real_signal(v,p)=vec_PET_mat(v,p) + ( vec_PET_mat(v,p)*sigma_level*0.01*randn(1,1) );
%    end
%end

% 3D-version
%vec_PET_lb=min(vec_PET_mat(:));
%vec_PET_ub=max(vec_PET_mat(:));
%scaled_vec_PET_mat=rescale(vec_PET_mat);
%real_signal=rescale(imnoise(scaled_vec_PET_mat, 'poisson'),vec_PET_lb,vec_PET_ub) ; % for poisson noise
%real_signal=rescale(imnoise(scaled_vec_PET_mat, 'gaussian', 0,0.1),vec_PET_lb,vec_PET_ub) ; % for gaussian noise

% 2D-version
%for t=1:1:size(PI_Time,2)
%    vol_temp=reshape(vec_PET_mat(:,t),5,5,5);
%    for s=1:1:5
%        slice=vol_temp(:,:,s);
%        slice_lb=min(slice(:));
%        slice_ub=max(slice(:));
%        scaled_slice=rescale(slice);
%        real_signal_slice=rescale(imnoise(scaled_slice,'poisson'), slice_lb, slice_ub);
%        if s==1
%            real_signal_vol=real_signal_slice(:);
%        else
%            real_signal_vol=cat(1,real_signal_vol,real_signal_slice(:) );
%        end
%    end
%    real_signal(:,t)=real_signal_vol;
%end


filter_negative= real_signal < 0;
real_signal(filter_negative)=0; % avoiding negative signal! (due to the fact that it is not possible)

vec_PET_mat=real_signal;
vec_PET=mat2cell(vec_PET_mat,[ones(1,125)],[size(PI_Time,2)]);
vol_PET=reshape(vec_PET, 5,5,5);

% Using Filter to remove noise
%sigma=2;
%for t=1:1:size(real_signal,2)
%    if t==1
%        signal_filtered=reshape(imgaussfilt3(reshape(real_signal(:,t), 5,5,5),sigma), 125,1);
%    else
%        signal_filtered=cat(2,signal_filtered, reshape(imgaussfilt3(reshape(real_signal(:,t), 5,5,5),sigma), 125,1)  );   % gaussian filter
%    end
%end
%vec_PET_mat=signal_filtered;
%vec_PET=mat2cell(vec_PET_mat,[ones(1,125)],[size(PI_Time,2)]);
%vol_PET=reshape(vec_PET, 5,5,5);


% Building Database
%permutes=single(combinator(100,4,'p','r'))*single(0.01);
%true_data=single(TTCM_analytic_Multi(permutes, PI_Time));
%[permutes,true_data]=make_database(PI_Time); % generating random k parameterd Homogeneously! (k1,k2,k3,k4:0.01~1) 
[permutes,true_data]=make_database_NH(PI_Time); % generating random k parameters Non-Homogeneously! (k1,k2:0.5~1, k3,k4:0.01~0.5)

% Finding params by comparing the distances between Late PI data & the Database
% Might be the subject of GPU Coder
for i=1:1:125
    tic;
    Y_data_repmat=single(repmat(vec_PET{i,1}, size(permutes,1),1));
    toc;
    %Y_data_repmat_GPU=gpuArray(Y_data_repmat);
    %true_data_GPU=gpuArray(true_data);
    tic;
    [min_val,ind_min]=min( sum(abs(true_data-Y_data_repmat),2) );
    toc;
    if i==1
        chosen_params=permutes(ind_min,:);
    else
        chosen_params=cat(1, chosen_params, permutes(ind_min,:));
    end
    Min_ind(1,i)=ind_min;
    toc;
end

chosen_k1=chosen_params(:,1);
chosen_k2=chosen_params(:,2);
chosen_k3=chosen_params(:,3);
chosen_k4=chosen_params(:,4);
vol_k1_predicted=reshape(chosen_k1,5,5,5);
vol_k2_predicted=reshape(chosen_k2,5,5,5);
vol_k3_predicted=reshape(chosen_k3,5,5,5);
vol_k4_predicted=reshape(chosen_k4,5,5,5);
diff_k1=round(vec(:,1)-chosen_k1,2);
diff_k2=round(vec(:,2)-chosen_k2,2);
diff_k3=round(vec(:,3)-chosen_k3,2);
diff_k4=round(vec(:,4)-chosen_k4,2);

% Calc. of Probability of finding true parameters
Prob_k1=(size(diff_k1,1)-nnz(diff_k1))/125 * 100; % unit: [%]
Prob_k2=(size(diff_k2,1)-nnz(diff_k2))/125 * 100; % unit: [%]
Prob_k3=(size(diff_k3,1)-nnz(diff_k3))/125 * 100; % unit: [%]
Prob_k4=(size(diff_k4,1)-nnz(diff_k4))/125 * 100; % unit: [%]


% Generating Artificial Data Points
%Early_PI_Time=single([0:0.01:90]);
Early_PI_Time=single([0:0.01:10]);

for i=1:1:125
    if i==1
        Art_data=TTCM_analytic(chosen_params(i,:),Early_PI_Time);
    else
        Art_data=cat(1,Art_data,TTCM_analytic(chosen_params(i,:),Early_PI_Time));
    end
end
total_data=cat(2, Art_data,vec_PET_mat);
art_vec_PET=mat2cell(total_data,[ones(1,125)],[size(total_data,2)]);
art_vol_PET=reshape(art_vec_PET,5,5,5);

% Making 4D array
Time=[Early_PI_Time, PI_Time];
for i=1:1:5
    for j=1:1:5
        for k=1:1:5
            for p=1:1:size(Time,2)
                X_4D(i,j,k,p)=Time(p);
                Y_4D(i,j,k,p)=art_vol_PET{i,j,k}(1,p);
            end
        end
    end
end
   

% Doing fitting & Calc. of REs
Starting=[0.5;0.5;0.05;0.05];
LB=[0;0;0;0];
UB=[1;1;1;1];
Num_Passes=size(Time,2);
[x_gpu, y_gpu, initial_params, constraints]=Make_GPUfit_Input(X_4D, Y_4D, Starting, LB, UB, 2); % for 2TCM model index == 2
initial_params=transpose(chosen_params);
% GPUfit setting
Size_WB=[5,5,5,size(Time,2)];
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

f_waitbar = waitbar(0,'Please wait...', 'Name','Fitting with 2TCM');
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

k1_predicted=reshape(parameters_update(1,:),Size_WB(1),Size_WB(2),Size_WB(3));
k2_predicted=reshape(parameters_update(2,:),Size_WB(1),Size_WB(2),Size_WB(3));
k3_predicted=reshape(parameters_update(3,:),Size_WB(1),Size_WB(2),Size_WB(3));
k4_predicted=reshape(parameters_update(4,:),Size_WB(1),Size_WB(2),Size_WB(3));
k1_RE=reshape(RE_update(1,:), Size_WB(1),Size_WB(2),Size_WB(3));
k2_RE=reshape(RE_update(2,:), Size_WB(1),Size_WB(2),Size_WB(3));
k3_RE=reshape(RE_update(3,:), Size_WB(1),Size_WB(2),Size_WB(3));
k4_RE=reshape(RE_update(4,:), Size_WB(1),Size_WB(2),Size_WB(3));

% Calc. of Probability of finding true parameters after fitting
fit_diff_k1=round(vec(:,1)-k1_predicted(:),2);
fit_diff_k2=round(vec(:,2)-k2_predicted(:),2);
fit_diff_k3=round(vec(:,3)-k3_predicted(:),2);
fit_diff_k4=round(vec(:,4)-k4_predicted(:),2);
Prob_k1_fit=(size(fit_diff_k1,1)-nnz(fit_diff_k1))/125 * 100; % unit: [%]
Prob_k2_fit=(size(fit_diff_k2,1)-nnz(fit_diff_k2))/125 * 100; % unit: [%]
Prob_k3_fit=(size(fit_diff_k3,1)-nnz(fit_diff_k3))/125 * 100; % unit: [%]
Prob_k4_fit=(size(fit_diff_k4,1)-nnz(fit_diff_k4))/125 * 100; % unit: [%]

% Parameter & RE Histogram
Hist_k1_true=round(vec(:,1),2);
Hist_k2_true=round(vec(:,2),2);
Hist_k3_true=round(vec(:,3),2);
Hist_k4_true=round(vec(:,4),2);

Hist_k1_fit=round(k1_predicted(:),2);
Hist_k2_fit=round(k2_predicted(:),2);
Hist_k3_fit=round(k3_predicted(:),2);
Hist_k4_fit=round(k4_predicted(:),2);

REHist_k1_fit=round(k1_RE(:),2);
REHist_k2_fit=round(k2_RE(:),2);
REHist_k3_fit=round(k3_RE(:),2);
REHist_k4_fit=round(k4_RE(:),2);


Diff_Hist_k1=Hist_k1_true-Hist_k1_fit; % difference= [true] - [selected]
Diff_Hist_k2=Hist_k2_true-Hist_k2_fit;
Diff_Hist_k3=Hist_k3_true-Hist_k3_fit;
Diff_Hist_k4=Hist_k4_true-Hist_k4_fit;

% K_i true
Ki_true=round((k1_true.*k3_true)./(k2_true+k3_true), 2);
Ki_pred=round((k1_predicted.*k3_predicted)./(k2_predicted+k3_predicted),2);
Ki_bias=round(mean(abs(Ki_true-Ki_pred), 'all'),2);
%Ki_bias_P=round(mean((Ki_bias./Ki_true)*100,'all'),2);
Ki_bias_P=round(mean(abs( (Ki_true-Ki_pred)./Ki_true )*100, 'all'),2);

% Calc. of RE [%] of K_i by using Error Propagation Theory (Ki=A/B)
A_sigma=(k1_predicted.*k3_predicted).*( (k1_RE/100).^(2) +  (k3_RE/100).^(2)  ).^(0.5);
B_sigma=( ((k2_predicted.*k2_RE/100).^(2)) +  ((k3_predicted.*k3_RE/100).^(2))  ).^(0.5);
Ki_RE=100*( (((A_sigma./(k1_predicted.*k3_predicted)).^(2)) + ((B_sigma./(k2_predicted+k3_predicted)).^(2))).^(0.5)  );

%% code for comparison with original 2TCM method
% Doing fitting & Calc. of REs
Starting=[0.5;0.5;0.05;0.05];
LB=[0;0;0;0];
UB=[1;1;1;1];
Num_Passes=size(PI_Time,2);
Time=PI_Time;
for i=1:1:5
    for j=1:1:5
        for k=1:1:5
            for p=1:1:size(Time,2)
                X_4D_2TCM(i,j,k,p)=Time(p);
            end
        end
    end
end
Y_4D_2TCM=vec_PET_mat_4D_noisy;
[x_gpu, y_gpu, initial_params, constraints]=Make_GPUfit_Input(X_4D_2TCM, Y_4D_2TCM, Starting, LB, UB, 2); % for 2TCM model index == 2
%initial_params=transpose(chosen_params);
% GPUfit setting
Size_WB=[5,5,5,size(Time,2)];
estimator_id = EstimatorID.LSE;
model_id = ModelID.TTCM;
tolerance = 1e-12;
max_n_iterations = 1000;
constraint_types = int32([ConstraintType.LOWER_UPPER, ConstraintType.LOWER_UPPER, ConstraintType.LOWER_UPPER, ConstraintType.LOWER_UPPER]); % considering both lower & upper bounds

x_gpu_temp=zeros(1, Size_WB(4)*Size_WB(1)*Size_WB(2), 'single');
y_gpu_temp=zeros(Size_WB(4), Size_WB(1)*Size_WB(2), 'single');
initial_params_temp=zeros(size(Starting,1),Size_WB(1)*Size_WB(2), 'single');
constraints_temp=zeros(2*size(Starting,1),Size_WB(1)*Size_WB(2), 'single');

Num_inlier=single(repmat(Size_WB(4),1,size(y_gpu,2)));
inlierIdx=single(ones(Size_WB(4),size(y_gpu,2)));

f_waitbar = waitbar(0,'Please wait...', 'Name','Fitting with 2TCM');
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

k1_predicted_2TCM=reshape(parameters_update(1,:),Size_WB(1),Size_WB(2),Size_WB(3));
k2_predicted_2TCM=reshape(parameters_update(2,:),Size_WB(1),Size_WB(2),Size_WB(3));
k3_predicted_2TCM=reshape(parameters_update(3,:),Size_WB(1),Size_WB(2),Size_WB(3));
k4_predicted_2TCM=reshape(parameters_update(4,:),Size_WB(1),Size_WB(2),Size_WB(3));
k1_RE_2TCM=reshape(RE_update(1,:), Size_WB(1),Size_WB(2),Size_WB(3));
k2_RE_2TCM=reshape(RE_update(2,:), Size_WB(1),Size_WB(2),Size_WB(3));
k3_RE_2TCM=reshape(RE_update(3,:), Size_WB(1),Size_WB(2),Size_WB(3));
k4_RE_2TCM=reshape(RE_update(4,:), Size_WB(1),Size_WB(2),Size_WB(3));

% Calc. of Probability of finding true parameters after fitting
fit_diff_k1_2TCM=round(vec(:,1)-k1_predicted_2TCM(:),2);
fit_diff_k2_2TCM=round(vec(:,2)-k2_predicted_2TCM(:),2);
fit_diff_k3_2TCM=round(vec(:,3)-k3_predicted_2TCM(:),2);
fit_diff_k4_2TCM=round(vec(:,4)-k4_predicted_2TCM(:),2);
Prob_k1_fit_2TCM=(size(fit_diff_k1_2TCM,1)-nnz(fit_diff_k1_2TCM))/125 * 100; % unit: [%]
Prob_k2_fit_2TCM=(size(fit_diff_k2_2TCM,1)-nnz(fit_diff_k2_2TCM))/125 * 100; % unit: [%]
Prob_k3_fit_2TCM=(size(fit_diff_k3_2TCM,1)-nnz(fit_diff_k3_2TCM))/125 * 100; % unit: [%]
Prob_k4_fit_2TCM=(size(fit_diff_k4_2TCM,1)-nnz(fit_diff_k4_2TCM))/125 * 100; % unit: [%]

% Parameter & RE Histogram
Hist_k1_true=round(vec(:,1),2);
Hist_k2_true=round(vec(:,2),2);
Hist_k3_true=round(vec(:,3),2);
Hist_k4_true=round(vec(:,4),2);

Hist_k1_fit_2TCM=round(k1_predicted_2TCM(:),2);
Hist_k2_fit_2TCM=round(k2_predicted_2TCM(:),2);
Hist_k3_fit_2TCM=round(k3_predicted_2TCM(:),2);
Hist_k4_fit_2TCM=round(k4_predicted_2TCM(:),2);

REHist_k1_fit_2TCM=round(k1_RE_2TCM(:),2);
REHist_k2_fit_2TCM=round(k2_RE_2TCM(:),2);
REHist_k3_fit_2TCM=round(k3_RE_2TCM(:),2);
REHist_k4_fit_2TCM=round(k4_RE_2TCM(:),2);


Diff_Hist_k1_2TCM=Hist_k1_true-Hist_k1_fit_2TCM; % difference= [true] - [selected]
Diff_Hist_k2_2TCM=Hist_k2_true-Hist_k2_fit_2TCM;
Diff_Hist_k3_2TCM=Hist_k3_true-Hist_k3_fit_2TCM;
Diff_Hist_k4_2TCM=Hist_k4_true-Hist_k4_fit_2TCM;

% K_i true
Ki_true=round((k1_true.*k3_true)./(k2_true+k3_true), 2);
Ki_pred_2TCM=round((k1_predicted_2TCM.*k3_predicted_2TCM)./(k2_predicted_2TCM+k3_predicted_2TCM),2);
Ki_bias_2TCM=round(mean(abs(Ki_true-Ki_pred_2TCM), 'all'),2);
%Ki_bias_P=round(mean((Ki_bias./Ki_true)*100,'all'),2);
Ki_bias_P_2TCM=round(mean(abs( (Ki_true-Ki_pred_2TCM)./Ki_true )*100, 'all'),2);

% Calc. of RE [%] of K_i by using Error Propagation Theory (Ki=A/B)
A_sigma_2TCM=(k1_predicted_2TCM.*k3_predicted_2TCM).*( (k1_RE_2TCM/100).^(2) +  (k3_RE_2TCM/100).^(2)  ).^(0.5);
B_sigma_2TCM=( ((k2_predicted_2TCM.*k2_RE_2TCM/100).^(2)) +  ((k3_predicted_2TCM.*k3_RE_2TCM/100).^(2))  ).^(0.5);
Ki_RE_2TCM=100*( (((A_sigma_2TCM./(k1_predicted_2TCM.*k3_predicted_2TCM)).^(2)) + ((B_sigma_2TCM./(k2_predicted_2TCM+k3_predicted_2TCM)).^(2))).^(0.5)  );



%% Code for comparison with original Patlak method
% K_i & V_d true (assumption: fractional blood volume in a voxel, Vb==0)
Ki_true=round((k1_true.*k3_true)./(k2_true+k3_true), 2);
Vd_true=round( (k1_true.*k2_true)./((k2_true+k3_true).^2) ,2);
% C_tissue
Func_Exp_4=@(tau) Exp_4(Local_Estimates,tau);
Cp=Exp_4(Local_Estimates,PI_Time);
Ct=single(zeros(5,5,5,size(PI_Time,2)));
Ct_noisy=single(zeros(5,5,5,size(PI_Time,2)));
for i=1:1:5
    for j=1:1:5
        for k=1:1:5
            for p=1:1:size(PI_Time,2)
                Ct(i,j,k,p)=(Ki_true(i,j,k)*integral(Func_Exp_4, 0, PI_Time(p), 'ArrayValued',true)) + (Vd_true(i,j,k)*Cp(p));
                %Ct_noisy(i,j,k,p)= Ct(i,j,k,p) + ((Ct(i,j,k,p)*sigma_level*0.01*randn(1,1)));
                % Zero-Mean Gaussian noise for PET (Wu and Carlson, 2002)
                Ct_noisy(i,j,k,p)= Ct(i,j,k,p) +  ( 10*scale_factor*((Ct(i,j,k,p)*exp((log(2))/T_half*PI_Time(p))/T_frame)^(0.5))*randn(1,1));
            end
        end
    end
end
overall_noise_Patlak_P=100*mean(abs(Ct_noisy-Ct)./Ct, 'all'); % overall noise level [%]


% X & Y for Patlak
X_4D_Patlak=single(zeros(5,5,5,size(PI_Time,2))); % Integ_Cp_over_Cp
Y_4D_Patlak=single(zeros(5,5,5,size(PI_Time,2))); % C_tissue_over_Cp

for i=1:1:5
    for j=1:1:5
        for k=1:1:5
            for p=1:1:size(PI_Time,2)
                X_4D_Patlak(i,j,k,p)=integral(Func_Exp_4, 0, PI_Time(p), 'ArrayValued',true) / Cp(p);
                Y_4D_Patlak(i,j,k,p)=Ct_noisy(i,j,k,p)/Cp(p);
                %Y_4D_Patlak(i,j,k,p)=vec_PET_mat_4D_noisy(i,j,k,p)/Cp(p);
            end
        end
    end
end

% GPU fit
Starting=[1;0];
LB=[0;-10];
UB=[10;10];
Num_Passes=size(PI_Time,2);
[x_gpu, y_gpu, initial_params, constraints]=Make_GPUfit_Input(X_4D_Patlak, Y_4D_Patlak, Starting, LB, UB, 1);
initial_params=vertcat(transpose(Vd_true(:)), transpose(Ki_true(:)));
% GPUfit setting
Size_WB=[5,5,5,size(PI_Time,2)];
estimator_id = EstimatorID.LSE;
model_id = ModelID.LINEAR_1D;
tolerance = 1e-9;
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
    waitbar(k/Size_WB(3), f_waitbar, "Current Slice Index: " + num2str(k) + " / " + num2str(Size_WB(3)));
    i_start= ((k-1)*Size_WB(1)*Size_WB(2))+1; % initialization
    i_end= k*Size_WB(1)*Size_WB(2);
    i_start_x_gpu_temp=((k-1)*Size_WB(4)*Size_WB(1)*Size_WB(2))+1;
    i_end_x_gpu_temp=k*Size_WB(4)*Size_WB(1)*Size_WB(2);
    x_gpu_temp=x_gpu(1, i_start_x_gpu_temp:i_end_x_gpu_temp);
    y_gpu_temp=y_gpu(:,i_start:i_end);
    initial_params_temp=initial_params(:,i_start:i_end);
    constraints_temp=constraints(:,i_start:i_end);
    [parameters, states, chi_squares, n_iterations, time]...
        = gpufit_constrained(y_gpu_temp, [], model_id, initial_params_temp, constraints_temp, constraint_types, tolerance, max_n_iterations, [], estimator_id, x_gpu_temp);
    %fprintf('Fitted parameters = [%.2f, %.2f], SSE = %.2f \n', parameters, chi_squares);
    % Calc. of RE[%] from Jacobian(through calc. of Covariance Matrix)
    J_slice=Get_Jacobian(parameters,x_gpu_temp,Num_Passes,1); % for Patlak: model index=1
    [RE_slice, se_slice]=Get_RE(J_slice, parameters, chi_squares, Num_Passes,Num_inlier,inlierIdx,1); % for Patlak: model index=1
    if k==1
        parameters_update=parameters;
        chi_squares_update=chi_squares;
        RE_update=RE_slice;
    else
        parameters_update=cat(2, parameters_update, parameters);
        chi_squares_update=cat(2,chi_squares_update, chi_squares);
        RE_update=cat(2, RE_update, RE_slice);
    end
end
close(f_waitbar);

Ki_pred_Patlak=reshape(parameters_update(2,:),Size_WB(1),Size_WB(2),Size_WB(3));
Vd_pred_Patlak=reshape(parameters_update(1,:),Size_WB(1),Size_WB(2),Size_WB(3));
Ki_RE_Patlak=reshape(RE_update(2,:), Size_WB(1),Size_WB(2),Size_WB(3));
Vd_RE_Patlak=reshape(RE_update(1,:), Size_WB(1),Size_WB(2),Size_WB(3));

Ki_bias_Patlak=round(mean(abs(Ki_true-Ki_pred_Patlak), 'all'),2);
Ki_bias_Patlak_P=round(mean(abs( (Ki_true-Ki_pred_Patlak)./Ki_true )*100, 'all'),2);

Vd_bias_Patlak=round(mean(abs(Vd_true-Vd_pred_Patlak), 'all'),2);
Vd_bias_Patlak_P=round(mean(abs((Vd_true-Vd_pred_Patlak)./Vd_true)*100, 'all'),2);



%% Summary of the results

% Mean Bias : [k1,k2,k3,k4,ki_2TCM,ki_PCDE,ki_Patlak]
Mean_Bias=round([mean(abs(Hist_k1_true-Hist_k1_fit)),mean(abs(Hist_k2_true-Hist_k2_fit)),mean(abs(Hist_k3_true-Hist_k3_fit)),mean(abs(Hist_k4_true-Hist_k4_fit)), mean(abs(Ki_true-Ki_pred_2TCM), 'all'),mean(abs(Ki_true-Ki_pred), 'all'), mean(abs(Ki_true-Ki_pred_Patlak), 'all')],2) ;
% Mean Bias [%] : [k1,k2,k3,k4,ki_2TCM,ki_PCDE,ki_Patlak]
Mean_Bias_P=round([mean(abs(Diff_Hist_k1./Hist_k1_true)*100), mean(abs(Diff_Hist_k2./Hist_k2_true)*100), mean(abs(Diff_Hist_k3./Hist_k3_true)*100), mean(abs(Diff_Hist_k4./Hist_k4_true)*100),mean(abs( (Ki_true-Ki_pred_2TCM)./Ki_true )*100, 'all') ,mean(abs( (Ki_true-Ki_pred)./Ki_true )*100, 'all'), mean(abs( (Ki_true-Ki_pred_Patlak)./Ki_true )*100, 'all')],2);
% Mean RE [%] : [k1,k2,k3,k4,ki_2TCM,ki_PCDE,ki_Patlak]
Mean_REs=round([mean(REHist_k1_fit),mean(REHist_k2_fit),mean(REHist_k3_fit),mean(REHist_k4_fit), mean(Ki_RE_2TCM,'all'),mean(Ki_RE,'all'), mean(Ki_RE_Patlak,'all')],2);




end