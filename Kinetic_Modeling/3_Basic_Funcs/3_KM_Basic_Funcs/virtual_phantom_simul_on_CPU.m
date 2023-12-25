function [Mean_Bias_Vd,Mean_Bias_Vd_P,Vd_true,Vd_pred_2TCM,Vd_pred_PCDE,Vd_pred_Patlak,Mean_Bias_P,Mean_RE,Mean_MSE,Noise_P_2TCM_PCDE,Noise_P_Patlak,Ki_true,Ki_pred_2TCM,Ki_pred_PCDE,Ki_pred_Patlak,Prob_k1,Prob_k2,Prob_k3,Prob_k4,Mean_Bias_micro,Mean_Bias_micro_P,Mean_Bias_Ki,Mean_Bias_Ki_P,Mean_RE_micro,Mean_RE_Ki,Mean_RE_Vd,k1_true,k1_pred_2TCM,k1_pred_PCDE,k2_true,k2_pred_2TCM,k2_pred_PCDE,k3_true,k3_pred_2TCM,k3_pred_PCDE,k4_true,k4_pred_2TCM,k4_pred_PCDE]=virtual_phantom_simul_on_CPU(scale_factor,denoising_index)
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
k1_true=reshape(randi([50, 100],125,1)*0.01, 5,5,5);
k2_true=reshape(randi([50, 100],125,1)*0.01, 5,5,5);
k3_true=reshape(randi([1, 50],125,1)*0.01, 5,5,5);
k4_true=reshape(randi([1, 50],125,1)*0.01, 5,5,5);
vec=[reshape(k1_true,125,1), reshape(k2_true,125,1), reshape(k3_true,125,1), reshape(k4_true,125,1)];
vec_cell=mat2cell(vec,[ones(1,125)],[4]);

% Generating measured PET volume
PI_Time=[10:10:90]; % measured PI Times (from 10 to 90 [min] with 10 [min] duration)
%for i=1:1:125
%    vec_PET{i,1}=single(TTCM_analytic_Multi(vec(i,:),PI_Time));
%end
vec_PET_mat=TTCM_analytic_Multi(vec, PI_Time);
vec_PET=mat2cell(vec_PET_mat,[ones(1,125)],[size(PI_Time,2)]);
vol_PET=reshape(vec_PET, 5,5,5);

% vec_PET_mat_4D
for p=1:1:size(PI_Time,2)
    vec_PET_mat_4D(:,:,:,p)=reshape(vec_PET_mat(:,p), 5,5,5);
end
% Adding noise
%T_half=109.8; % assumed isotope: 18F
%T_frame= 0.75; % Time duration for a frame: 45 [sec] = 0.75 [min]
for i=1:1:5
    for j=1:1:5
        for k=1:1:5
            for p=1:1:size(PI_Time,2)
                vec_PET_mat_4D_noisy(i,j,k,p)=vec_PET_mat_4D(i,j,k,p) + (vec_PET_mat_4D(i,j,k,p)*scale_factor*0.01*randn(1,1));
                %vec_PET_mat_4D_noisy(i,j,k,p)=vec_PET_mat_4D(i,j,k,p) + (scale_factor*randn(1,1));
                % Zero-Mean Gaussian noise for PET (Wu and Carlson, 2002)
                %vec_PET_mat_4D_noisy(i,j,k,p)=vec_PET_mat_4D(i,j,k,p) + ( scale_factor*((vec_PET_mat_4D(i,j,k,p)*exp((log(2))/T_half*PI_Time(p))/T_frame)^(0.5))*randn(1,1));
            end
        end
    end
end
Noise_P_2TCM_PCDE=100*mean(abs(vec_PET_mat_4D_noisy-vec_PET_mat_4D)./vec_PET_mat_4D, 'all'); % overall noise level [%]

% Reshaping
for p=1:1:size(PI_Time,2)
    real_signal(:,p)=reshape(vec_PET_mat_4D_noisy(:,:,:,p),125,1);
end

filter_negative= real_signal < 0;
real_signal(filter_negative)=0; % avoiding negative signal! (due to the fact that it is not possible)

vec_PET_mat=real_signal;
vec_PET=mat2cell(vec_PET_mat,[ones(1,125)],[size(PI_Time,2)]);
vol_PET=reshape(vec_PET, 5,5,5);

%[permutes,true_data]=make_database(PI_Time); % generating random k parameterd Homogeneously! (k1,k2,k3,k4:0.01~1) 
[permutes,true_data]=make_database_NH(PI_Time); % generating random k parameters Non-Homogeneously! (k1,k2:0.5~1, k3,k4:0.01~0.5)
permutes=single(permutes);
true_data=single(true_data);

%% Denoising

