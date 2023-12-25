
True_params=[0.8, 0.7, 0.5, 0.1];
X_data=single([10:10:90]);
Y_data=TTCM_analytic(True_params, X_data);

[permutes,true_data]=make_database(transpose(X_data));
Y_data_repmat=single( repmat(Y_data,size(permutes,1),1) ) ;

tic;
[min_val,ind_min]=min( sum(abs(true_data-Y_data_repmat),2) );
chosen_params=permutes(ind_min,:);
toc;

tic;
[min_val,ind_min]=select_min_distance_ind(true_data,Y_data_repmat);
chosen_params=permutes(ind_min,:);
toc;

tic;
[min_val,ind_min]=select_min_distance_ind_mex1(true_data,Y_data_repmat);
chosen_params=permutes(ind_min,:);
toc;





Y_data_repmat=single(zeros(size(permutes,1),Num_data_points));
for i=1:1:New_Num_Fit
    tic;
    ind=New_Fit_Index(i);
    start_temp=Num_data_points*(i-1)+1;
    end_temp=Num_data_points*i;
    Y_data_repmat=single(repmat(transpose(y_gpu(start_temp:end_temp)),size(permutes,1),1));
    [min_val,ind_min]=min( sum(abs(true_data-Y_data_repmat),2) );
    %[min_val,ind_min]=select_min_distance_ind(true_data,Y_data_repmat);
    if i==1
        chosen_params=permutes(ind_min,:);
    else
        chosen_params=cat(1, chosen_params, permutes(ind_min,:));
    end
    toc;
end








%% Generating virtual volume having randomly generated k values
%vec= single(round(0.01.*randi([1,100],125,4), 2));
vec=single(randi([1,100],125,4))*single(0.01);
vol_k1_true=reshape(vec(:,1),5,5,5);
vol_k2_true=reshape(vec(:,2),5,5,5);
vol_k3_true=reshape(vec(:,3),5,5,5);
vol_k4_true=reshape(vec(:,4),5,5,5);
vec_cell=mat2cell(vec,[ones(1,125)],[4]);

% Generating measured PET volume
PI_Time=single([10:10:90]); % measured PI Times (from 10 to 90 [min] with 10 [min] duration)
%for i=1:1:125
%    vec_PET{i,1}=single(TTCM_analytic_Multi(vec(i,:),PI_Time));
%end
vec_PET_mat=single(TTCM_analytic_Multi(vec, PI_Time));
vec_PET=mat2cell(vec_PET_mat,[ones(1,125)],[9]);
vol_PET=reshape(vec_PET, 5,5,5);

% Building Database
%permutes=single(combinator(100,4,'p','r'))*single(0.01);
%true_data=single(TTCM_analytic_Multi(permutes, PI_Time));
[permutes,true_data]=make_database(PI_Time);

% Finding params by comparing the distances between Late PI data & the Database
for i=1:1:125
    tic;
    Y_data_repmat=single(repmat(vec_PET{i,1}, size(permutes,1),1));
    [min_val,ind_min]=min( sum(abs(true_data-Y_data_repmat),2) );
    if i==1
        chosen_params=permutes(ind_min,:);
    else
        chosen_params=cat(1, chosen_params, permutes(ind_min,:));
    end
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
Early_PI_Time=single([0:0.1:90]);
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

k1=reshape(parameters_update(1,:),Size_WB(1),Size_WB(2),Size_WB(3));
k2=reshape(parameters_update(2,:),Size_WB(1),Size_WB(2),Size_WB(3));
k3=reshape(parameters_update(3,:),Size_WB(1),Size_WB(2),Size_WB(3));
k4=reshape(parameters_update(4,:),Size_WB(1),Size_WB(2),Size_WB(3));
k1_RE=reshape(RE_update(1,:), Size_WB(1),Size_WB(2),Size_WB(3));
k2_RE=reshape(RE_update(2,:), Size_WB(1),Size_WB(2),Size_WB(3));
k3_RE=reshape(RE_update(3,:), Size_WB(1),Size_WB(2),Size_WB(3));
k4_RE=reshape(RE_update(4,:), Size_WB(1),Size_WB(2),Size_WB(3));

% Calc. of Probability of finding true parameters after fitting
fit_diff_k1=round(vec(:,1)-k1(:),2);
fit_diff_k2=round(vec(:,2)-k2(:),2);
fit_diff_k3=round(vec(:,3)-k3(:),2);
fit_diff_k4=round(vec(:,4)-k4(:),2);
Prob_k1_fit=(size(fit_diff_k1,1)-nnz(fit_diff_k1))/125 * 100; % unit: [%]
Prob_k2_fit=(size(fit_diff_k2,1)-nnz(fit_diff_k2))/125 * 100; % unit: [%]
Prob_k3_fit=(size(fit_diff_k3,1)-nnz(fit_diff_k3))/125 * 100; % unit: [%]
Prob_k4_fit=(size(fit_diff_k4,1)-nnz(fit_diff_k4))/125 * 100; % unit: [%]

% Parameter & RE Histogram
Hist_k1_true=round(vec(:,1),2);
Hist_k2_true=round(vec(:,2),2);
Hist_k3_true=round(vec(:,3),2);
Hist_k4_true=round(vec(:,4),2);

Hist_k1_fit=round(k1(:),2);
Hist_k2_fit=round(k2(:),2);
Hist_k3_fit=round(k3(:),2);
Hist_k4_fit=round(k4(:),2);

REHist_k1_fit=round(k1_RE(:),2);
REHist_k2_fit=round(k2_RE(:),2);
REHist_k3_fit=round(k3_RE(:),2);
REHist_k4_fit=round(k4_RE(:),2);








% C_tot slope graph with time %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
syms k1 k2 k3 k4 alpha_TTCM beta_TTCM A1 A2 A3 A4 B1 B2 B3 B4 x C_tot
alpha_TTCM=  ( (k2+k3+k4) + (((k2+k3+k4)^2)-(4*k2*k4))^(0.5) ) / 2;
beta_TTCM=   ( (k2+k3+k4) - (((k2+k3+k4)^2)-(4*k2*k4))^(0.5) ) / 2;
C_tot= ( ((k1*(alpha_TTCM-k4)-k1*k3)/(alpha_TTCM-beta_TTCM)) * (((A1/(alpha_TTCM-B1))*(exp(-1*B1*x)-exp(-1*alpha_TTCM*x))) + ((A2/(alpha_TTCM-B2))*(exp(-1*B2*x)-exp(-1*alpha_TTCM*x))) + ((A3/(alpha_TTCM-B3))*(exp(-1*B3*x)-exp(-1*alpha_TTCM*x))) + ((A4/(alpha_TTCM-B4))*(exp(-1*B4*x)-exp(-1*alpha_TTCM*x)))) ) + ( ((k1*k3-(k1*(beta_TTCM-k4)))/(alpha_TTCM-beta_TTCM)) * (((A1/(beta_TTCM-B1))*(exp(-1*B1*x)-exp(-1*beta_TTCM*x))) + ((A2/(beta_TTCM-B2))*(exp(-1*B2*x)-exp(-1*beta_TTCM*x))) + ((A3/(beta_TTCM-B3))*(exp(-1*B3*x)-exp(-1*beta_TTCM*x))) + ((A4/(beta_TTCM-B4))*(exp(-1*B4*x)-exp(-1*beta_TTCM*x)))) ) ;
par_diff_k1= matlabFunction(diff(C_tot, k1));
par_diff_k2= matlabFunction(diff(C_tot, k2));
par_diff_k3= matlabFunction(diff(C_tot, k3));
par_diff_k4= matlabFunction(diff(C_tot, k4));
A1=Local_Estimates(1);
B1=Local_Estimates(2);
A2=Local_Estimates(3);
B2=Local_Estimates(4);
A3=Local_Estimates(5);
B3=Local_Estimates(6);
A4=Local_Estimates(7);
B4=Local_Estimates(8);
k1=0.5;
k2=0.5;
k3=0.5;
k4=0.5;
par_diff_k1_val=par_diff_k1(A1,A2,A3,A4,B1,B2,B3,B4,k2,k3,k4,transpose([0:0.1:100]));
par_diff_k2_val=par_diff_k2(A1,A2,A3,A4,B1,B2,B3,B4,k1,k2,k3,k4,transpose([0:0.1:100]));
par_diff_k3_val=par_diff_k3(A1,A2,A3,A4,B1,B2,B3,B4,k1,k2,k3,k4,transpose([0:0.1:100]));
par_diff_k4_val=par_diff_k4(A1,A2,A3,A4,B1,B2,B3,B4,k1,k2,k3,k4,transpose([0:0.1:100]));

