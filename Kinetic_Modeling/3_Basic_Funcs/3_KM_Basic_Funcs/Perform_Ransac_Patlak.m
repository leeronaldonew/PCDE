function [K_i_new,V_d_new,K_i_RE_new,V_d_RE_new,REhist_K_i_before,REhist_K_i_after,REhist_V_d_before,REhist_V_d_after,Parahist_K_i_before,Parahist_K_i_after,Parahist_V_d_before,Parahist_V_d_after]=Perform_Ransac_Patlak(K_i, V_d, K_i_RE, V_d_RE, x_gpu, y_gpu,constraints)

maxd= 0.1; % max distance for RANSAC
Num_iter=1000; % max # of iteration for RANSAC

    % Settings
    Thre_K_i = 0.001;
    Thre_V_d = 0.1;
    Thre_RE = 10;
    % Size
    Size=size(K_i);
    % Making Mask for the region which needs to perform fitting again (due to RE > 10 %)
    K_i_mask_thre_for_origin= K_i > Thre_K_i;
    K_i_RE_mask_thre_for_origin=K_i_RE > Thre_RE;
    K_i_Mask=K_i_mask_thre_for_origin.*K_i_RE_mask_thre_for_origin;
    K_i_RE_masked=K_i_RE.*K_i_Mask;
    V_d_mask_thre_for_origin= V_d > Thre_V_d;
    V_d_RE_mask_thre_for_origin=V_d_RE > Thre_RE;
    V_d_Mask=V_d_mask_thre_for_origin.*V_d_RE_mask_thre_for_origin;
    V_d_RE_masked=V_d_RE.*V_d_Mask;
    Mask_tot=logical(K_i_Mask+V_d_Mask); % masking for the region which needs to perform fitting again
    New_Num_Fit=nnz(Mask_tot);
    New_Fit_Index=find(Mask_tot(:));
    Num_data_points=size(y_gpu,1);
    x_gpu=x_gpu(:);
    y_gpu=y_gpu(:);
    Num_inlier=zeros(1, New_Num_Fit);
    % Making New starting points & Finding outliers through RANSAC algorithm
    for i=1:1:New_Num_Fit
        %tic;
        ind=New_Fit_Index(i);
        start_temp=Num_data_points*(ind-1)+1;
        end_temp=Num_data_points*ind;
        [New_parameters, inlierIdx] = fitPolynomialRANSAC([x_gpu(start_temp:end_temp),y_gpu(start_temp:end_temp)],1,maxd,'MaxNumTrials',Num_iter);
        New_parameters_temp(1,1)=New_parameters(1,2); % for intercept
        New_parameters_temp(2,1)=New_parameters(1,1); % for slope
        Num_inlier(i)=sum(inlierIdx); % for DOF
        if i==1
            New_parameters_update=New_parameters_temp;
            inlierIdx_update=inlierIdx;
            %inlierIdx_Vd_update=single((~inlierIdx)*New_parameters(1,2));
        else
            New_parameters_update=cat(2,New_parameters_update,New_parameters_temp); 
            inlierIdx_update=cat(2, inlierIdx_update, inlierIdx);
            %inlierIdx_Vd_update=cat(2,inlierIdx_Vd_update,single((~inlierIdx)*New_parameters(1,2)));
        end
        %toc;
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
    constraints_new=single(repmat(constraints(:,1),1,New_Num_Fit));
    estimator_id = EstimatorID.LSE;
    model_id = ModelID.LINEAR_1D;
    tolerance = 1e-9;
    max_n_iterations = 1000;
    constraint_types = int32([ConstraintType.LOWER_UPPER, ConstraintType.LOWER_UPPER]); % considering both lower & upper bounds

    [parameters_new, states, chi_squares_new, n_iterations, time]...
        = gpufit_constrained(y_gpu_new_fit_update, single(inlierIdx_update), model_id, New_parameters_update, constraints_new, constraint_types, tolerance, max_n_iterations, [], estimator_id, x_gpu_new_fit_update);
    %fprintf('Fitted parameters = [%.2f, %.2f], SSE = %.2f \n', parameters_new, chi_squares_new);

    J_new=Get_Jacobian(parameters_new,x_gpu_new_fit_update,Num_data_points,1); % for Patlak: model index=1
    [RE_new,se_update_new]=Get_RE(J_new, parameters_new, chi_squares_new, Num_data_points, Num_inlier,inlierIdx_update,1); % for Patlak: model index=1

    % Updating K_i & V_d and K_i_RE & V_d_RE
    K_i_vector=K_i(:);
    K_i_RE_vector=K_i_RE(:);
    V_d_vector=V_d(:);
    V_d_RE_vector=V_d_RE(:);
    for i=1:1:New_Num_Fit
        ind=New_Fit_Index(i);
        K_i_vector(ind)=parameters_new(2,i);
        V_d_vector(ind)=parameters_new(1,i);
        K_i_RE_vector(ind)=RE_new(2,i);
        V_d_RE_vector(ind)=RE_new(1,i);
    end
    K_i_update=reshape(K_i_vector, Size(1), Size(2), Size(3));
    V_d_update=reshape(V_d_vector, Size(1), Size(2), Size(3));
    K_i_RE_update=reshape(K_i_RE_vector, Size(1), Size(2), Size(3));
    V_d_RE_update=reshape(V_d_RE_vector, Size(1), Size(2), Size(3));
    K_i_mask_thre_for_update= K_i_update > Thre_K_i;
    V_d_mask_thre_for_update= V_d_update > Thre_V_d;

    %VolumeViewer3D(K_i_update.*K_i_mask_thre_for_update)
    %VolumeViewer3D(K_i_RE_update.*K_i_mask_thre_for_update)
    %VolumeViewer3D(V_d_update.*V_d_mask_thre_for_update)
    %VolumeViewer3D(V_d_RE_update.*V_d_mask_thre_for_update)

    REhist_K_i_before=nonzeros(K_i_RE.*K_i_mask_thre_for_origin);
    REhist_K_i_after=nonzeros(K_i_RE_update.*K_i_mask_thre_for_update);
    REhist_V_d_before=nonzeros(V_d_RE.*V_d_mask_thre_for_origin);
    REhist_V_d_after=nonzeros(V_d_RE_update.*V_d_mask_thre_for_update);

    K_i_new=K_i_update.*K_i_mask_thre_for_update;
    V_d_new=V_d_update.*V_d_mask_thre_for_update;
    K_i_RE_new =K_i_RE_update.*K_i_mask_thre_for_update;
    V_d_RE_new=V_d_RE_update.*V_d_mask_thre_for_update;
    
    Parahist_K_i_before=nonzeros(K_i.*K_i_mask_thre_for_origin);
    Parahist_K_i_after=nonzeros(K_i_new);
    Parahist_V_d_before=nonzeros(V_d.*V_d_mask_thre_for_origin);
    Parahist_V_d_after=nonzeros(V_d_new);
    


save("New_Fit_Index_Ransac.mat", "New_Fit_Index");
save("inlierIdx_update_Ransac.mat", "inlierIdx_update");
end