switch denoising_index
    case 0 % for No denosing!
    case 1 % for Linear fit in Ln scale (Ln_Linear)
        for i=1:1:size(vec_PET,1)
            Estimates_Ln_Linear=polyfit(PI_Time,log(vec_PET{i,1}),1);
            vec_PET_Ln_Linear{i,1}=exp(Linear_Fit([Estimates_Ln_Linear(2), Estimates_Ln_Linear(1)],PI_Time));
        end
        % Saving the denosing data to be used for PCDE method
        vec_PET=vec_PET_Ln_Linear;
    case 2 % for Exponential Fit in Lin scale (Lin_Exp)
        for i=1:1:size(vec_PET,1)
            Starting_Lin_Exp=[37,15,vec_PET{i,1}(end)];
            lb_Exp=[0,0,0];
            ub_Exp=[1000,1000,1000];
            [Estimates_Lin_Exp,SSE,Residual,d,e,f,Jacobian]=lsqcurvefit(@Lin_Exp, Starting_Lin_Exp, PI_Time,vec_PET{i,1},lb_Exp,ub_Exp);
            vec_PET_Lin_Exp{i,1}=Lin_Exp(Estimates_Lin_Exp,PI_Time);
        end
        % Saving the denosing data to be used for PCDE method
        vec_PET=vec_PET_Lin_Exp;
    case 3 % for Moving-Average smoothing
        for i=1:1:size(vec_PET,1)
            %vec_PET_MV{i,1}=transpose(smooth(vec_PET{i,1},'moving'));
            %vec_PET_MV{i,1}=transpose(smooth(vec_PET{i,1},'sgolay'));
            %vec_PET_MV{i,1}=transpose(smooth(vec_PET{i,1},'lowess'));
            vec_PET_MV{i,1}=transpose(smooth(vec_PET{i,1},'loess'));
        end
        vec_PET=vec_PET_MV;
    case 4 % for using Most Probable k
        for i=1:1:size(vec_PET,1)
            tic;
            avg_Cts=zeros(1,size(PI_Time,2));
            for t=1:1:size(PI_Time,2)
                %[avg_Ct]=Calc_avg_Cts(permutes,true_data,vec_PET{1,1}(i),10,i);
                [avg_Ct]=Calc_avg_Cts(permutes,true_data,vec_PET{i,1}(t),10,t);
                avg_Cts(t)=avg_Ct;
            end
            vec_PET_MPK{i,1}=avg_Cts;
            toc;
        end
        vec_PET=vec_PET_MPK;
    case 5 % for Ln_Linear +MPK
        for i=1:1:size(vec_PET,1)
            Estimates_Ln_Linear=polyfit(PI_Time,log(vec_PET{i,1}),1);
            vec_PET_Ln_Linear{i,1}=exp(Linear_Fit([Estimates_Ln_Linear(2), Estimates_Ln_Linear(1)],PI_Time));
        end
        % Saving the denosing data to be used for PCDE method
        vec_PET=vec_PET_Ln_Linear;
        for i=1:1:size(vec_PET,1)
            tic;
            avg_Cts=zeros(1,size(PI_Time,2));
            for t=1:1:size(PI_Time,2)
                %[avg_Ct]=Calc_avg_Cts(permutes,true_data,vec_PET{1,1}(i),10,i);
                [avg_Ct]=Calc_avg_Cts(permutes,true_data,vec_PET{i,1}(t),10,t);
                avg_Cts(t)=avg_Ct;
            end
            vec_PET_MPK{i,1}=avg_Cts;
            toc;
        end
        vec_PET=vec_PET_MPK;

    case 6 % for MPK + Ln_Linear
        for i=1:1:size(vec_PET,1)
            tic;
            avg_Cts=zeros(1,size(PI_Time,2));
            for t=1:1:size(PI_Time,2)
                %[avg_Ct]=Calc_avg_Cts(permutes,true_data,vec_PET{1,1}(i),10,i);
                [avg_Ct]=Calc_avg_Cts(permutes,true_data,vec_PET{i,1}(t),10,t);
                avg_Cts(t)=avg_Ct;
            end
            vec_PET_MPK{i,1}=avg_Cts;
            toc;
        end
        vec_PET=vec_PET_MPK;
        for i=1:1:size(vec_PET,1)
            Estimates_Ln_Linear=polyfit(PI_Time,log(vec_PET{i,1}),1);
            vec_PET_Ln_Linear{i,1}=exp(Linear_Fit([Estimates_Ln_Linear(2), Estimates_Ln_Linear(1)],PI_Time));
        end
        % Saving the denosing data to be used for PCDE method
        vec_PET=vec_PET_Ln_Linear;
        
    case 7 % for MPK + Lin_Exp
       for i=1:1:size(vec_PET,1)
            tic;
            avg_Cts=zeros(1,size(PI_Time,2));
            for t=1:1:size(PI_Time,2)
                %[avg_Ct]=Calc_avg_Cts(permutes,true_data,vec_PET{1,1}(i),10,i);
                [avg_Ct]=Calc_avg_Cts(permutes,true_data,vec_PET{i,1}(t),10,t);
                avg_Cts(t)=avg_Ct;
            end
            vec_PET_MPK{i,1}=avg_Cts;
            toc;
        end
        vec_PET=vec_PET_MPK;
        for i=1:1:size(vec_PET,1)
            Starting_Lin_Exp=[37,15,vec_PET{i,1}(end)];
            [Estimates_Lin_Exp,SSE,Residual,d,e,f,Jacobian]=lsqcurvefit(@Lin_Exp, Starting_Lin_Exp, PI_Time,vec_PET{i,1});
            vec_PET_Lin_Exp{i,1}=Lin_Exp(Estimates_Lin_Exp,PI_Time);
        end
        % Saving the denosing data to be used for PCDE method
        vec_PET=vec_PET_Lin_Exp; 
        
    case 8 % for Lin_Exp + MPK
        for i=1:1:size(vec_PET,1)
            Starting_Lin_Exp=[37,15,vec_PET{i,1}(end)];
            [Estimates_Lin_Exp,SSE,Residual,d,e,f,Jacobian]=lsqcurvefit(@Lin_Exp, Starting_Lin_Exp, PI_Time,vec_PET{i,1});
            vec_PET_Lin_Exp{i,1}=Lin_Exp(Estimates_Lin_Exp,PI_Time);
        end
        % Saving the denosing data to be used for PCDE method
        vec_PET=vec_PET_Lin_Exp; 
        for i=1:1:size(vec_PET,1)
            tic;
            avg_Cts=zeros(1,size(PI_Time,2));
            for t=1:1:size(PI_Time,2)
                %[avg_Ct]=Calc_avg_Cts(permutes,true_data,vec_PET{1,1}(i),10,i);
                [avg_Ct]=Calc_avg_Cts(permutes,true_data,vec_PET{i,1}(t),10,t);
                avg_Cts(t)=avg_Ct;
            end
            vec_PET_MPK{i,1}=avg_Cts;
            toc;
        end
        vec_PET=vec_PET_MPK;

    case 9 % for MV + MPK
        for i=1:1:size(vec_PET,1)
            vec_PET_MV{i,1}=transpose(smooth(vec_PET{i,1},'moving'));
        end
        vec_PET=vec_PET_MV;
        for i=1:1:size(vec_PET,1)
            tic;
            avg_Cts=zeros(1,size(PI_Time,2));
            for t=1:1:size(PI_Time,2)
                %[avg_Ct]=Calc_avg_Cts(permutes,true_data,vec_PET{1,1}(i),10,i);
                [avg_Ct]=Calc_avg_Cts(permutes,true_data,vec_PET{i,1}(t),10,t);
                avg_Cts(t)=avg_Ct;
            end
            vec_PET_MPK{i,1}=avg_Cts;
            toc;
        end
        vec_PET=vec_PET_MPK;

    case 10 % for MPK + MV
        for i=1:1:size(vec_PET,1)
            tic;
            avg_Cts=zeros(1,size(PI_Time,2));
            for t=1:1:size(PI_Time,2)
                %[avg_Ct]=Calc_avg_Cts(permutes,true_data,vec_PET{1,1}(i),10,i);
                [avg_Ct]=Calc_avg_Cts(permutes,true_data,vec_PET{i,1}(t),10,t);
                avg_Cts(t)=avg_Ct;
            end
            vec_PET_MPK{i,1}=avg_Cts;
            toc;
        end
        vec_PET=vec_PET_MPK;
        for i=1:1:size(vec_PET,1)
            vec_PET_MV{i,1}=transpose(smooth(vec_PET{i,1},'moving'));
        end
        vec_PET=vec_PET_MV;
    case 11 % Up-Down True (with Lin_Exp)
        for i=1:1:size(vec_PET,1)
            Starting_Lin_Exp=[37,15,vec_PET{i,1}(end)];
            [Estimates_Lin_Exp,SSE,Residual,d,e,f,Jacobian]=lsqcurvefit(@Lin_Exp, Starting_Lin_Exp, PI_Time,vec_PET{i,1});
            vec_PET_Lin_Exp{i,1}=Lin_Exp(Estimates_Lin_Exp,PI_Time);
            Up{i,1}=(vec_PET_Lin_Exp{i,1}-vec_PET{i,1}) > 0;
        end
        for i=1:1:size(vec_PET,1)
            tic;
            avg_Cts=zeros(1,size(PI_Time,2));
            for t=1:1:size(PI_Time,2)
                %[avg_Ct]=Calc_avg_Cts(permutes,true_data,vec_PET{1,1}(i),10,i);
                [avg_Ct]=Calc_avg_Cts(permutes,true_data,vec_PET{i,1}(t),10,t,Up{i,1}(t));
                avg_Cts(t)=avg_Ct;
            end
            vec_PET_MPK{i,1}=avg_Cts;
            toc;
        end
        vec_PET=vec_PET_MPK;

    case 12 % Up-Down True (with Ln_Linear)
        for i=1:1:size(vec_PET,1)
            Estimates_Ln_Linear=polyfit(PI_Time,log(vec_PET{i,1}),1);
            vec_PET_Ln_Linear{i,1}=exp(Linear_Fit([Estimates_Ln_Linear(2), Estimates_Ln_Linear(1)],PI_Time));
            Up{i,1}=(vec_PET_Ln_Linear{i,1}-vec_PET{i,1}) > 0;
        end
        for i=1:1:size(vec_PET,1)
            tic;
            avg_Cts=zeros(1,size(PI_Time,2));
            for t=1:1:size(PI_Time,2)
                %[avg_Ct]=Calc_avg_Cts(permutes,true_data,vec_PET{1,1}(i),10,i);
                [avg_Ct]=Calc_avg_Cts(permutes,true_data,vec_PET{i,1}(t),10,t,Up{i,1}(t));
                avg_Cts(t)=avg_Ct;
            end
            vec_PET_MPK{i,1}=avg_Cts;
            toc;
        end
        vec_PET=vec_PET_MPK;