k1_list=[0:0.1:1];
k2_list=[0:0.1:1];
k3=[0:0.1:1];
k4=0.0;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% Sensitivity map or volume

% Sk1 map (with k4=0)
k1_list=[0:0.01:1];
k2_list=[0:0.01:1];
k3_list=[0:0.01:1];
k4_list=[0:0.01:1];
for j=1:1:100
    for i=1:1:100
        k4=0;
        k2=k2_list(j);
        k3=k3_list(i);
        Sk1_map(i,j)=par_diff_k1(A1,A2,A3,A4,B1,B2,B3,B4,k2,k3,k4,10);
    end
end

for j=1:1:100
    for i=1:1:100
        k4=0;
        k3=0.5;
        k2=k2_list(i);
        k1=k1_list(j);
        Sk3_map(i,j)=par_diff_k3(A1,A2,A3,A4,B1,B2,B3,B4,k1,k2,k3,k4,10);
    end
end



[Hist_k1_true,Hist_k2_true,Hist_k3_true,Hist_k4_true,Hist_k1_fit,Hist_k2_fit,Hist_k3_fit,Hist_k4_fit,REHist_k1_fit,REHist_k2_fit,REHist_k3_fit,REHist_k4_fit,Prob_k1_fit,Prob_k2_fit,Prob_k3_fit,Prob_k4_fit,Diff_Hist_k1,Diff_Hist_k2,Diff_Hist_k3,Diff_Hist_k4,Mean_Bias,Mean_REs,k1_true,k2_true,k3_true,k4_true,k1_predicted,k2_predicted,k3_predicted,k4_predicted,k1_RE,k2_RE,k3_RE,k4_RE]=virtual_phantom_simul(10);



%% For RT2 Assignment

syms b D_b E_p P k D_3b

E_p=9*(1-((0.3+b)/4.5));
E_p_Val= matlabFunction(E_p);

k=6.1*(E_p^(-0.62));
k_Val= matlabFunction(k);

D_3b=0.841;
D_b=D_3b*0.735*exp(-0.052*E_p)*exp(-k*b);
D_b_Val= matlabFunction(D_b);

D_b_3b_Val=D_b_Val(0.3+b);


b;
p;
Ep=9*(1-((b+0.3)/4.5));
D_A=0.8+p*0.735*exp(-0.052*Ep)*exp(-6.1*(Ep^(-0.62))*(b+0.3))
D_B=0.839+p*0.735*exp(-0.052*Ep)*exp(-6.1*(Ep^(-0.62))*b)
Final=2*abs(D_A-D_B)/(D_A+D_B)

%% Testing GPU coder

function [Ind_final]=PCDE_gpu(X,Y)
    
    num_comb=size(X,1);
    num_data=size(X,2);
    num_voxel=size(Y,2);

    
    num_subcomb=ceil(num_comb/100000);
    num_subvoxel=ceil(num_voxel/10000);
    
    if num_subcomb ==1
        X_sub=zeros(num_comb,num_data,'half');
    else
        X_sub=zeros(100000,num_data,'half');
    end
    
    if num_subvoxel ==1
        Y_sub=zeros(num_data,num_voxel,'half');
    else
        Y_sub=zeros(num_data,10000,'half');
    end
    

    for v=1:1:num_subvoxel

        if v==num_subvoxel
            Y_sub=Y(:,(10000*(v-1)+1):(end));
        else
            Y_sub=Y(:,(10000*(v-1)+1):(10000*v)); % Spliting Y into a sub-voxels having 10^4 voxels
        end

        for c=1:1:num_subcomb
            if c==num_subcomb
                X_sub=X( (100000*(c-1)+1):(end), :);
            else
                X_sub=X( (100000*(c-1)+1):(100000*c), :); % Spliting X into a sub-combination data having 10^5 combinations
            end

            [Min_val_subcomb,Ind_subcomb]=select_min_distance_mex(X_sub,Y_sub);
            
            if c==1
                Min_val_subvoxel=Min_val_subcomb;
                Ind_subvoxel=Ind_subcomb;
            else
                Min_val_subvoxel=vertcat(Min_val_subvoxel,Min_val_subcomb);
                Ind_subvoxel=vertcat(Ind_subvoxel,Ind_subcomb);
            end
        end
        
        [temp_val, temp_ind]=min(Min_val_subvoxel,[],1);
        
        for k=1:1:size(temp_ind,2)
            Ind(1,k)=(temp_ind(1,k)-1)*100000+Ind_subvoxel(temp_ind(1,k),k);
        end

        if v ==1
            Ind_final=Ind; 
        else
            Ind_final=horzcat(Ind_final, Ind);
        end

    end



end




%% Making PCDE input

for i=1:1:size(vec_PET,1)
    Measured_data(:,i)=vec_PET{i,1}; % PCDE input type
end


%% Test

for p=1:1:size(PI_Time,2)
    X_plot(p,1)=X_4D_Patlak(1,1,1,p);
    Y_plot(p,1)=Y_4D_Patlak(1,1,1,p);
end


% validation of RE algorithm for 2TCM
x=[10,20,30,40,50,60,70,80,90];
y=[30.110613,18.200102,8.3924160,5.4120741,2.5553353,0.70682716,0.35739726,0.62102932,0.014534704];
Starting_TTCM=[0.5;0.5;0.05;0.05];
LB_TTCM=[0;0;0;0]; 
UB_TTCM=[1;1;1;1]; 
[Estimates,SSE,Residual,d,e,f,Jacobian]=lsqcurvefit(@TTCM_analytic, Starting_TTCM, x,y, LB_TTCM, UB_TTCM);
[ci, se]=nlparci(Estimates, Residual, 'jacobian', Jacobian);

x_gpu_temp=repmat(x,1,9);
J=Get_Jacobian(Estimates,x,9,2);
Num_inlier=9;
inlierIdx=repmat(1,9,1);
[RE, se_update]=Get_RE(J, Estimates,SSE,9, Num_inlier,inlierIdx ,2);


RE=(se./Estimates)*100; % [21.049,30.67,278.81, 150.94]
%RE[%]=[3.3416e+03, 4.1529e+03, 2.9252e+03, 327.2466]

%% Denoising study
PI_Time=[10,20,30,40,50,60,70,80,90];
Y_True=[25.46125,12.56024,5.62571,2.47724,1.08735,0.47698,0.20921,0.09176,0.04025];
Y_N10=[19.40712,11.00392,4.756,2.3586,0.81944,0.49364,0.22953,0.07808,0.03976];
Y_N30=[22.07983,8.58002,5.28838,1.18516,0.6883,0.52169,0.10062,0.13316,0.02437];
Y_N50=[26.36245,17.60226,5.17312,3.82309,1.53206,0.5286,0.41191,0.08723,0.05019];

Y_N10_filt_moving= smooth(Y_N10, 'moving');
Y_N10_filt_sgolay=smooth(Y_N10,'sgolay');
Y_N10_filt_lowess=smooth(Y_N10,'lowess');
Y_N10_filt_loess=smooth(Y_N10,'loess');

