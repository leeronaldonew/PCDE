function [k1_new,k2_new,k3_new,k4_new,k1_RE_new,k2_RE_new,k3_RE_new,k4_RE_new,REhist_k1_before,REhist_k1_after,REhist_k2_before,REhist_k2_after,REhist_k3_before,REhist_k3_after,REhist_k4_before,REhist_k4_after]=Perform_Ransac_2TCM(k1,k2,k3,k4,k1_RE,k2_RE,k3_RE,k4_RE,x_gpu, y_gpu,initial_params,constraints)

maxd= 10; % max distance for RANSAC
Num_iter=1000; % max # of iteration for RANSAC

% Settings
Thre_k1 = 0.001;
Thre_k2 = 0.001;
Thre_k3 = 0.001;
Thre_k4 = 0.001;
Thre_RE = 10;
% Size
Size=size(k1);

% WB Masking (using WB contour of k1 map for the other maps) 
k2=k2.*logical(k1);
k3=k3.*logical(k1);
k4=k4.*logical(k1);

% Making Mask for the region which needs to perform fitting again (due to RE > 10 %)
k1_mask_origin= k1 > Thre_k1;
k2_mask_origin= k2 > Thre_k2;
k3_mask_origin= k3 > Thre_k3;
k4_mask_origin= k4 > Thre_k4;

k1_RE_mask_origin=k1_RE > Thre_RE;
k2_RE_mask_origin=k2_RE > Thre_RE;
k3_RE_mask_origin=k3_RE > Thre_RE;
k4_RE_mask_origin=k4_RE > Thre_RE;

k1_Mask_ransac=k1_mask_origin.*k1_RE_mask_origin;
k2_Mask_ransac=k2_mask_origin.*k2_RE_mask_origin;
k3_Mask_ransac=k3_mask_origin.*k3_RE_mask_origin;
k4_Mask_ransac=k4_mask_origin.*k4_RE_mask_origin;

%k1_RE_masked=k1_RE.*k1_Mask_ransac;
%k2_RE_masked=k2_RE.*k2_Mask_ransac;
%k3_RE_masked=k3_RE.*k3_Mask_ransac;
%k4_RE_masked=k4_RE.*k4_Mask_ransac;

Mask_tot=logical(k1_Mask_ransac+k2_Mask_ransac+k3_Mask_ransac+k4_Mask_ransac); % masking for the region which needs to perform fitting again
New_Num_Fit=nnz(Mask_tot);
New_Fit_Index=find(Mask_tot(:));
Num_data_points=size(y_gpu,1);
x_gpu=x_gpu(:);
y_gpu=y_gpu(:);
y_gpu_log=-1*log(y_gpu);
Num_inlier=zeros(1, New_Num_Fit);
y_gpu_log(isnan(y_gpu_log)) = 0 ; % considering NaN as zero
y_gpu_log(isinf(y_gpu_log)) = 0 ; % considering Inf as zero


%% Generation of Early PI data using established database
[chosen_params]= Database_driven_parameter_choice(x_gpu, y_gpu,Num_data_points,New_Num_Fit,New_Fit_Index);








%% Performing RANSAC

load("Local_Estimates");
distFcn=@(model,data) (   abs(data(:,2)-TTCM_analytic(model,data(:,1)))   ); 
options = optimoptions('lsqcurvefit','Display', 'off');
fitFcn_RANSAC=@(data) ( lsqcurvefit(@TTCM_analytic, [0.5;0.5;0.05;0.05], double(data(:,1)),double(data(:,2)), [0;0;0;0], [1000000;1000000;1000000;1000000],options) );

% Making New starting points & Finding outliers through RANSAC algorithm
for i=1:1:New_Num_Fit
    tic;
    ind=New_Fit_Index(i);
    start_temp=Num_data_points*(ind-1)+1;
    end_temp=Num_data_points*ind;
    %[New_parameters, inlierIdx] = fitPolynomialRANSAC([x_gpu(start_temp:end_temp),y_gpu_log(start_temp:end_temp)],1,maxd,'MaxNumTrials',Num_iter);
    [New_parameters,inlierIdx] = ransac([x_gpu(start_temp:end_temp),y_gpu(start_temp:end_temp)],fitFcn_RANSAC,distFcn,4,maxd,'MaxNumTrials',Num_iter);
    Num_inlier(i)=sum(inlierIdx); % for DOF
    if i==1
       New_parameters_update=New_parameters;
       inlierIdx_update=inlierIdx;
       %inlierIdx_Vd_update=single((~inlierIdx)*New_parameters(1,2));
    else
       New_parameters_update=cat(2,New_parameters_update,New_parameters); 
       inlierIdx_update=cat(2, inlierIdx_update, inlierIdx);
       %inlierIdx_Vd_update=cat(2,inlierIdx_Vd_update,single((~inlierIdx)*New_parameters(1,2)));
    end
    toc;
end