end



%%

% Finding params by comparing the distances between Late PI data & the Database
for i=1:1:125
    tic;
    Y_data_repmat=repmat(vec_PET{i,1}, size(permutes,1),1);
    [min_val,ind_min]=min( sum((abs(true_data-Y_data_repmat)),2) );
    if i==1
        chosen_params=permutes(ind_min,:);
    else
        chosen_params=cat(1, chosen_params, permutes(ind_min,:));
    end
    Min_ind(1,i)=ind_min;
    toc;
end


%% Testing start %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Estimates_True=single(zeros(size(permutes,1),2));
Estimates_True=single(zeros(size(permutes,1),4));
for i=1:1:size(permutes,1)
    tic;
    %Estimates_True_temp=polyfit(PI_Time,log(true_data(i,:)),1);
    %Estimates_True(i,1)=Estimates_True_temp(1,1);
    %Estimates_True(i,2)=Estimates_True_temp(1,2);
    Starting_Lin_Exp=[37,15,0];
    lb_Exp=[0,0,0];
    ub_Exp=[1000,1000,1000];
    [Estimates_Lin_Exp,SSE,Residual,d,e,f,Jacobian]=lsqcurvefit(@Lin_Exp, Starting_Lin_Exp, PI_Time,double(true_data(i,:)),lb_Exp,ub_Exp);
    Estimates_True(i,1)=Lin_Exp(Estimates_Lin_Exp,PI_Time(1));
    Estimates_True(i,2)=Estimates_Lin_Exp(1,1);
    Estimates_True(i,3)=Estimates_Lin_Exp(1,2);
    Estimates_True(i,4)=Estimates_Lin_Exp(1,3);
    toc;