Y_N30_filt_moving= smooth(Y_N30, 'moving');
Y_N30_filt_sgolay=smooth(Y_N30,'sgolay');
Y_N30_filt_lowess=smooth(Y_N30,'lowess');
Y_N30_filt_loess=smooth(Y_N30,'loess');

Y_N50_filt_moving= smooth(Y_N50, 'moving');
Y_N50_filt_sgolay=smooth(Y_N50,'sgolay');
Y_N50_filt_lowess=smooth(Y_N50,'lowess');
Y_N50_filt_loess=smooth(Y_N50,'loess');

ln_Y_True=transpose(log(Y_True));
ln_Y_N10_moving=log(Y_N10_filt_moving);
ln_Y_N10_sgolay=log(Y_N10_filt_sgolay);
ln_Y_N10_lowess=log(Y_N10_filt_lowess);
ln_Y_N10_loess=log(Y_N10_filt_loess);
ln_Y_N30_moving=log(Y_N30_filt_moving);
ln_Y_N30_sgolay=log(Y_N30_filt_sgolay);
ln_Y_N30_lowess=log(Y_N30_filt_lowess);
ln_Y_N30_loess=log(Y_N30_filt_loess);
ln_Y_N50_moving=log(Y_N50_filt_moving);
ln_Y_N50_sgolay=log(Y_N50_filt_sgolay);
ln_Y_N50_lowess=log(Y_N50_filt_lowess);
ln_Y_N50_loess=log(Y_N50_filt_loess);

ln_Y_N10_Nsmooth=transpose(log(Y_N10));
ln_Y_N30_Nsmooth=transpose(log(Y_N30));
ln_Y_N50_Nsmooth=transpose(log(Y_N50));

ln_SSE_N10_moving=sum(((abs(ln_Y_True-ln_Y_N10_moving)).^(2)),'all');
ln_SSE_N10_sgolay=sum(((abs(ln_Y_True-ln_Y_N10_sgolay)).^(2)),'all');
ln_SSE_N10_lowess=sum(((abs(ln_Y_True-ln_Y_N10_lowess)).^(2)),'all');
ln_SSE_N10_loess=sum(((abs(ln_Y_True-ln_Y_N10_loess)).^(2)),'all');
ln_SSE_N10_Nsmooth=sum(((abs(ln_Y_True-ln_Y_N10_Nsmooth)).^(2)),'all');

ln_SSE_N30_moving=sum(((abs(ln_Y_True-ln_Y_N30_moving)).^(2)),'all');
ln_SSE_N30_sgolay=sum(((abs(ln_Y_True-ln_Y_N30_sgolay)).^(2)),'all');
ln_SSE_N30_lowess=sum(((abs(ln_Y_True-ln_Y_N30_lowess)).^(2)),'all');
ln_SSE_N30_loess=sum(((abs(ln_Y_True-ln_Y_N30_loess)).^(2)),'all');
ln_SSE_N30_Nsmooth=sum(((abs(ln_Y_True-ln_Y_N30_Nsmooth)).^(2)),'all');

ln_SSE_N50_moving=sum(((abs(ln_Y_True-ln_Y_N50_moving)).^(2)),'all');
ln_SSE_N50_sgolay=sum(((abs(ln_Y_True-ln_Y_N50_sgolay)).^(2)),'all');
ln_SSE_N50_lowess=sum(((abs(ln_Y_True-ln_Y_N50_lowess)).^(2)),'all');
ln_SSE_N50_loess=sum(((abs(ln_Y_True-ln_Y_N50_loess)).^(2)),'all');
ln_SSE_N50_Nsmooth=sum(((abs(ln_Y_True-ln_Y_N50_Nsmooth)).^(2)),'all');

% Linear fit
PI_Time=[10,20,30,40,50,60,70,80,90];
Y_True=[25.46125,12.56024,5.62571,2.47724,1.08735,0.47698,0.20921,0.09176,0.04025];
Y_N10=[19.40712,11.00392,4.756,2.3586,0.81944,0.49364,0.22953,0.07808,0.03976];
Y_N30=[22.07983,8.58002,5.28838,1.18516,0.6883,0.52169,0.10062,0.13316,0.02437];
Y_N50=[26.36245,17.60226,5.17312,3.82309,1.53206,0.5286,0.41191,0.08723,0.05019];

ln_Y_True=transpose(log(Y_True));
ln_Y_N10=transpose(log(Y_N10));

Starting_Ln_Linear=[4.13,-0.08];
[Estimates_Linear,SSE,Residual,d,e,f,Jacobian]=lsqcurvefit(@Linear_Fit, Starting_Ln_Linear, transpose(PI_Time),ln_Y_N10);
Linear_Scale_Linear_SSE_N10= sum( ( exp(Linear_Fit(Estimates_Linear,PI_Time(:))) - Y_True).^(2), 'all');

Plot_Ln_Linear_X=transpose([10:1:90]);
Plot_Ln_Linear_Y_N10=exp(Linear_Fit(Estimates_Linear,Plot_Ln_Linear_X));



% True data for whole range
True_params=[0.95,0.75,0.47,0.48]; % [K1,k2,k3,k4]
Whole_Time=transpose([0:1:90]);
True_val=TTCM_analytic(True_params,Whole_Time);

%% Exp fit
PI_Time=[10,20,30,40,50,60,70,80,90];
Y_True=[25.46125,12.56024,5.62571,2.47724,1.08735,0.47698,0.20921,0.09176,0.04025];
Y_N10=[19.40712,11.00392,4.756,2.3586,0.81944,0.49364,0.22953,0.07808,0.03976];
Y_N30=[22.07983,8.58002,5.28838,1.18516,0.6883,0.52169,0.10062,0.13316,0.02437];
Y_N50=[26.36245,17.60226,5.17312,3.82309,1.53206,0.5286,0.41191,0.08723,0.05019];

Starting_Lin_Exp=[37,15,-0.3];
[Estimates_Exp,SSE,Residual,d,e,f,Jacobian]=lsqcurvefit(@Lin_Exp, Starting_Lin_Exp, transpose(PI_Time),transpose(Y_N10));
Linear_Scale_Exp_SSE_N10= sum( (Lin_Exp(Estimates_Exp,PI_Time(:)) - Y_True).^(2), 'all');

Plot_Lin_Exp_X=transpose([10:1:90]);
Plot_Lin_Exp_Y_N10=Lin_Exp(Estimates_Exp,Plot_Lin_Exp_X);


%% Weighted_Linear Fit
PI_Time=[10,20,30,40,50,60,70,80,90];
Y_True=[25.46125,12.56024,5.62571,2.47724,1.08735,0.47698,0.20921,0.09176,0.04025];
Y_N10=[19.40712,11.00392,4.756,2.3586,0.81944,0.49364,0.22953,0.07808,0.03976];
Y_N30=[22.07983,8.58002,5.28838,1.18516,0.6883,0.52169,0.10062,0.13316,0.02437];
Y_N50=[26.36245,17.60226,5.17312,3.82309,1.53206,0.5286,0.41191,0.08723,0.05019];

[Estimates_Exp,SSE,Residual,d,e,f,Jacobian]=lsqcurvefit(@Linear_Fit, Starting_Ln_Linear, transpose(PI_Time),transpose(Y_N10));


%% Getting Whole TAC curves
Whole_Time=[0:1:90];
[permutes,True_TACs]=make_database_NH(Whole_Time);
True_TACs_transposed=transpose(True_TACs(6000000:6005000,:));

Plot_X=transpose(Whole_Time);
Plot_Y=True_TACs_transposed;

%% Sensitivity Analysis
Whole_Time=[0:1:90];
[permutes,True_TACs]=make_database_NH(Whole_Time);