% 30 [min] for 225231 New fits, 7 [min]
% Generation of GPUfit inputs for the region which needs to perform fitting again
for i=1:1:New_Num_Fit
    ind=New_Fit_Index(i);
    start_temp=Num_data_points*(ind-1)+1;
    end_temp=Num_data_points*ind;
    x_gpu_new_fit=single(zeros(1,Num_data_points));
    y_gpu_new_fit=single(zeros(Num_data_points,1));
    x_gpu_new_fit=transpose(x_gpu(start_temp:end_temp));
    y_gpu_new_fit=y_gpu(start_temp:end_temp);
    if i==1
       x_gpu_new_fit_update=x_gpu_new_fit;
       y_gpu_new_fit_update=y_gpu_new_fit;
    else
       x_gpu_new_fit_update=cat(2,x_gpu_new_fit_update,x_gpu_new_fit);
       y_gpu_new_fit_update=cat(2,y_gpu_new_fit_update,y_gpu_new_fit);
    end
end
x_gpu_new_fit_update=x_gpu_new_fit_update.*transpose(inlierIdx_update(:));
y_gpu_new_fit_update=y_gpu_new_fit_update.*inlierIdx_update;

% GPUfit again
initial_params_new=repmat(initial_params(:,1),1,New_Num_Fit);
constraints_new=single(repmat(constraints(:,1),1,New_Num_Fit));
estimator_id = EstimatorID.LSE;
model_id = ModelID.TTCM;
tolerance = 1e-9;
max_n_iterations = 1000;
constraint_types = int32([ConstraintType.LOWER_UPPER, ConstraintType.LOWER_UPPER, ConstraintType.LOWER_UPPER, ConstraintType.LOWER_UPPER]); % considering both lower & upper bounds

[parameters_new, states, chi_squares_new, n_iterations, time]...
        = gpufit_constrained(y_gpu_new_fit_update, single(inlierIdx_update), model_id, New_parameters_update, constraints_new, constraint_types, tolerance, max_n_iterations, [], estimator_id, x_gpu_new_fit_update);
%fprintf('Fitted parameters = [%.2f, %.2f], SSE = %.2f \n', parameters_new, chi_squares_new);

J_new=Get_Jacobian(parameters_new,x_gpu_new_fit_update,Num_data_points,2); % for 2TCM
[RE_new,se_update_new]=Get_RE(J_new, parameters_new, chi_squares_new, Num_data_points, Num_inlier,inlierIdx_update,2); % for 2TCM

% Updating k1,k2,k3,k4 & k1_RE,k2_RE,k3_RE,k4_RE
k1_vector=k1(:);
k2_vector=k2(:);
k3_vector=k3(:);
k4_vector=k4(:);
k1_RE_vector=k1_RE(:);
k2_RE_vector=k2_RE(:);
k3_RE_vector=k3_RE(:);
k4_RE_vector=k4_RE(:);

for i=1:1:New_Num_Fit
    ind=New_Fit_Index(i);
    k1_vector(ind)=parameters_new(1,i);
    k2_vector(ind)=parameters_new(2,i);
    k3_vector(ind)=parameters_new(3,i);
    k4_vector(ind)=parameters_new(4,i);
    k1_RE_vector(ind)=RE_new(1,i);
    k2_RE_vector(ind)=RE_new(2,i);
    k3_RE_vector(ind)=RE_new(3,i);
    k4_RE_vector(ind)=RE_new(4,i);
end
k1_update=reshape(k1_vector, Size(1), Size(2), Size(3));
k2_update=reshape(k2_vector, Size(1), Size(2), Size(3));
k3_update=reshape(k3_vector, Size(1), Size(2), Size(3));
k4_update=reshape(k4_vector, Size(1), Size(2), Size(3));

k1_RE_update=reshape(k1_RE_vector, Size(1), Size(2), Size(3));
k2_RE_update=reshape(k2_RE_vector, Size(1), Size(2), Size(3));
k3_RE_update=reshape(k3_RE_vector, Size(1), Size(2), Size(3));
k4_RE_update=reshape(k4_RE_vector, Size(1), Size(2), Size(3));

k1_mask_update= k1_update > Thre_k1;
k2_mask_update= k2_update > Thre_k2;
k3_mask_update= k3_update > Thre_k3;
k4_mask_update= k4_update > Thre_k4;

REhist_k1_before=nonzeros(k1_RE.*k1_mask_origin);
REhist_k1_after=nonzeros(k1_RE_update.*k1_mask_update);
REhist_k2_before=nonzeros(k2_RE.*k2_mask_origin);
REhist_k2_after=nonzeros(k2_RE_update.*k2_mask_update);
REhist_k3_before=nonzeros(k3_RE.*k3_mask_origin);
REhist_k3_after=nonzeros(k3_RE_update.*k3_mask_update);
REhist_k4_before=nonzeros(k4_RE.*k4_mask_origin);
REhist_k4_after=nonzeros(k4_RE_update.*k4_mask_update);

k1_new=k1_update.*k1_mask_update;
k2_new=k2_update.*k2_mask_update;
k3_new=k3_update.*k3_mask_update;
k4_new=k4_update.*k4_mask_update;

k1_RE_new =k1_RE_update.*k1_mask_update;
k2_RE_new =k2_RE_update.*k2_mask_update;
k3_RE_new =k3_RE_update.*k3_mask_update;
k4_RE_new =k4_RE_update.*k4_mask_update;


save("New_Fit_Index_Ransac.mat", "New_Fit_Index");
save("inlierIdx_update_Ransac.mat", "inlierIdx_update");





















end