end
%Estimates_Measured=single(zeros(size(vec_PET,1),2));
Estimates_Measured=single(zeros(size(vec_PET,1),4));
for i=1:1:size(vec_PET,1)
%     Estimates_Measured_temp=polyfit(PI_Time,log(vec_PET{i,1}),1);
%     Estimates_Measured(i,1)=Estimates_Measured_temp(1,1);
%     Estimates_Measured(i,2)=Estimates_Measured_temp(1,2);
      Starting_Lin_Exp=[37,15,0];
      lb_Exp=[0,0,0];
      ub_Exp=[1000,1000,1000];
      [Estimates_Lin_Exp,SSE,Residual,d,e,f,Jacobian]=lsqcurvefit(@Lin_Exp, Starting_Lin_Exp, PI_Time,vec_PET{i,1},lb_Exp,ub_Exp);
      Estimates_Measured(i,1)=Lin_Exp(Estimates_Lin_Exp,PI_Time(1));
      Estimates_Measured(i,2)=Estimates_Lin_Exp(1,1);
      Estimates_Measured(i,3)=Estimates_Lin_Exp(1,2);
      Estimates_Measured(i,4)=Estimates_Lin_Exp(1,3);
end
Min_ind=zeros(1,size(Estimates_Measured,1));
Rel_Weights=zeros(1,4);
for i=1:1:125
    tic;
    Y_data_repmat=repmat(vec_PET{i,1}, size(permutes,1),1);
    [sorted_val,sorted_ind]=sort( sum((abs(true_data-Y_data_repmat)),2) );
    if sorted_val(1) < 1
        final_ind=sorted_ind(1);
    elseif (1 <= sorted_val(1)) &&  (sorted_val(1) < 2.0)
        max_num=nnz(find(sorted_val < 2.0));
        Diff_Weight=3.8;
        Rel_Weights=[1/Estimates_True(i,1), 1/Estimates_True(i,2),1/Estimates_True(i,3),5*1/Estimates_True(i,4)];
        Rel_Weights=repmat(Rel_Weights,size(max_num,1),1);
        [n_min_val,n_min_ind]=min( sum(Rel_Weights.*abs(Estimates_Measured(i,:)-Estimates_True(sorted_ind(1:max_num),:)),2)+ Diff_Weight.*sorted_val(1:max_num) );
        final_ind=sorted_ind(n_min_ind);
    elseif (sorted_val(1) > 3.0)
        max_num=nnz(find(sorted_val < 4.5));
        Diff_Weight=0;
        Rel_Weights=[1/Estimates_True(i,1), 1/Estimates_True(i,2),1/Estimates_True(i,3),1/Estimates_True(i,4)];
        if Estimates_True(i,4) < 0.00001
            Rel_Weights(1,4)=log(1/Estimates_True(i,4));
            Rel_Weights=repmat(Rel_Weights,size(max_num,1),1);
            abs_diff=abs(Estimates_Measured(i,:)-Estimates_True(sorted_ind(1:max_num),:));
            abs_log_diff=abs( abs(log(Estimates_Measured(i,4))) - abs(log(Estimates_True(sorted_ind(1:max_num),4))) );
            abs_diff(:,4)=abs_log_diff;
            abs_diff=Rel_Weights.*abs_diff;
            [temp_val,temp_ind]=sort(sum(abs_diff,2));
            [n_min_val,n_min_ind]=min(Estimates_True(sorted_ind(temp_ind(1:2)),3)-Estimates_Measured(i,3));
            final_ind=sorted_ind(temp_ind(n_min_ind));
        end
    end
    %[n_min_val,n_min_ind]=min( 3.5.*abs(Estimates_Measured(i,1)-Estimates_True(sorted_ind(1:20),1))./Estimates_True(sorted_ind(1:20),1)+2.5.*abs(Estimates_Measured(i,2)-Estimates_True(sorted_ind(1:20),2))./Estimates_True(sorted_ind(1:20),2)+3.*abs(Estimates_Measured(i,3)-Estimates_True(sorted_ind(1:20),3))./Estimates_True(sorted_ind(1:20),3)+abs(Estimates_Measured(i,4)-Estimates_True(sorted_ind(1:20),4))./Estimates_True(sorted_ind(1:20),4) );
    %[n_min_val,n_min_ind]=min( abs(Estimates_Measured(i,1)-Estimates_True(sorted_ind(1:20),1))+abs(Estimates_Measured(i,2)-Estimates_True(sorted_ind(1:20),2))+abs(Estimates_Measured(i,4)-Estimates_True(sorted_ind(1:20),4)) );
    %final_ind=sorted_ind(n_min_ind);
    %[n_min_val,n_min_ind]=min( sum((abs(true_data-Y_data_repmat)),2) );
    %final_ind=n_min_ind;
    %Y_data_repmat=repmat(Estimates_Measured(i,:), size(permutes,1),1);
    %Rel_Weights=[1/Estimates_True(i,1), 1/Estimates_True(i,2),1/Estimates_True(i,3),1/Estimates_True(i,4)];
    %Rel_Weights=[1,1,1,1];
    %Rel_Weights=repmat(Rel_Weights,size(permutes,1),1);
    %[sorted_val,sorted_ind]=sort(sum( Rel_Weights.*abs(Estimates_True-Y_data_repmat) ,2),'ascend');
    %[three_min_val,three_min_ind]=min( abs(Estimates_Measured(i,1)-Estimates_True(sorted_ind(1:2),1))+abs(Estimates_Measured(i,2)-Estimates_True(sorted_ind(1:2),2))+abs(Estimates_Measured(i,4)-Estimates_True(sorted_ind(1:2),4)) );
    %final_ind=sorted_ind(three_min_ind);
    Min_ind(1,i)=final_ind;
    if i==1
        chosen_params=permutes(final_ind,:);
    else
        chosen_params=cat(1, chosen_params, permutes(final_ind,:));
    end        
    toc;
end
%% End of Testing %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

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

%diff_k1=round(permutes(:,1)-chosen_k1,2);
%diff_k2=round(permutes(:,2)-chosen_k2,2);
%diff_k3=round(permutes(:,3)-chosen_k3,2);
%diff_k4=round(permutes(:,4)-chosen_k4,2);