load("Local_Estimates.mat");
syms k1 k2 k3 k4 alpha_TTCM beta_TTCM A1 A2 A3 A4 B1 B2 B3 B4 x C_tot
alpha_TTCM=  ( (k2+k3+k4) + (((k2+k3+k4)^2)-(4*k2*k4))^(0.5) ) / 2;
beta_TTCM=   ( (k2+k3+k4) - (((k2+k3+k4)^2)-(4*k2*k4))^(0.5) ) / 2;
C_tot= ( ((k1*(alpha_TTCM-k4)-k1*k3)/(alpha_TTCM-beta_TTCM)) * (((A1/(alpha_TTCM-B1))*(exp(-1*B1*x)-exp(-1*alpha_TTCM*x))) + ((A2/(alpha_TTCM-B2))*(exp(-1*B2*x)-exp(-1*alpha_TTCM*x))) + ((A3/(alpha_TTCM-B3))*(exp(-1*B3*x)-exp(-1*alpha_TTCM*x))) + ((A4/(alpha_TTCM-B4))*(exp(-1*B4*x)-exp(-1*alpha_TTCM*x)))) ) + ( ((k1*k3-(k1*(beta_TTCM-k4)))/(alpha_TTCM-beta_TTCM)) * (((A1/(beta_TTCM-B1))*(exp(-1*B1*x)-exp(-1*beta_TTCM*x))) + ((A2/(beta_TTCM-B2))*(exp(-1*B2*x)-exp(-1*beta_TTCM*x))) + ((A3/(beta_TTCM-B3))*(exp(-1*B3*x)-exp(-1*beta_TTCM*x))) + ((A4/(beta_TTCM-B4))*(exp(-1*B4*x)-exp(-1*beta_TTCM*x)))) ) ;
par_diff_k1= matlabFunction(diff(C_tot, k1));
par_diff_k2= matlabFunction(diff(C_tot, k2));
par_diff_k3= matlabFunction(diff(C_tot, k3));
par_diff_k4= matlabFunction(diff(C_tot, k4));
A1=Local_Estimates(1);
B1=Local_Estimates(2);
A2=Local_Estimates(3);
B2=Local_Estimates(4);
A3=Local_Estimates(5);
B3=Local_Estimates(6);
A4=Local_Estimates(7);
B4=Local_Estimates(8);

% Absolute Sensitivity
par_diff_k1_val=par_diff_k1(A1,A2,A3,A4,B1,B2,B3,B4,permutes(:,2),permutes(:,3),permutes(:,4),Whole_Time);
Mean_diff_k1_val=transpose(mean(par_diff_k1_val,1));
SD_diff_k1_val=transpose(std(par_diff_k1_val,1));
par_diff_k2_val=par_diff_k2(A1,A2,A3,A4,B1,B2,B3,B4,permutes(:,1),permutes(:,2),permutes(:,3),permutes(:,4),Whole_Time);
Mean_diff_k2_val=transpose(mean(abs(par_diff_k2_val),1));
SD_diff_k2_val=transpose(std(par_diff_k2_val,1));
par_diff_k3_val=par_diff_k3(A1,A2,A3,A4,B1,B2,B3,B4,permutes(:,1),permutes(:,2),permutes(:,3),permutes(:,4),Whole_Time);
Mean_diff_k3_val=transpose(mean(par_diff_k3_val,1));
SD_diff_k3_val=transpose(std(par_diff_k3_val,1));
par_diff_k4_val=par_diff_k4(A1,A2,A3,A4,B1,B2,B3,B4,permutes(:,1),permutes(:,2),permutes(:,3),permutes(:,4),Whole_Time);
Mean_diff_k4_val=transpose(mean(abs(par_diff_k4_val),1));
SD_diff_k4_val=transpose(std(par_diff_k4_val,1));

% Relative Sensitivity
Total_diff_slope_val=Mean_diff_k1_val+Mean_diff_k2_val+Mean_diff_k3_val+Mean_diff_k4_val;
Rel_Mean_diff_k1_val=Mean_diff_k1_val./Total_diff_slope_val*100;
Rel_Mean_diff_k1_val(isnan(Rel_Mean_diff_k1_val)) = 0;
Rel_Mean_diff_k2_val=Mean_diff_k2_val./Total_diff_slope_val*100;
Rel_Mean_diff_k2_val(isnan(Rel_Mean_diff_k2_val)) = 0;
Rel_Mean_diff_k3_val=Mean_diff_k3_val./Total_diff_slope_val*100;
Rel_Mean_diff_k3_val(isnan(Rel_Mean_diff_k3_val)) = 0;
Rel_Mean_diff_k4_val=Mean_diff_k4_val./Total_diff_slope_val*100;
Rel_Mean_diff_k4_val(isnan(Rel_Mean_diff_k4_val)) = 0;

%% K-probability
Whole_Time=[0:1:90];
[permutes,True_TACs]=make_database_NH(Whole_Time);
True_TACs_subset=True_TACs(1:10,:);
% Picking specific Ct(ti)
%Ct=True_TACs(11,:); % picking data at 10 [min]
Ct=True_TACs_subset(:,11); % picking data at 10 [min]
Ct_int=round(Ct,1);
Ct_unique=unique(Ct_int);
Num_Ct=size(Ct_int,1);
Num_Ct_unique=size(Ct_unique,1);
avail_k1=transpose(unique(permutes(1:10,1)));
avail_k2=transpose(unique(permutes(1:10,2)));
avail_k3=transpose(unique(permutes(1:10,3)));
avail_k4=transpose(unique(permutes(1:10,4)));
for i=1:1:Num_Ct_unique
    Ct_subset{i,1}=(Ct_unique(i)==Ct_int(:)).*Ct_int;
    Probable_k1{i,1}=permutes(find(Ct_subset{i,1}== Ct_unique(i)),1);
    Probable_k2{i,1}=permutes(find(Ct_subset{i,1}== Ct_unique(i)),2);
    Probable_k3{i,1}=permutes(find(Ct_subset{i,1}== Ct_unique(i)),3);
    Probable_k4{i,1}=permutes(find(Ct_subset{i,1}== Ct_unique(i)),4);
end
for i=1:1:Num_Ct_unique
    Prob_X=transpose(unique(Probable_k1{i,1}));
    for j=1:1:size(Prob_X,2)
        Prob_Y(j)=size(find(Probable_k1{i,1}==Prob_X(j)),1)/size(Probable_k1{i,1},1);
    end
    Prob_k1{i,1}{1,1}=Prob_X;
    Prob_k1{i,1}{1,2}=Prob_Y;
    clear Prob_X Prob_Y
    Prob_X=transpose(unique(Probable_k2{i,1}));
    for j=1:1:size(Prob_X,2)
        Prob_Y(j)=size(find(Probable_k2{i,1}==Prob_X(j)),1)/size(Probable_k2{i,1},1);
    end
    Prob_k2{i,1}{1,1}=Prob_X;
    Prob_k2{i,1}{1,2}=Prob_Y;
    clear Prob_X Prob_Y
    Prob_X=transpose(unique(Probable_k3{i,1}));
    for j=1:1:size(Prob_X,2)
        Prob_Y(j)=size(find(Probable_k3{i,1}==Prob_X(j)),1)/size(Probable_k3{i,1},1);
    end
    Prob_k3{i,1}{1,1}=Prob_X;
    Prob_k3{i,1}{1,2}=Prob_Y;
    clear Prob_X Prob_Y
    Prob_X=transpose(unique(Probable_k4{i,1}));
    for j=1:1:size(Prob_X,2)
        Prob_Y(j)=size(find(Probable_k4{i,1}==Prob_X(j)),1)/size(Probable_k4{i,1},1);
    end
    Prob_k4{i,1}{1,1}=Prob_X;
    Prob_k4{i,1}{1,2}=Prob_Y;
    clear Prob_X Prob_Y
end