% Calc. of Probability of finding true parameters
Prob_k1=(size(diff_k1,1)-nnz(diff_k1))/125 * 100; % unit: [%]
Prob_k2=(size(diff_k2,1)-nnz(diff_k2))/125 * 100; % unit: [%]
Prob_k3=(size(diff_k3,1)-nnz(diff_k3))/125 * 100; % unit: [%]
Prob_k4=(size(diff_k4,1)-nnz(diff_k4))/125 * 100; % unit: [%]


% Generating Artificial Data Points
%Early_PI_Time=single([0:0.01:90]);
Early_PI_Time=[0:1:10];

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
                X_4D_PCDE(i,j,k,p)=Time(p);
                Y_4D_PCDE(i,j,k,p)=art_vol_PET{i,j,k}(1,p);
            end
        end
    end
end
% Doing fitting & Calc. of REs
Size_PCDE=[size(Y_4D_PCDE,1),size(Y_4D_PCDE,2),size(Y_4D_PCDE,3),size(Y_4D_PCDE,4)];
Starting_PCDE=[0.5;0.5;0.05;0.05];
LB_PCDE=[0;0;0;0];
UB_PCDE=[1;1;1;1];
for i=1:1:5
    for j=1:1:5
        for k=1:1:5
            x_temp=double(squeeze(X_4D_PCDE(i,j,k,:)));
            y_temp=double(squeeze(Y_4D_PCDE(i,j,k,:)));
            Starting_temp_PCDE=double([vol_k1_predicted(i,j,k);vol_k2_predicted(i,j,k);vol_k3_predicted(i,j,k);vol_k4_predicted(i,j,k)]);
            [Estimates,SSE,Residual,d,e,f,Jacobian]=lsqcurvefit(@TTCM_analytic, Starting_temp_PCDE, x_temp,y_temp, LB_PCDE, UB_PCDE);
            [ci, se]=nlparci(Estimates, Residual, 'jacobian', Jacobian);
            parameters_PCDE{i,j,k}=Estimates;
            RE_PCDE{i,j,k}=abs((se./Estimates))*100;
            MSE_PCDE{i,j,k}=SSE/size(y_temp,1);
        end
    end
end
for i=1:1:5
    for j=1:1:5
        for k=1:1:5
            k1_pred_PCDE(i,j,k)=parameters_PCDE{i,j,k}(1);
            k2_pred_PCDE(i,j,k)=parameters_PCDE{i,j,k}(2);
            k3_pred_PCDE(i,j,k)=parameters_PCDE{i,j,k}(3);
            k4_pred_PCDE(i,j,k)=parameters_PCDE{i,j,k}(4);
            k1_RE_PCDE(i,j,k)=RE_PCDE{i,j,k}(1);
            k2_RE_PCDE(i,j,k)=RE_PCDE{i,j,k}(2);
            k3_RE_PCDE(i,j,k)=RE_PCDE{i,j,k}(3);
            k4_RE_PCDE(i,j,k)=RE_PCDE{i,j,k}(4);
        end
    end
end
% Calc. of Probability of finding true parameters after fitting
fit_diff_k1_PCDE=round(vec(:,1)-k1_pred_PCDE(:),2);
fit_diff_k2_PCDE=round(vec(:,2)-k2_pred_PCDE(:),2);
fit_diff_k3_PCDE=round(vec(:,3)-k3_pred_PCDE(:),2);
fit_diff_k4_PCDE=round(vec(:,4)-k4_pred_PCDE(:),2);
Prob_k1_fit_PCDE=(size(fit_diff_k1_PCDE,1)-nnz(fit_diff_k1_PCDE))/125 * 100; % unit: [%]
Prob_k2_fit_PCDE=(size(fit_diff_k2_PCDE,1)-nnz(fit_diff_k2_PCDE))/125 * 100; % unit: [%]
Prob_k3_fit_PCDE=(size(fit_diff_k3_PCDE,1)-nnz(fit_diff_k3_PCDE))/125 * 100; % unit: [%]
Prob_k4_fit_PCDE=(size(fit_diff_k4_PCDE,1)-nnz(fit_diff_k4_PCDE))/125 * 100; % unit: [%]
% K_i true
Ki_true=(k1_true.*k3_true)./(k2_true+k3_true);
Ki_pred_PCDE=(k1_pred_PCDE.*k3_pred_PCDE)./(k2_pred_PCDE+k3_pred_PCDE);
Ki_bias_PCDE=mean(abs(Ki_true-Ki_pred_PCDE), 'all');
Ki_bias_P_PCDE=mean(abs( (Ki_true-Ki_pred_PCDE)./Ki_true )*100, 'all');
% Calc. of RE [%] of K_i by using Error Propagation Theory ( Ki=k1*k3/(k2+k3) )
syms Ki_func k1 k2 k3
Ki_func= k1*k3/(k2+k3);
Deriv_Ki_k1=matlabFunction(diff(Ki_func, k1));
Deriv_Ki_k2=matlabFunction(diff(Ki_func, k2));
Deriv_Ki_k3=matlabFunction(diff(Ki_func, k3));
Deriv_Ki_k1_val=Deriv_Ki_k1(k2_pred_PCDE,k3_pred_PCDE);
Deriv_Ki_k2_val=Deriv_Ki_k2(k1_pred_PCDE,k2_pred_PCDE,k3_pred_PCDE);
Deriv_Ki_k3_val=Deriv_Ki_k3(k1_pred_PCDE,k2_pred_PCDE,k3_pred_PCDE);
Ki_RE_PCDE= (( ((Deriv_Ki_k1_val).^(2)).*((k1_RE_PCDE.*k1_pred_PCDE/100).^(2)) ) + ( ((Deriv_Ki_k2_val).^(2)).*((k2_RE_PCDE.*k2_pred_PCDE/100).^(2)) ) + ( ((Deriv_Ki_k3_val).^(2)).*((k3_RE_PCDE.*k3_pred_PCDE/100).^(2)) )).^(0.5);