True_C=TTCM_analytic([0.5,0.5,0.01,0.03],10)
Ct_measured=True_C+ (True_C*10*0.01*randn(1,1));
Prob_Ct_unique = normpdf(Ct_unique,Ct_measured,Ct_measured*0.1);

True_C=10.5697;
Ct_measured=12.5081;

for i=1:1:Num_Ct_unique
    Prob_k1{i,1}{1,3}=Prob_Ct_unique(i).*Prob_k1{i,1}{1,2};
    Prob_k2{i,1}{1,3}=Prob_Ct_unique(i).*Prob_k2{i,1}{1,2};
    Prob_k3{i,1}{1,3}=Prob_Ct_unique(i).*Prob_k3{i,1}{1,2};
    Prob_k4{i,1}{1,3}=Prob_Ct_unique(i).*Prob_k4{i,1}{1,2};
end
Weighted_Prob_k1=zeros(1,size(avail_k1,2));
for k=1:1:size(avail_k1,2)
    temp=zeros(Num_Ct_unique,1);
    for i=1:1:Num_Ct_unique
        temp(i)=sum(Prob_k1{i,1}{1,3}(find(Prob_k1{i,1}{1,1}==avail_k1(k))), 'all');
    end
    Weighted_Prob_k1(1,k)=sum(temp,'all');
end
Weighted_Prob_k2=zeros(1,size(avail_k2,2));
for k=1:1:size(avail_k2,2)
    temp=zeros(Num_Ct_unique,1);
    for i=1:1:Num_Ct_unique
        temp(i)=sum(Prob_k2{i,1}{1,3}(find(Prob_k2{i,1}{1,1}==avail_k2(k))), 'all');
    end
    Weighted_Prob_k2(1,k)=sum(temp,'all');
end
Weighted_Prob_k3=zeros(1,size(avail_k3,2));
for k=1:1:size(avail_k3,2)
    temp=zeros(Num_Ct_unique,1);
    for i=1:1:Num_Ct_unique
        temp(i)=sum(Prob_k3{i,1}{1,3}(find(Prob_k3{i,1}{1,1}==avail_k3(k))), 'all');
    end
    Weighted_Prob_k3(1,k)=sum(temp,'all');
end
Weighted_Prob_k4=zeros(1,size(avail_k4,2));
for k=1:1:size(avail_k4,2)
    temp=zeros(Num_Ct_unique,1);
    for i=1:1:Num_Ct_unique
        temp(i)=sum(Prob_k4{i,1}{1,3}(find(Prob_k4{i,1}{1,1}==avail_k4(k))), 'all');
    end
    Weighted_Prob_k4(1,k)=sum(temp,'all');
end

[Max_val,Max_ind]=max(Weighted_Prob_k1);
Most_Probable_k1=avail_k1(find(Weighted_Prob_k1==Max_val));
[Max_val,Max_ind]=max(Weighted_Prob_k2);
Most_Probable_k2=avail_k2(find(Weighted_Prob_k2==Max_val));
[Max_val,Max_ind]=max(Weighted_Prob_k3);
Most_Probable_k3=avail_k3(find(Weighted_Prob_k3==Max_val));
[Max_val,Max_ind]=max(Weighted_Prob_k4);
Most_Probable_k4=avail_k4(find(Weighted_Prob_k4==Max_val));

Num_comb=size(Most_Probable_k1,2)*size(Most_Probable_k2,2)*size(Most_Probable_k3,2)*size(Most_Probable_k4,2);

Comb=permn([Most_Probable_k1,Most_Probable_k2,Most_Probable_k3,Most_Probable_k4],4);

for i=1:1:size(Most_Probable_k1,2)
    k1_logic= (Comb(:,1) ~= Most_Probable_k1(i)) ;
    if i==1
        k1_logic_cumul=k1_logic;
    else
        k1_logic_cumul=k1_logic.*k1_logic_cumul;
    end
end
for i=1:1:size(Most_Probable_k2,2)
    k2_logic= (Comb(:,2) ~= Most_Probable_k2(i)) ;
    if i==1
        k2_logic_cumul=k2_logic;
    else
        k2_logic_cumul=k2_logic.*k2_logic_cumul;
    end
end
for i=1:1:size(Most_Probable_k3,2)
    k3_logic= (Comb(:,3) ~= Most_Probable_k3(i)) ;
    if i==1
        k3_logic_cumul=k3_logic;
    else
        k3_logic_cumul=k3_logic.*k3_logic_cumul;
    end
end
for i=1:1:size(Most_Probable_k4,2)
    k4_logic= (Comb(:,4) ~= Most_Probable_k4(i)) ;
    if i==1
        k4_logic_cumul=k4_logic;
    else
        k4_logic_cumul=k4_logic.*k4_logic_cumul;
    end
end
k_logic=logical(k1_logic_cumul+k2_logic_cumul+k3_logic_cumul+k4_logic_cumul);
Comb(k_logic,:)=[];

Comb=unique(Comb,'rows');

avg_Ct=mean(TTCM_analytic_Multi(Comb,11),'all');




%%

for i=1:1:125
vec_PET{i,1}=noisy(i,:);
end

for i=1:1:125
    vec_cell{i,1}=permutes(i,:);
end


%% generating ML training dataset

for i=1:1:125
    true=TTCM_analytic(permutes(i,:),[10:10:90]);
    true=repmat(true,100,1);
    noisy=true+(true*0.1.*randn(100,9));
    noisy(:,10)=i;
    if i==1
        noisy_update=noisy;
    else
        noisy_update=cat(1,noisy_update,noisy);
    end
end



%% Generating ML training dataset
PI_Time=[10:10:90];
Num_obser=10;
Num_Feat=10;
for i=1:1:size(permutes,1)
    %for o=1:1:Num_obser
        %%
        %true=TTCM_analytic(permutes(i,:),PI_Time);
        %Sequence{o,1}(1,:)=true+(true.*0.1.*randn(1,9));
        %Estimates_Ln_Linear=polyfit(PI_Time,log(Sequence{o,1}(1,:)),1);
        %Sequence{o,1}(2,:)=exp(Linear_Fit([Estimates_Ln_Linear(2), Estimates_Ln_Linear(1)],PI_Time));
        %Starting_Exp=[37,15,0];
        %lb_Exp=[0,0,0];
        %ub_Exp=[1000,1000,1000];
        %[Estimates_Exp,SSE,Residual,d,e,f,Jacobian]=lsqcurvefit(@Lin_Exp, Starting_Exp, PI_Time,Sequence{o,1}(1,:),lb_Exp,ub_Exp);
        %Sequence{o,1}(3,:)=Lin_Exp(Estimates_Exp,PI_Time);
    %end
    %%
    
    for o=1:1:Num_obser
        true=TTCM_analytic(permutes(i,:),PI_Time);
        true=repmat(true,Num_Feat,1);
        features=true+true.*0.1.*randn(Num_Feat,9);
        Sequence{o,1}=features;
    end
    if i==1
        Sequence_update=Sequence;
    else
        Sequence_update=cat(1,Sequence_update,Sequence);
    end 
end

for i=1:1:125
    if i==1
        Response_update=i*ones(Num_obser,1);
    else
        Response_update=cat(1,Response_update,i*ones(Num_obser,1));
    end
end
Response_update=categorical(Response_update);

% for Validation data
for i=1:1:125
    for o=1:1:Num_obser
        true=TTCM_analytic(permutes(i,:),PI_Time);
        true=repmat(true,Num_Feat,1);
        features=true+true.*0.1.*randn(Num_Feat,9);
        Sequence{o,1}=features;
    end
    if i==1
        X_Vali_update=Sequence;
    else
        X_Vali_update=cat(1,X_Vali_update,Sequence);
    end 
end

for i=1:1:125
    if i==1
        Y_Vali_update=i*ones(Num_obser,1);
    else
        Y_Vali_update=cat(1,Y_Vali_update,i*ones(Num_obser,1));
    end
end
Y_Vali_update=categorical(Y_Vali_update);



% Data Training
inputSize = Num_Feat;
numHiddenUnits = 250;
numClasses = 125;

layers = [ ...
    sequenceInputLayer(inputSize)
    bilstmLayer(numHiddenUnits,'OutputMode','last')
    fullyConnectedLayer(numClasses)
    softmaxLayer
    classificationLayer]

maxEpochs = 200;
miniBatchSize = 500;

options = trainingOptions('adam', ...
    'ExecutionEnvironment','auto', ...
    'BatchNormalizationStatistics', 'moving',...
    'MaxEpochs',maxEpochs, ...
    'MiniBatchSize',miniBatchSize, ...
    'SequenceLength','longest', ...
    'Shuffle','every-epoch', ...
    'Verbose',0, ...
    'Plots','training-progress',...
    'ValidationData',{X_Vali_update,Y_Vali_update}, ...
    'ValidationFrequency',30);


net = trainNetwork(Sequence_update,Response_update,layers,options);




pred=classify(net,Sequence_update);
acc = sum(pred == Response_update)./numel(Response_update)



%% Generating ML training dataset (not Time series!)
% Ct_10, slope, intercept, Exp_p1, Exp_p2, Exp_p3, Index
PI_Time=[10:10:90];
Num_obser=100;
for i=1:1:125
    true=TTCM_analytic(permutes(i,:),PI_Time);
    for o=1:1:Num_obser
        noisy=true+(true*0.1.*randn(1,9));
        Train_temp(o,1)=noisy(1,1);
        Estimates_Ln_Linear=polyfit(PI_Time,log(noisy),1);
        Train_temp(o,2)=Estimates_Ln_Linear(1);
        Train_temp(o,3)=Estimates_Ln_Linear(2);
        Starting_Exp=[37,15,0];
        lb_Exp=[0,0,0];
        ub_Exp=[1000,1000,1000];
        [Estimates_Exp,SSE,Residual,d,e,f,Jacobian]=lsqcurvefit(@Lin_Exp, Starting_Exp, PI_Time,noisy,lb_Exp,ub_Exp);
        Train_temp(o,4)=Estimates_Exp(1);
        Train_temp(o,5)=Estimates_Exp(2);
        Train_temp(o,6)=Estimates_Exp(3);
        Train_temp(o,7)=i;
    end
    if i==1
        Train=Train_temp;
    else
        Train=cat(1,Train,Train_temp);
    end
end

%% Generating Training data as Table
Num_obser=500;
for i=1:1:125
    true=TTCM_analytic(permutes(i,:),[10:10:90]);
    true=repmat(true,Num_obser,1);
    Table_temp=true+(true*0.1.*randn(Num_obser,9));
    Table_temp(:,10)=i;
    if i==1
        Table=Table_temp;
    else
        Table=cat(1,Table,Table_temp);
    end
end

%% for SNMMI (comparison of fitting speed: time[sec]/voxel)
% assumption: the # of data points = 16
t1=clock;
PI_Time=[10:10:160];
Ct=[1.3,2.7,3.3,4.2,5.7,6.3,7.9,8.9,9.1,10.4,11.6,12.7,13.9,14.3,15.5,16.7];
Starting=[0,0];
LB=[0,0];
UB=[10,10];
% Lsqcurvefit
for i=1:1:10000
    [Estimates_Lsq,SSE_Lsq,Residual,d,e,f,Jacobian]=lsqcurvefit(@Linear_Fit, Starting, PI_Time, Ct , LB, UB);
    if i==1
        Estimates=Estimates_Lsq;
    else
        Estimates=cat(1,Estimates, Estimates_Lsq);
    end
    [ci, se]=nlparci(Estimates_Lsq,Residual, 'jacobian', Jacobian);
    K_i(i)=Estimates(2);
    V_d(i)=Estimates(1);
    SE_K_i(i)=  se(2) / Estimates(2) *100;
    SE_V_d(i)=  se(1) / Estimates(1) *100;
end
t2=clock;
etime(t2,t1)/10000 % time[sec]/voxel

% Polyfit
t1=clock;
for i=1:1:10000
    Estimates_Poly=polyfit(PI_Time,Ct,1);
end
t2=clock;
etime(t2,t1)/10000 % time[sec]/voxel
% Gpufit (from the code)


%% Ki, Vd, Ki_RE, Vd_RE mapping!
axes1=subplot(1,4,1);
imshow(flip(transpose(squeeze(K_i_New(64,:,:)))));
set(axes1,'CLim',[0.001 1],'ColorScale','log');
colormap(axes1,gray);
colorbar(axes1);

axes1=subplot(1,4,2);
imshow(flip(transpose(squeeze(K_i_RE_New(64,:,:)))));
set(axes1,'CLim',[1 100],'ColorScale','log');
colormap(axes1,gray);
colorbar(axes1);

axes1=subplot(1,4,3);
imshow(flip(transpose(squeeze(V_d_New(64,:,:)))));
set(axes1,'CLim',[0.001 10],'ColorScale','log');
colormap(axes1,gray);
colorbar(axes1);

axes1=subplot(1,4,4);
imshow(flip(transpose(squeeze(V_d_RE_New(64,:,:)))));
set(axes1,'CLim',[1 100],'ColorScale','log');
colormap(axes1,gray);
colorbar(axes1);


%% Matlab with Python Library
% Matlab (with python library)
x=[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16];
y=[1.1, 2.3, 3.4, 4.6, 5.5, 6.1, 7.8, 8.9, 9.6, 10.6, 11.3, 12.5, 13.6, 14.5, 15.7, 16.9];
xdata=py.numpy.array(x);
ydata=py.numpy.array(y);
initial=py.numpy.array([0.5, 0.5]);
bounds_temp=py.numpy.array([0,0;1,1]);
bounds=py.tuple(bounds_temp);
args_temp=py.numpy.array([x;y]);
args=py.tuple(args_temp);
tic;
fit_result=py.scipy.optimize.curve_fit(@ py.Patlak_Python.Patlak, xdata, ydata, pyargs('p0',initial,'bounds',bounds));
toc;
Patlak_MAT_Python_Lib_Estimates=double(fit_result{1,1});

%% Tsting Finite Legendre Transform (with Python Module)
load('x_test.mat');
load('y_test.mat');
x_py=py.numpy.array(x);
y_py=py.numpy.array(y);
nl=17;
nl_py=py.numpy.array(nl);
FLT_results_py= py.LegendrePolynomials.LT(y_py,nl_py);	% FLT 
kmax=5;
kmax_py=py.numpy.array(kmax);
FLT_results=double(FLT_results_py);
FLT_results_truncated=FLT_results(1,1:kmax);
FLT_results_truncated_py=py.numpy.array(FLT_results_truncated);
num_p=474;
num_p_py=py.numpy.array(num_p);
iFLT_results_py=py.LegendrePolynomials.iLT(FLT_results_truncated_py,num_p_py); % iFLT
iFLT_results=transpose(double(iFLT_results_py));


x=transpose([10:10:90]);
y=[8.99516891223386;5.17011787447484;2.49449676701555;1.91551573439000;1.32082879910267;0.912254148531712;0.744571263946323;0.617374929755172;0.578065518846821];
x_py=py.numpy.array(x);
y_py=py.numpy.array(y);
nl=17; % Legendre Polynomial's max order
nl_py=py.numpy.array(nl);
FLT_results_py= py.LegendrePolynomials.LT(y_py,nl_py);	% FLT 
kmax=5; % cutoff order for denoising
kmax_py=py.numpy.array(kmax);
FLT_results=double(FLT_results_py);
FLT_results_truncated=FLT_results(1,1:kmax);
FLT_results_truncated_py=py.numpy.array(FLT_results_truncated);
num_p=9;
num_p_py=py.numpy.array(num_p);
iFLT_results_py=py.LegendrePolynomials.iLT(FLT_results_truncated_py,num_p_py); % iFLT
iFLT_results=transpose(double(iFLT_results_py));