% V_d true (assumption: Vb==0, fractional blood volume is zero)
Vd_true=(k1_true.*k2_true)./((k2_true+k3_true).^(2));
Vd_pred_PCDE=(k1_pred_PCDE.*k2_pred_PCDE)./((k2_pred_PCDE+k3_pred_PCDE).^(2));
Vd_bias_PCDE=mean(abs(Vd_true-Vd_pred_PCDE), 'all');
Vd_bias_P_PCDE=mean(abs( (Vd_true-Vd_pred_PCDE)./Vd_true )*100, 'all');
% Calc. of RE [%] of V_d by using Error Propagation Theory ( V_d=k1*k2/((k2+k3)^2) )
syms Vd_func 
Vd_func=k1*k2/((k2+k3)^(2));
Deriv_Vd_k1=matlabFunction(diff(Vd_func, k1));
Deriv_Vd_k2=matlabFunction(diff(Vd_func, k2));
Deriv_Vd_k3=matlabFunction(diff(Vd_func, k3));
Deriv_Vd_k1_val=Deriv_Vd_k1(k2_pred_PCDE,k3_pred_PCDE);
Deriv_Vd_k2_val=Deriv_Vd_k2(k1_pred_PCDE,k2_pred_PCDE,k3_pred_PCDE);
Deriv_Vd_k3_val=Deriv_Vd_k3(k1_pred_PCDE,k2_pred_PCDE,k3_pred_PCDE);
Vd_RE_PCDE= (( ((Deriv_Vd_k1_val).^(2)).*((k1_RE_PCDE.*k1_pred_PCDE/100).^(2)) ) + ( ((Deriv_Vd_k2_val).^(2)).*((k2_RE_PCDE.*k2_pred_PCDE/100).^(2)) ) + ( ((Deriv_Vd_k3_val).^(2)).*((k3_RE_PCDE.*k3_pred_PCDE/100).^(2)) )).^(0.5);

%% code for comparison with original 2TCM method
% Making 4D array
for i=1:1:5
    for j=1:1:5
        for k=1:1:5
            for p=1:1:size(PI_Time,2)
                X_4D_2TCM(i,j,k,p)=PI_Time(p);
            end
        end
    end
end
Y_4D_2TCM=vec_PET_mat_4D_noisy;
% Doing fitting & Calc. of REs
Size_2TCM=[size(Y_4D_2TCM,1),size(Y_4D_2TCM,2),size(Y_4D_2TCM,3),size(Y_4D_2TCM,4)];
Starting_2TCM=[0.5;0.5;0.05;0.05];
LB_2TCM=[0;0;0;0];
UB_2TCM=[1;1;1;1];
for i=1:1:5
    for j=1:1:5
        for k=1:1:5
            x_temp=double(squeeze(X_4D_2TCM(i,j,k,:)));
            y_temp=double(squeeze(Y_4D_2TCM(i,j,k,:)));
            [Estimates,SSE,Residual,d,e,f,Jacobian]=lsqcurvefit(@TTCM_analytic, Starting_2TCM, x_temp,y_temp, LB_PCDE, UB_PCDE);
            [ci, se]=nlparci(Estimates, Residual, 'jacobian', Jacobian);
            parameters_2TCM{i,j,k}=Estimates;
            RE_2TCM{i,j,k}=abs((se./Estimates))*100;
            MSE_2TCM{i,j,k}=SSE/size(y_temp,1);
        end
    end
end
for i=1:1:5
    for j=1:1:5
        for k=1:1:5
            k1_pred_2TCM(i,j,k)=parameters_2TCM{i,j,k}(1);
            k2_pred_2TCM(i,j,k)=parameters_2TCM{i,j,k}(2);
            k3_pred_2TCM(i,j,k)=parameters_2TCM{i,j,k}(3);
            k4_pred_2TCM(i,j,k)=parameters_2TCM{i,j,k}(4);
            k1_RE_2TCM(i,j,k)=RE_2TCM{i,j,k}(1);
            k2_RE_2TCM(i,j,k)=RE_2TCM{i,j,k}(2);
            k3_RE_2TCM(i,j,k)=RE_2TCM{i,j,k}(3);
            k4_RE_2TCM(i,j,k)=RE_2TCM{i,j,k}(4);
        end
    end
end
% Calc. of Probability of finding true parameters after fitting
fit_diff_k1_2TCM=round(vec(:,1)-k1_pred_2TCM(:),2);
fit_diff_k2_2TCM=round(vec(:,2)-k2_pred_2TCM(:),2);
fit_diff_k3_2TCM=round(vec(:,3)-k3_pred_2TCM(:),2);
fit_diff_k4_2TCM=round(vec(:,4)-k4_pred_2TCM(:),2);
Prob_k1_fit_2TCM=(size(fit_diff_k1_2TCM,1)-nnz(fit_diff_k1_2TCM))/125 * 100; % unit: [%]
Prob_k2_fit_2TCM=(size(fit_diff_k2_2TCM,1)-nnz(fit_diff_k2_2TCM))/125 * 100; % unit: [%]
Prob_k3_fit_2TCM=(size(fit_diff_k3_2TCM,1)-nnz(fit_diff_k3_2TCM))/125 * 100; % unit: [%]
Prob_k4_fit_2TCM=(size(fit_diff_k4_2TCM,1)-nnz(fit_diff_k4_2TCM))/125 * 100; % unit: [%]

% K_i true
Ki_true=(k1_true.*k3_true)./(k2_true+k3_true);
Ki_pred_2TCM=(k1_pred_2TCM.*k3_pred_2TCM)./(k2_pred_2TCM+k3_pred_2TCM);
Ki_bias_2TCM=mean(abs(Ki_true-Ki_pred_2TCM), 'all');
Ki_bias_P_2TCM=mean(abs( (Ki_true-Ki_pred_2TCM)./Ki_true )*100, 'all');
% Calc. of RE [%] of K_i by using Error Propagation Theory (Ki=A/B)
syms Ki_func k1 k2 k3
Ki_func= k1*k3/(k2+k3);
Deriv_Ki_k1=matlabFunction(diff(Ki_func, k1));
Deriv_Ki_k2=matlabFunction(diff(Ki_func, k2));
Deriv_Ki_k3=matlabFunction(diff(Ki_func, k3));
Deriv_Ki_k1_val=Deriv_Ki_k1(k2_pred_2TCM,k3_pred_2TCM);
Deriv_Ki_k2_val=Deriv_Ki_k2(k1_pred_2TCM,k2_pred_2TCM,k3_pred_2TCM);
Deriv_Ki_k3_val=Deriv_Ki_k3(k1_pred_2TCM,k2_pred_2TCM,k3_pred_2TCM);
Ki_RE_2TCM= (( ((Deriv_Ki_k1_val).^(2)).*((k1_RE_2TCM.*k1_pred_2TCM/100).^(2)) ) + ( ((Deriv_Ki_k2_val).^(2)).*((k2_RE_2TCM.*k2_pred_2TCM/100).^(2)) ) + ( ((Deriv_Ki_k3_val).^(2)).*((k3_RE_2TCM.*k3_pred_2TCM/100).^(2)) )).^(0.5);

% V_d true (assumption: Vb==0, fractional blood volume is zero)
Vd_true=(k1_true.*k2_true)./((k2_true+k3_true).^(2));
Vd_pred_2TCM=(k1_pred_2TCM.*k2_pred_2TCM)./((k2_pred_2TCM+k3_pred_2TCM).^(2));
Vd_bias_2TCM=mean(abs(Vd_true-Vd_pred_2TCM), 'all');
Vd_bias_P_2TCM=mean(abs( (Vd_true-Vd_pred_2TCM)./Vd_true )*100, 'all');
% Calc. of RE [%] of V_d by using Error Propagation Theory ( V_d=k1*k2/((k2+k3)^2) )
syms Vd_func 
Vd_func=k1*k2/((k2+k3)^(2));
Deriv_Vd_k1=matlabFunction(diff(Vd_func, k1));
Deriv_Vd_k2=matlabFunction(diff(Vd_func, k2));
Deriv_Vd_k3=matlabFunction(diff(Vd_func, k3));
Deriv_Vd_k1_val=Deriv_Vd_k1(k2_pred_2TCM,k3_pred_2TCM);
Deriv_Vd_k2_val=Deriv_Vd_k2(k1_pred_2TCM,k2_pred_2TCM,k3_pred_2TCM);
Deriv_Vd_k3_val=Deriv_Vd_k3(k1_pred_2TCM,k2_pred_2TCM,k3_pred_2TCM);
Vd_RE_2TCM= (( ((Deriv_Vd_k1_val).^(2)).*((k1_RE_2TCM.*k1_pred_2TCM/100).^(2)) ) + ( ((Deriv_Vd_k2_val).^(2)).*((k2_RE_2TCM.*k2_pred_2TCM/100).^(2)) ) + ( ((Deriv_Vd_k3_val).^(2)).*((k3_RE_2TCM.*k3_pred_2TCM/100).^(2)) )).^(0.5);


%% Code for comparison with original Patlak method
% K_i & V_d true (assumption: fractional blood volume in a voxel, Vb==0)
Ki_true=round((k1_true.*k3_true)./(k2_true+k3_true), 2);
Vd_true=round( (k1_true.*k2_true)./((k2_true+k3_true).^2) ,2);
% C_tissue
Func_Exp_4=@(tau) Exp_4(Local_Estimates,tau);
Cp=Exp_4(Local_Estimates,PI_Time);
Ct=zeros(5,5,5,size(PI_Time,2));
Ct_noisy=zeros(5,5,5,size(PI_Time,2));
for i=1:1:5
    for j=1:1:5
        for k=1:1:5
            for p=1:1:size(PI_Time,2)
                Ct(i,j,k,p)=(Ki_true(i,j,k)*integral(Func_Exp_4, 0, PI_Time(p), 'ArrayValued',true)) + (Vd_true(i,j,k)*Cp(p));
                Ct_noisy(i,j,k,p)= Ct(i,j,k,p) + ((Ct(i,j,k,p)*scale_factor*0.01*randn(1,1)));
                % Zero-Mean Gaussian noise for PET (Wu and Carlson, 2002)
                %Ct_noisy(i,j,k,p)= Ct(i,j,k,p) +  ( 10*scale_factor*((Ct(i,j,k,p)*exp((log(2))/T_half*PI_Time(p))/T_frame)^(0.5))*randn(1,1));
            end
        end
    end
end
Noise_P_Patlak=100*mean(abs(Ct_noisy-Ct)./Ct, 'all'); % overall noise level [%]
% X & Y for Patlak
X_4D_Patlak=zeros(5,5,5,size(PI_Time,2)); % Integ_Cp_over_Cp
Y_4D_Patlak=zeros(5,5,5,size(PI_Time,2)); % C_tissue_over_Cp
for i=1:1:5
    for j=1:1:5
        for k=1:1:5
            for p=1:1:size(PI_Time,2)
                X_4D_Patlak(i,j,k,p)=integral(Func_Exp_4, 0, PI_Time(p), 'ArrayValued',true)/Cp(p);
                Y_4D_Patlak(i,j,k,p)=Ct_noisy(i,j,k,p)/Cp(p);
                %Y_4D_Patlak(i,j,k,p)=vec_PET_mat_4D_noisy(i,j,k,p)/Cp(p);
            end
        end
    end
end