Ct_True=[8.75967932590874;	4.73586617408567;	2.81210217562743;	1.83635300596401;	1.30010734757802;	0.976074188139496;	0.761070979195705;	0.606976676751502;	0.490334877578445];


%% For NSD vs NBias curve %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Input :  columns (1st: Mean MSE, 2st: Mean_Pred) at a specific Noise Level
Input=0.0;
% True values
        k_True=[0.01,0.36,0.03,0];
        k1_True=k_True(1);
        k2_True=k_True(2);
        k3_True=k_True(3);
        k4_True=k_True(4);
        Ki_True= (k_True(1)*k_True(3)) / (k_True(2)+k_True(3));
        Vd_True= (k_True(1)*k_True(2)) / ((k_True(2)+k_True(3))^2);
True=transpose([k_True,Ki_True,Vd_True,k_True,Ki_True,Vd_True,k_True,Ki_True,Vd_True,Ki_True,Vd_True]);

NBias=transpose([0:1:50]);
for i=1:1:size(Input,1)
    NSD_temp= real( (100/Input(i,2)).*( (Input(i,1)-((True(i,1)/100.*NBias).^(2))).^(0.5)) );
    if i==1
        NSD=NSD_temp;
    else
        NSD=cat(2,NSD,NSD_temp);
    end
    
    %NSD{i,1}(NSD{i,1}==0)=[];
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Testing noise model
load("Local_Estimates.mat");
k1_True=0.86;
k2_True=0.98;
k3_True=0.01;
k4_True=0;
k_True=[k1_True,k2_True,k3_True,k4_True]; % Normal Liver
Ki_True= (k_True(1)*k_True(3)) / (k_True(2)+k_True(3));
Vd_True= (k_True(1)*k_True(2)) / ((k_True(2)+k_True(3))^2);
PI_Time=[10:10:90];
% True & Noisy data
%Num_real=100;
Ct_True=TTCM_analytic_Multi(k_True,PI_Time);
Ct_True=repmat(Ct_True,5,1);
Ct_Mean=mean(Ct_True,'all');
Ct_Noisy=Ct_True + (Ct_Mean.*20.*0.01.*randn(5,size(PI_Time,2)));
Ct_Noisy(Ct_Noisy < 0)=0; % to remove negative values

x_py=py.numpy.array(transpose(PI_Time));
y_py=py.numpy.array(transpose(Ct_True(1,:)));

FLT_results_py= py.LegendrePolynomials.LT(y_py,py.numpy.array(50));	% FLT 
FLT_results=double(FLT_results_py);

for i=1:1:size(Ct_Noisy,1)
    y_py=py.numpy.array(transpose(Ct_Noisy(i,:)));
    FLT_results_py= py.LegendrePolynomials.LT(y_py,py.numpy.array(50));	% FLT
    FLT_results=double(FLT_results_py);
    if i==1
        FLT_results_all= transpose(FLT_results);
    else
        FLT_results_all=cat(2,FLT_results_all,transpose(FLT_results));
    end
end

kmax=5;
FLT_results_truncated=transpose(FLT_results_all(1:kmax,:));
for i=1:1:size(Ct_Noisy,1) 
    iFLT_results_py=py.LegendrePolynomials.iLT(py.numpy.array(FLT_results_truncated(i,:)),py.numpy.array(size(PI_Time,2))); % iFLT
    iFLT_results=double(iFLT_results_py);
    if i==1
        iFLT_results_all=transpose(iFLT_results);
    else
        iFLT_results_all=cat(2,iFLT_results_all,transpose(iFLT_results));
    end
end
iFLT_results_all(iFLT_results_all < 0)=0; % to remove negative values


%% Generation of Input Function for FDG
k1_True=0.86;
k2_True=0.98;
k3_True=0.01;
k4_True=0;
k_True=[k1_True,k2_True,k3_True,k4_True]; % Normal Liver
Ki_True= (k_True(1)*k_True(3)) / (k_True(2)+k_True(3));
Vd_True= (k_True(1)*k_True(2)) / ((k_True(2)+k_True(3))^2);
% K_i & V_d true (assumption: fractional blood volume in a voxel, Vb==0)
PI_Time=[0:0.1:90];
%Local_Estimates=[0.587,88.9,0.91,0.68,6.66,0.21,0.012];
%Local_Estimates=[0.613,3.1,0.027,0.020,7.42,0.22,0.012];
Local_Estimates=[0.735,851.1,21.88,20.81,4.134,0.1191,0.01043];
Func_Feng=@(tau) Feng(Local_Estimates,tau);
Cp=Feng(Local_Estimates,PI_Time);

% pre-processing for Patlak method (since Patlak model is just approximated form of 2TCM, we need to have seperate Ct_noisy data for Patlak!)
for p=1:1:size(PI_Time,2)
    Ct_True_Patlak(p)=(Ki_True*integral(Func_Feng, 0, PI_Time(p), 'ArrayValued',true)) + (Vd_True*Cp(p));
end
for p=1:1:size(PI_Time,2)
    X_Patlak(p)=integral(Func_Feng, 0, PI_Time(p), 'ArrayValued',true)/Cp(p);
    Y_Patlak(p)=Ct_True_Patlak(p)/Cp(p);
end

% Fitting with Exp_4
Global_optim_problem=createOptimProblem('lsqcurvefit','objective',@Exp_4, 'x0', [1;1;1;1;0;0;0;0], 'lb', [-1000;-1000;-1000;-1000;0;0;0;-1000],'ub', [10000;10000;10000;10000;10000;10000;10000;10000], 'xdata', transpose([0:0.1:90]),'ydata', Cp);
%Global_optim_problem=createOptimProblem('lsqcurvefit','objective',@Exp_4, 'x0', [1;1;1;1;1;1;1;1],'xdata', transpose([0:0.1:90]),'ydata', Cp);
Global_ms=MultiStart("PlotFcn", @gsplotbestf);
[Global_Estimates,Global_SSE]=run(Global_ms, Global_optim_problem, 5000);

Estimated_curve_Y=Exp_4(Global_Estimates,transpose([0:0.1:90]));



% Making full database
permutes=tall(single(combinator(100,4,'p', 'r'))*single(0.01)); % 0~1
permutes2=[permutes(:,1),permutes(:,2)+1.0, permutes(:,3), permutes(:,4)]; % 1~2
permutes3=[permutes(:,1),permutes(:,2)+2.0, permutes(:,3), permutes(:,4)]; % 2~3
permutes4=[permutes(:,1),permutes(:,2)+3.0, permutes(:,3), permutes(:,4)]; % 3~4
permutes5=[permutes(:,1),permutes(:,2)+4.0, permutes(:,3), permutes(:,4)]; % 4~5
permutes_total=[permutes;permutes2;permutes3;permutes4;permutes5];

% Making full database for FDG (k4=0)
permutes=tall(single(combinator(100,3,'p', 'r'))*single(0.01)); % 0~1
permutes(:,4)=0;
permutes2=[permutes(:,1),permutes(:,2)+1.0, permutes(:,3), permutes(:,4)]; % 1~2
permutes3=[permutes(:,1),permutes(:,2)+2.0, permutes(:,3), permutes(:,4)]; % 2~3
permutes4=[permutes(:,1),permutes(:,2)+3.0, permutes(:,3), permutes(:,4)]; % 3~4
permutes5=[permutes(:,1),permutes(:,2)+4.0, permutes(:,3), permutes(:,4)]; % 4~5
permutes_total_FDG=[permutes;permutes2;permutes3;permutes4;permutes5];

true_database_FDG=TTCM_analytic_Multi(permutes_total_FDG, [10:10:90]);

%% RMSE calculation (the effectiveness of FLT for denoising)

% for Noisy data
Squared_E=(Ct_Noisy-Ct_True).^(2);
R_Sum_Squared_E=(sum(Squared_E,2)).^(0.5);
RMSE=mean(R_Sum_Squared_E);

% for Denoised data
De_Squared_E=(Ct_Denoisy-Ct_True).^(2);
De_R_Sum_Squared_E=(sum(De_Squared_E,2)).^(0.5);
De_RMSE=mean(De_R_Sum_Squared_E);



%% C_tot slope graph with time %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
syms k1 k2 k3 k4 alpha_TTCM beta_TTCM A1 A2 A3 A4 B1 B2 B3 B4 x C_tot
alpha_TTCM=  ( (k2+k3+k4) + (((k2+k3+k4)^2)-(4*k2*k4))^(0.5) ) / 2;
beta_TTCM=   ( (k2+k3+k4) - (((k2+k3+k4)^2)-(4*k2*k4))^(0.5) ) / 2;
C_tot= ( ((k1*(alpha_TTCM-k4)-k1*k3)/(alpha_TTCM-beta_TTCM)) * (((A1/(alpha_TTCM-B1))*(exp(-1*B1*x)-exp(-1*alpha_TTCM*x))) + ((A2/(alpha_TTCM-B2))*(exp(-1*B2*x)-exp(-1*alpha_TTCM*x))) + ((A3/(alpha_TTCM-B3))*(exp(-1*B3*x)-exp(-1*alpha_TTCM*x))) + ((A4/(alpha_TTCM-B4))*(exp(-1*B4*x)-exp(-1*alpha_TTCM*x)))) ) + ( ((k1*k3-(k1*(beta_TTCM-k4)))/(alpha_TTCM-beta_TTCM)) * (((A1/(beta_TTCM-B1))*(exp(-1*B1*x)-exp(-1*beta_TTCM*x))) + ((A2/(beta_TTCM-B2))*(exp(-1*B2*x)-exp(-1*beta_TTCM*x))) + ((A3/(beta_TTCM-B3))*(exp(-1*B3*x)-exp(-1*beta_TTCM*x))) + ((A4/(beta_TTCM-B4))*(exp(-1*B4*x)-exp(-1*beta_TTCM*x)))) ) ;
par_diff_k1= matlabFunction(diff(C_tot, k1));
par_diff_k2= matlabFunction(diff(C_tot, k2));
par_diff_k3= matlabFunction(diff(C_tot, k3));
par_diff_k4= matlabFunction(diff(C_tot, k4));
A1=Local_Estimates(1);
B1=Local_Estimates(2);
A2=Local_Estimates(3);
B2=Local_Estimates(4);
A3=Local_Estimates(5);
B3=Local_Estimates(6);
A4=Local_Estimates(7);
B4=Local_Estimates(8);
k1=0.5;
k2=0.5;
k3=0.5;
k4=0.5;
par_diff_k1_val=par_diff_k1(A1,A2,A3,A4,B1,B2,B3,B4,k2,k3,k4,transpose([0:0.1:100]));
par_diff_k2_val=par_diff_k2(A1,A2,A3,A4,B1,B2,B3,B4,k1,k2,k3,k4,transpose([0:0.1:100]));
par_diff_k3_val=par_diff_k3(A1,A2,A3,A4,B1,B2,B3,B4,k1,k2,k3,k4,transpose([0:0.1:100]));
par_diff_k4_val=par_diff_k4(A1,A2,A3,A4,B1,B2,B3,B4,k1,k2,k3,k4,transpose([0:0.1:100]));

k1_list=[0:0.1:1];
k2_list=[0:0.1:1];
k3=[0:0.1:1];
k4=0.0;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Calculation of Slope at the time point

Ct_True=TTCM_analytic_Multi([0.86,0.98,0.01,0],[10:10:90]); % with Exp_4
dydx_True = diff(Ct_True) ./ diff(PI_Time);

Simil_1=TTCM_analytic_Multi([0.42,0.48,0.01,0],[10:10:90]); % with Exp_4
Simil_2=TTCM_analytic_Multi([0.41,0.47,0.01,0],[10:10:90]); % with Exp_4
Simil_3=TTCM_analytic_Multi([0.43,0.49,0.01,0],[10:10:90]); % with Exp_4
dydx_1 = diff(Simil_1) ./ diff(PI_Time);
dydx_2 = diff(Simil_2) ./ diff(PI_Time);
dydx_3 = diff(Simil_3) ./ diff(PI_Time);



dydx=[dydx_True;dydx_1;dydx_2;dydx_3;dxdy_noisy];

diff_slope=[sum(dxdy_noisy-dydx_True);sum(dxdy_noisy-dydx_1);sum(dxdy_noisy-dydx_2);sum(dxdy_noisy-dydx_3)];





global Local_Estimates
Local_Estimates=[17.86;0.00841;-3423.59;1.23;3348.58;1.13929;17.67;0.06774]; % Params for FDG with Exp_4 generated from Feng's graph for FDG
PI_Time=[10:10:90];
selected_comb=[0.86,0.98,0.01,0;0.42,0.48,0.01,0;0.41,0.47,0.01,0;0.43,0.49,0.01,0];
selected_Ct=TTCM_analytic_Multi(selected_comb,[10:1:90]);
Noisy=[28.10206,20.05989,23.06002,22.74449,20.38858,18.74983,18.30985,19.35043,23.65045];


slope= gradient(selected_Ct,1,2)./ repmat(gradient([10:1:90]),size(selected_Ct,1),1) ;
acc= gradient(slope,1,2) ./ repmat(gradient([10:1:90]),size(selected_Ct,1),1);

slope_Noisy= gradient(Noisy)./ gradient(PI_Time) ;
acc_Noisy= gradient(slope_Noisy) ./ gradient(PI_Time);

diff_slope=abs(slope_Noisy(1)-slope(:,1));
diff_acc=abs(acc_Noisy(1)-acc(:,1));

diff_all=diff_slope+diff_acc;



%% using overall slope
global Local_Estimates
Local_Estimates=[17.86;0.00841;-3423.59;1.23;3348.58;1.13929;17.67;0.06774]; % Params for FDG with Exp_4 generated from Feng's graph for FDG
PI_Time=[10:10:90];
PI_Time_database=[10:1:90];
selected_comb=[0.86,0.98,0.01,0;0.42,0.48,0.01,0;0.41,0.47,0.01,0;0.43,0.49,0.01,0];
selected_Ct=TTCM_analytic_Multi(selected_comb,PI_Time_database);
Noisy=[28.10206,20.05989,23.06002,22.74449,20.38858,18.74983,18.30985,19.35043,23.65045];

for i=1:1:(size(PI_Time_database,2)-1)
    slope_long(:,i)=(selected_Ct(:,size(PI_Time_database,2)-(i-1))-selected_Ct(:,1)) ./ (PI_Time_database(size(PI_Time_database,2)-(i-1))-PI_Time_database(1)) ;
end

for i=1:1:(size(PI_Time,2)-1)
    slope_long_Noisy(:,i)= (Noisy(:,size(PI_Time,2)-(i-1))-Noisy(:,1)) ./ (PI_Time(size(PI_Time,2)-(i-1))-PI_Time(1)) ;
end

for i=1:1:(size(PI_Time,2)-1)
    ind=find(PI_Time_database==PI_Time(i));
    slope_long_PI_Time(:,i)=slope_long(:,ind);
end


diff_slope_long=abs(slope_long_PI_Time-repmat(slope_long_Noisy,size(selected_comb,1),1)); 
diff_slope_long_first=diff_slope_long(:,1);
[min_val,min_ind]=min(diff_slope_long_first);

comb=selected_comb(min_ind,:);