% Doing fitting & Calc. of REs
Size_Patlak=[size(Y_4D_Patlak,1),size(Y_4D_Patlak,2),size(Y_4D_Patlak,3),size(Y_4D_Patlak,4)];
Starting_Patlak=[0;1];
LB_Patlak=[-1000;0];
UB_Patlak=[1000;10];
for i=1:1:5
    for j=1:1:5
        for k=1:1:5
            x_temp=double(squeeze(X_4D_Patlak(i,j,k,:)));
            y_temp=double(squeeze(Y_4D_Patlak(i,j,k,:)));
            Starting_temp_Patlak=double([Vd_true(i,j,k);Ki_true(i,j,k)]);
            [Estimates,SSE,Residual,d,e,f,Jacobian]=lsqcurvefit(@Linear_Fit, Starting_temp_Patlak, x_temp,y_temp, LB_Patlak, UB_Patlak);
            [ci, se]=nlparci(Estimates, Residual, 'jacobian', Jacobian);
            parameters_Patlak{i,j,k}=Estimates;
            RE_Patlak{i,j,k}=abs((se./Estimates))*100;
            MSE_Patlak{i,j,k}=SSE/size(y_temp,1);
            MSE_Patlak_Scaled{i,j,k}=sum(((Residual.*Cp).^(2)),'all')/size(y_temp,1);
        end
    end
end
for i=1:1:5
    for j=1:1:5
        for k=1:1:5
            Vd_pred_Patlak(i,j,k)=parameters_Patlak{i,j,k}(1);
            Ki_pred_Patlak(i,j,k)=parameters_Patlak{i,j,k}(2);
            Vd_RE_Patlak(i,j,k)=RE_Patlak{i,j,k}(1);
            Ki_RE_Patlak(i,j,k)=RE_Patlak{i,j,k}(2);
        end
    end
end

Ki_bias_Patlak=mean(abs(Ki_true-Ki_pred_Patlak), 'all');
Ki_bias_P_Patlak=mean(abs( (Ki_true-Ki_pred_Patlak)./Ki_true )*100, 'all');
Vd_bias_Patlak=mean(abs(Vd_true-Vd_pred_Patlak), 'all');
Vd_bias_P_Patlak=mean(abs((Vd_true-Vd_pred_Patlak)./Vd_true)*100, 'all');

%% Summary of the results
%% for Micro-parameters (2TCM v.s. PCDE)
% Mean Bias: [k1_2TCM,k1_PCDE,k2_2TCM,k2_PCDE,k3_2TCM,k3_PCDE,k4_2TCM,k4_PCDE]
Mean_Bias_micro=[mean(abs(k1_true-k1_pred_2TCM),'all'),mean(abs(k1_true-k1_pred_PCDE),'all'),mean(abs(k2_true-k2_pred_2TCM),'all'),mean(abs(k2_true-k2_pred_PCDE),'all'),mean(abs(k3_true-k3_pred_2TCM),'all'),mean(abs(k3_true-k3_pred_PCDE),'all'),mean(abs(k4_true-k4_pred_2TCM),'all'),mean(abs(k4_true-k4_pred_PCDE),'all')];
Mean_Bias_micro_P=[mean(abs(k1_true-k1_pred_2TCM)./k1_true*100,'all'),mean(abs(k1_true-k1_pred_PCDE)./k1_true*100,'all'),mean(abs(k2_true-k2_pred_2TCM)./k2_true*100,'all'),mean(abs(k2_true-k2_pred_PCDE)./k2_true*100,'all'),mean(abs(k3_true-k3_pred_2TCM)./k3_true*100,'all'),mean(abs(k3_true-k3_pred_PCDE)./k3_true*100,'all'),mean(abs(k4_true-k4_pred_2TCM)./k4_true*100,'all'),mean(abs(k4_true-k4_pred_PCDE)./k4_true*100,'all')];
% Mean RE [%]: [k1_2TCM,k1_PCDE,k2_2TCM,k2_PCDE,k3_2TCM,k3_PCDE,k4_2TCM,k4_PCDE]
Mean_RE_micro=[mean(k1_RE_2TCM,'all'),mean(k1_RE_PCDE,'all'),mean(k2_RE_2TCM,'all'),mean(k2_RE_PCDE,'all'),mean(k3_RE_2TCM,'all'),mean(k3_RE_PCDE,'all'),mean(k4_RE_2TCM,'all'),mean(k4_RE_PCDE,'all')];
%% for Macro-parameters (2TCM v.s. PCDE v.s. Patlak)
% Mean Bias: [Ki_2TCM,Ki_PCDE,Ki_Patlak] & [Vd_2TCM,Vd_PCDE,Vd_Patlak]
Mean_Bias_Ki=[Ki_bias_2TCM,Ki_bias_PCDE,Ki_bias_Patlak];
Mean_Bias_Ki_P=[Ki_bias_P_2TCM,Ki_bias_P_PCDE,Ki_bias_P_Patlak];
Mean_Bias_Vd=[Vd_bias_2TCM,Vd_bias_PCDE,Vd_bias_Patlak];
Mean_Bias_Vd_P=[Vd_bias_P_2TCM,Vd_bias_P_PCDE,Vd_bias_P_Patlak];
% Mean RE [%]: [Ki_2TCM,Ki_PCDE,Ki_Patlak] & [Vd_2TCM,Vd_PCDE,Vd_Patlak]
Mean_RE_Ki=[mean(Ki_RE_2TCM,'all'),mean(Ki_RE_PCDE,'all'),mean(Ki_RE_Patlak,'all')];
Mean_RE_Vd=[mean(Vd_RE_2TCM,'all'),mean(Vd_RE_PCDE,'all'),mean(Vd_RE_Patlak,'all')];


%% For data collection
Mean_Bias_P=[Mean_Bias_micro_P, Mean_Bias_Ki_P,Mean_Bias_Vd_P];
Mean_RE=[Mean_RE_micro, Mean_RE_Ki, Mean_RE_Vd];
Mean_MSE=[mean(cell2mat(MSE_2TCM),'all'), mean(cell2mat(MSE_PCDE),'all'),mean(cell2mat(MSE_Patlak_Scaled),'all')];

end