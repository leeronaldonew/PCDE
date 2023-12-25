function [RMSE_Info,k_True,Ki_True,Vd_True,Excel,Bias_Excel,SD_Excel,NBias_Excel,NSD_Excel,NMSE_Excel,NBias_micro_2TCM,NBias_micro_PCDE,NBias_macro_2TCM,NBias_macro_PCDE,NBias_macro_Patlak,NSD_micro_2TCM,NSD_micro_PCDE,NSD_macro_2TCM,NSD_macro_PCDE,NSD_macro_Patlak,MSE_micro_2TCM,MSE_micro_PCDE,MSE_macro_2TCM,MSE_macro_PCDE,MSE_macro_Patlak]=virtual_simul_Updated(scale_factor,Num_real,org_ind,PI_Time,PI_Time_fine)
% Updated for the calculation of NMSE as well.

% Loading Trained Networks
%load ('net2.mat');

%% Virtual simulation in a single voxel
options = optimoptions('lsqcurvefit','Display', 'off');

%scale_factor=10;
% Loading necessary data
global Local_Estimates
%load("Local_Estimates.mat");
%Local_Estimates=[650;6.7;146;0.25;105;0.03;21;0.0001]; % Params from KM with GPU 
%Local_Estimates=[0.735;851.1;21.88;20.81;4.134;0.1191;0.01043]; % Params for FDG referenced from Feng's paper 
%Local_Estimates=[0.587;88.9;0.91;0.68;6.66;0.21;0.012]; % Params for FDG referenced from Naganawa's paper (with Feng)

Local_Estimates=[17.86;0.00841;-3423.59;1.23;3348.58;1.13929;17.67;0.06774]; % Params for FDG with Exp_4 generated from Feng's graph for FDG
%Local_Estimates=[0.735;851.1;21.88;20.81;4.134;0.1191;0.01043]; % using Feng. eq.


% Indexing for each organ
% 1: Brain (Cortex), 2: Brain (WM), 3: Brain (Cerebellum)
% 4: Thyroid, 5: Myocardium, 6. Lung, 7: Liver, 8: Spleen, 9: Pancreas
% 10: Kidney, 11: Muscle, 12: Bone

%PI_Time=[10:5:40];
%PI_Time_fine=[10:0.1:40];

%k_True1=[0.09,0.25,0.22,0];k_True2=[0.03,0.13,0.05,0];k_True3=[0.13,0.63,0.19,0];k_True4=[0.97,1,0.07,0]; k_True5=[0.82,1,0.19,0];
%k_True6=[0.01,0.36,0.03,0];k_True7=[0.41,0.51,0.01,0];k_True8=[0.88,1,0.04,0]; k_True9=[0.36,1,0.08,0]; k_True10=[0.70,1,0.18,0]; 
%k_True11=[0.03,0.32,0.05,0];k_True12=[0.15,0.71,0.05,0];k_True13=[0.86,0.98,0.01,0];k_True14=[0.11,0.74,0.02,0];
%k_True_class=[k_True1;k_True2;k_True3;k_True4;k_True5;k_True6;k_True7;k_True8;k_True9;k_True10;k_True11;k_True12;k_True13;k_True14];

%% for XCAT Phantom Study (k4==0.001) %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%global Local_Estimates
%Local_Estimates=[17.86;0.00841;-3423.59;1.23;3348.58;1.13929;17.67;0.06774];

%k_True1=[0.09,0.25,0.22,0.001];k_True2=[0.03,0.13,0.05,0.001];k_True3=[0.13,0.63,0.19,0.001];k_True4=[0.97,1,0.07,0.001]; k_True5=[0.82,1,0.19,0.001];
%k_True6=[0.01,0.36,0.03,0.001];k_True7=[0.41,0.51,0.01,0.001];k_True8=[0.88,1,0.04,0.001]; k_True9=[0.36,1,0.08,0.001]; k_True10=[0.70,1,0.18,0.001]; 
%k_True11=[0.03,0.32,0.05,0.001];k_True12=[0.15,0.71,0.05,0.001];k_True13=[0.86,0.98,0.01,0.001];k_True14=[0.11,0.74,0.02,0.001];
%k_True_class=[k_True1;k_True2;k_True3;k_True4;k_True5;k_True6;k_True7;k_True8;k_True9;k_True10;k_True11;k_True12;k_True13;k_True14];

%PI_Time=[10:5:90];
%Ct=transpose(TTCM_analytic_Multi(k_True_class,PI_Time));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% for XCAT Phantom Study (k4==0) %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%global Local_Estimates
%Local_Estimates=[17.86;0.00841;-3423.59;1.23;3348.58;1.13929;17.67;0.06774];

%k_True1=[0.09,0.25,0.22,0];k_True2=[0.03,0.13,0.05,0];k_True3=[0.13,0.63,0.19,0];k_True4=[0.97,1,0.07,0]; k_True5=[0.82,1,0.19,0];
%k_True6=[0.01,0.36,0.03,0];k_True7=[0.41,0.51,0.01,0];k_True8=[0.88,1,0.04,0]; k_True9=[0.36,1,0.08,0]; k_True10=[0.70,1,0.18,0]; 
%k_True11=[0.03,0.32,0.05,0];k_True12=[0.15,0.71,0.05,0];k_True13=[0.86,0.98,0.01,0];k_True14=[0.11,0.74,0.02,0];
%k_True_class=[k_True1;k_True2;k_True3;k_True4;k_True5;k_True6;k_True7;k_True8;k_True9;k_True10;k_True11;k_True12;k_True13;k_True14];

%PI_Time=[10:5:90];
%Ct=transpose(TTCM_analytic_Multi(k_True_class,PI_Time));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%

switch org_ind
    case 1 % Brain (Cortex) (41222)
        k_True=[0.09,0.25,0.22,0];     
        k1_True=k_True(1);
        k2_True=k_True(2);
        k3_True=k_True(3);
        k4_True=k_True(4);
        Ki_True= (k_True(1)*k_True(3)) / (k_True(2)+k_True(3));
        Vd_True= (k_True(1)*k_True(2)) / ((k_True(2)+k_True(3))^2);
    case 2 % Brain (WM) (10605)
        k_True=[0.03,0.13,0.05,0];
        k1_True=k_True(1);
        k2_True=k_True(2);
        k3_True=k_True(3);
        k4_True=k_True(4);
        Ki_True= (k_True(1)*k_True(3)) / (k_True(2)+k_True(3));
        Vd_True= (k_True(1)*k_True(2)) / ((k_True(2)+k_True(3))^2);
    case 3 % Brain (Cerebellum) (63119)
        k_True=[0.13,0.63,0.19,0];
        k1_True=k_True(1);
        k2_True=k_True(2);
        k3_True=k_True(3);
        k4_True=k_True(4);
        Ki_True= (k_True(1)*k_True(3)) / (k_True(2)+k_True(3));
        Vd_True= (k_True(1)*k_True(2)) / ((k_True(2)+k_True(3))^2);
    case 4 % Thyroid (484957)
        k_True=[0.97,1,0.07,0]; % modified from [0.97,4.60,0.07,0]
        k1_True=k_True(1);
        k2_True=k_True(2);
        k3_True=k_True(3);
        k4_True=k_True(4);
        Ki_True= (k_True(1)*k_True(3)) / (k_True(2)+k_True(3));
        Vd_True= (k_True(1)*k_True(2)) / ((k_True(2)+k_True(3))^2);
    case 5 % Myocardium (409969)
        k_True=[0.82,1,0.19,0]; % modified from [0.82,3.50,0.19,0]
        k1_True=k_True(1);
        k2_True=k_True(2);
        k3_True=k_True(3);
        k4_True=k_True(4);
        Ki_True= (k_True(1)*k_True(3)) / (k_True(2)+k_True(3));
        Vd_True= (k_True(1)*k_True(2)) / ((k_True(2)+k_True(3))^2);
    case 6 % Lung (1753)
        k_True=[0.01,0.36,0.03,0];
        k1_True=k_True(1);
        k2_True=k_True(2);
        k3_True=k_True(3);
        k4_True=k_True(4);
        Ki_True= (k_True(1)*k_True(3)) / (k_True(2)+k_True(3));
        Vd_True= (k_True(1)*k_True(2)) / ((k_True(2)+k_True(3))^2);
    case 7 % Liver (202501)
        k_True=[0.41,0.51,0.01,0];
        k1_True=k_True(1);
        k2_True=k_True(2);
        k3_True=k_True(3);
        k4_True=k_True(4);
        Ki_True= (k_True(1)*k_True(3)) / (k_True(2)+k_True(3));
        Vd_True= (k_True(1)*k_True(2)) / ((k_True(2)+k_True(3))^2);
    case 8 % Spleen (439954)
        k_True=[0.88,1,0.04,0]; % modified from [0.88,2.02,0.04,0]
        k1_True=k_True(1);
        k2_True=k_True(2);
        k3_True=k_True(3);
        k4_True=k_True(4);
        Ki_True= (k_True(1)*k_True(3)) / (k_True(2)+k_True(3));
        Vd_True= (k_True(1)*k_True(2)) / ((k_True(2)+k_True(3))^2);
    case 9 % Pancreas (179958)
        k_True=[0.36,1,0.08,0]; % modified from [0.36,1.71,0.08,0]
        k1_True=k_True(1);
        k2_True=k_True(2);
        k3_True=k_True(3);
        k4_True=k_True(4);
        Ki_True= (k_True(1)*k_True(3)) / (k_True(2)+k_True(3));
        Vd_True= (k_True(1)*k_True(2)) / ((k_True(2)+k_True(3))^2);
    case 10 % Kidney (349968)
        k_True=[0.70,1,0.18,0]; % modified from [0.70,1.35,0.18,0]
        k1_True=k_True(1);
        k2_True=k_True(2);
        k3_True=k_True(3);
        k4_True=k_True(4);
        Ki_True= (k_True(1)*k_True(3)) / (k_True(2)+k_True(3));
        Vd_True= (k_True(1)*k_True(2)) / ((k_True(2)+k_True(3))^2);
    case 11 % Muscle (11555)
        k_True=[0.03,0.32,0.05,0];
        k1_True=k_True(1);
        k2_True=k_True(2);
        k3_True=k_True(3);
        k4_True=k_True(4);
        Ki_True= (k_True(1)*k_True(3)) / (k_True(2)+k_True(3));
        Vd_True= (k_True(1)*k_True(2)) / ((k_True(2)+k_True(3))^2);
    case 12 % Bone (73505)
        k_True=[0.15,0.71,0.05,0];
        k1_True=k_True(1);
        k2_True=k_True(2);
        k3_True=k_True(3);
        k4_True=k_True(4);
        Ki_True= (k_True(1)*k_True(3)) / (k_True(2)+k_True(3));
        Vd_True= (k_True(1)*k_True(2)) / ((k_True(2)+k_True(3))^2);
    case 13 % Normal Liver (429851) (from Dr. Karakatanis's paper)
        k_True=[0.86,0.98,0.01,0];
        k1_True=k_True(1);
        k2_True=k_True(2);
        k3_True=k_True(3);
        k4_True=k_True(4);
        Ki_True= (k_True(1)*k_True(3)) / (k_True(2)+k_True(3));
        Vd_True= (k_True(1)*k_True(2)) / ((k_True(2)+k_True(3))^2);
        %[permutes,true_database]=make_database_NH_FDG(PI_Time);
    case 14 % Normal Lung (53652) (from Dr. Karakatanis's paper)
        k_True=[0.11,0.74,0.02,0];
        k1_True=k_True(1);
        k2_True=k_True(2);
        k3_True=k_True(3);
        k4_True=k_True(4);
        Ki_True= (k_True(1)*k_True(3)) / (k_True(2)+k_True(3));
        Vd_True= (k_True(1)*k_True(2)) / ((k_True(2)+k_True(3))^2);
end

% Generating database
[permutes,true_database]=make_database_NH_FDG_Full(PI_Time); % for Irrerversible 2TCM with k4=0
%[permutes,true_database]=make_database_Irreversible_k4_001(PI_Time_temp); % for Irreversible 2TCM with k4=0.001

%[permutes,true_database]=make_database_NH_FDG_Full_Conv(PI_Time); % using TTCM_Conv
%load permutes.mat
%load true_database

% True & Noisy data
%Num_real=10;
Ct_True=TTCM_analytic_Multi(k_True,PI_Time); % with Exp_4
%Ct_True=TTCM_Conv(k_True,PI_Time); % with Feng's eq.

Ct_True=repmat(Ct_True,Num_real,1);
%Ct_True_2TCM=repmat(Ct_True_2TCM, Num_real,1);

Ct_Noisy=Ct_True + (Ct_True.*scale_factor*0.01.*randn(Num_real,size(PI_Time,2))); % original noise model
%Ct_Noisy_2TCM=Ct_True_2TCM + (Ct_True_2TCM.*scale_factor*0.01.*randn(Num_real,size([0:1:90],2))); % original noise model

%Ct_Mean=mean(Ct_True,'all'); % New noise model
%Ct_Mean=1;
%Ct_Noisy=Ct_True + (Ct_Mean.*scale_factor.*0.01.*randn(Num_real,size(PI_Time,2))); % New noise model
Ct_Noisy(Ct_Noisy < 0)=0; % to remove negative values
%Ct_Noisy_2TCM(Ct_Noisy_2TCM < 0)=0; % to remove negative values


%% 1) General 2TCM
Starting_2TCM=[0.5;0.5;0.05;0];
LB_2TCM=[0;0;0;0];
UB_2TCM=[1;1;1;0];
for i=1:1:Num_real
    %x_temp=[0:1:90];
    %y_temp=Ct_Noisy_2TCM(i,:);
    x_temp=PI_Time;
    y_temp=Ct_Noisy(i,:);

    [Estimates,SSE,Residual,d,e,f,Jacobian]=lsqcurvefit(@TTCM_analytic, Starting_2TCM, x_temp,y_temp, LB_2TCM, UB_2TCM,options); % for Exp_4
    %[Estimates,SSE,Residual,d,e,f,Jacobian]=lsqcurvefit(@TTCM_Conv_single, Starting_2TCM, x_temp,y_temp, LB_2TCM, UB_2TCM,options); % using TTCM_Conv
    
    %[Estimates,SSE,Residual,d,e,f,Jacobian]=lsqcurvefit(@TTCM_vector, Starting_2TCM, transpose(x_temp),transpose(y_temp), LB_2TCM, UB_2TCM); % for Feng
    [ci, se]=nlparci(Estimates, Residual, 'jacobian', Jacobian);
    parameters_2TCM{i,1}=Estimates; % for Micro-parameters
    RE_2TCM{i,1}=abs((se./Estimates))*100;
    %MSE_2TCM{i,1}=SSE/size(y_temp,1);
    Ki_2TCM{i,1}=(Estimates(1)*Estimates(3)) / (Estimates(2)+Estimates(3)); % for Ki
    Vd_2TCM{i,1}=(Estimates(1)*Estimates(2)) / ((Estimates(2)+Estimates(3))^2); % for Vd
    k1_2TCM{i,1}=Estimates(1); % for k1
    k2_2TCM{i,1}=Estimates(2); % for k2
    k3_2TCM{i,1}=Estimates(3); % for k3
    k4_2TCM{i,1}=Estimates(4); % for k4
end

%% 2) PCDE method
%[permutes,true_database]=make_database_NH(PI_Time);
%[permutes,true_database]=make_database_NH_FDG(PI_Time);

for i=1:1:Num_real
    %tic;
    %% Time Series Classification with Deep Learning
    %organ=double(classify(net,Ct_Noisy(i,:)));
    %param=k_True_class(organ,:);
    %if i==1
    %    chosen_params=param;
    %else
    %    chosen_params=cat(1, chosen_params, param);
    %end
    %% Original Algorithm
    Y_data_repmat=repmat(Ct_Noisy(i,:), size(permutes,1),1);

    %% Exp_fit for Noisy data
    %if Ct_Noisy(i,1) > Ct_Noisy(i,end) % Neg. Slope
    %    Starting=[-1*max(Ct_Noisy(i,:)),0,0];
    %    lb=[-10000,-10000,-10000];
    %    ub=[10000,10000,10000];
    %else % Pos. Slope
    %    Starting=[0,0, max(Ct_Noisy(i,:))];
    %    lb=[-10000,-10000,-10000];
    %    ub=[10000,10000,10000];
    %end
    %[Estimates,SSE,Residual,d,e,f,Jacobian]=lsqcurvefit(@Exp_New, Starting, PI_Time,Ct_Noisy(i,:),lb,ub,options); % for C-A*exp(-B*t)
    
    %weights=1./Ct_True(i,:);
    %%weights=ones(1,size(PI_Time,2));
    %[Estimates,Residual,Jacob,CovB,MSE,ErrorModelInfo] = nlinfit(PI_Time,Ct_Noisy(i,:),@Exp_New,Starting,'Weights',weights);
    %Fitted_Noisy=Exp_New(Estimates,[10:10:90]); % for C-A*exp(-B*t)
    %Y_data_repmat=repmat(Fitted_Noisy, size(permutes,1),1);

    %[sort_val,sort_ind]=sort( sum(abs(true_database-Y_data_repmat) , 2) ); % 
    [sort_val,sort_ind]=sort( sum(abs(true_database-Y_data_repmat).^2 , 2) ); % 

    %[ind_min]=Similarity_Measure(permutes, sort_ind, Ct_Noisy(i,:), PI_Time);
    [ind_min]=Similarity_Measure2(permutes, sort_ind, Ct_Noisy(i,:), PI_Time, PI_Time_fine);

    % By DTW (Dynamic Time Warping)
    %[dtw_update]=dtw_multi(true_database,Ct_Noisy(i,:));
    %[sort_val_dtw,sort_ind_dtw]=sort(dtw_update,'ascend');
    %[ind_min]=Similarity_Measure(permutes, sort_ind_dtw, Ct_Noisy(i,:), PI_Time);

   % [min_val,ind_min]=min( sum( abs(true_database-Y_data_repmat) , 2) ); % 

    if i==1
        chosen_params=permutes(ind_min,:);
    else
        chosen_params=cat(1, chosen_params, permutes(ind_min,:));
    end
    Min_ind(1,i)=ind_min;
    %toc;
end

% Generating artificial Ct at Early PI Time
%Early_PI_Time=[0:1:9];
%for i=1:1:Num_real
%    if i==1
%        Ct_early=TTCM_analytic(chosen_params(i,:),Early_PI_Time);
%    else
%        Ct_early=cat(1,Ct_early,TTCM_analytic(chosen_params(i,:),Early_PI_Time));
%    end
%end
%PI_Time_full=cat(2,Early_PI_Time,PI_Time);
%Ct_full=cat(2, Ct_early,Ct_Noisy); % artificial Ct (Ct_full= Ct_early + Ct_late)

% fitting with the artificial Ct
%Starting_PCDE=[0.5;0.5;0.05;0];
%LB_PCDE=[0;0;0;0];
%UB_PCDE=[1;1;1;0];
%for i=1:1:Num_real
%    x_temp=PI_Time_full;
%    y_temp=Ct_full(i,:);
%    [Estimates,SSE,Residual,d,e,f,Jacobian]=lsqcurvefit(@TTCM_analytic, Starting_PCDE, x_temp,y_temp, LB_PCDE, UB_PCDE);
%    [ci, se]=nlparci(Estimates, Residual, 'jacobian', Jacobian);
%    parameters_PCDE{i,1}=Estimates; % for Micro-parameters
%    RE_PCDE{i,1}=abs((se./Estimates))*100;
%    %MSE_PCDE{i,1}=SSE/size(y_temp,1);
%    Ki_PCDE{i,1}=(Estimates(1)*Estimates(3)) / (Estimates(2)+Estimates(3)); % for Ki
%    Vd_PCDE{i,1}=(Estimates(1)*Estimates(2)) / ((Estimates(2)+Estimates(3))^2); % for Vd
%    k1_PCDE{i,1}=Estimates(1); % for k1
%    k2_PCDE{i,1}=Estimates(2); % for k2
%    k3_PCDE{i,1}=Estimates(3); % for k3
%    k4_PCDE{i,1}=Estimates(4); % for k4
%end

% data saving w/o fitting
for i=1:1:Num_real
    k1_PCDE{i,1}=chosen_params(i,1); % for k1
    k2_PCDE{i,1}=chosen_params(i,2); % for k2
    k3_PCDE{i,1}=chosen_params(i,3); % for k3
    k4_PCDE{i,1}=chosen_params(i,4); % for k4
    Ki_PCDE{i,1}=(chosen_params(i,1)*chosen_params(i,3)) / (chosen_params(i,2)+chosen_params(i,3)); % for Ki
    Vd_PCDE{i,1}=(chosen_params(i,1)*chosen_params(i,2)) / ((chosen_params(i,2)+chosen_params(i,3))^2); % for Vd
end

%% 3) Patlak
% K_i & V_d true (assumption: fractional blood volume in a voxel, Vb==0)
Func_Exp_4=@(tau) Exp_4(Local_Estimates,tau); % for Exp_4
Cp=Exp_4(Local_Estimates,PI_Time); % for Exp_4

% pre-processing for Patlak method (since Patlak model is just approximated form of 2TCM, we need to have seperate Ct_noisy data for Patlak!)
for p=1:1:size(PI_Time,2)
    Ct_True_Patlak(1,p)=(Ki_True*integral(Func_Exp_4, 0, PI_Time(p), 'ArrayValued',true)) + (Vd_True*Cp(p)); % for Exp_4
end
Ct_True_Patlak=repmat(Ct_True_Patlak,Num_real,1);
%Ct_Mean_Patlak=mean(Ct_True_Patlak,'all'); % New noise model
%Ct_Noisy_Patlak=Ct_True_Patlak + (Ct_Mean_Patlak.*scale_factor.*0.01.*randn(Num_real,size(PI_Time,2))); % New noise model
Ct_Noisy_Patlak=Ct_True_Patlak + (Ct_True_Patlak.*scale_factor*0.01.*randn(Num_real,size(PI_Time,2))); % Original noise model
Ct_Noisy_Patlak(Ct_Noisy_Patlak < 0)=0; % to remove negative values


for i=1:1:Num_real
    for p=1:1:size(PI_Time,2)
        X_Patlak(i,p)=integral(Func_Exp_4, 0, PI_Time(p), 'ArrayValued',true)/Cp(p); % for Exp_4
        Y_Patlak(i,p)=Ct_Noisy_Patlak(i,p)/Cp(p);
    end
end

Starting_Patlak=[0;1];
LB_Patlak=[-10;0];
UB_Patlak=[10;10];
for i=1:1:Num_real
    x_temp=X_Patlak(i,:);
    y_temp=Y_Patlak(i,:);
    [Estimates,SSE,Residual,d,e,f,Jacobian]=lsqcurvefit(@Linear_Fit, Starting_Patlak, x_temp,y_temp, LB_Patlak, UB_Patlak,options);
    [ci, se]=nlparci(Estimates, Residual, 'jacobian', Jacobian);
    parameters_Patlak{i,1}=Estimates;
    RE_Patlak{i,1}=abs((se./Estimates))*100;
    %MSE_Patlak{i,1}=SSE/size(y_temp,1);
    %MSE_Patlak_Scaled{i,1}=sum(((Residual.*Cp).^(2)),'all')/size(y_temp,1);
    Ki_Patlak{i,1}=Estimates(2); % for Ki
    Vd_Patlak{i,1}=Estimates(1); % for Vd
end

%% 4) PCDE with FLT
% Denosing by FLT
nl=10; % Legendre Polynomial's max order
kmax=3; % cut-off order for denoising
Num_p=size(PI_Time,2); % # of data points
for i=1:1:Num_real
    y_py=py.numpy.array(transpose(Ct_Noisy(i,:)));
    FLT_results_py= py.LegendrePolynomials.LT(y_py,py.numpy.array(nl));	% FLT 
    FLT_results=double(FLT_results_py);
    FLT_results_truncated=FLT_results(1,1:kmax);
    FLT_results_truncated_py=py.numpy.array(FLT_results_truncated);
    iFLT_results_py=py.LegendrePolynomials.iLT(FLT_results_truncated_py,py.numpy.array(Num_p)); % iFLT
    iFLT_results=transpose(double(iFLT_results_py));
    if i==1
        Ct_Denoisy=transpose(iFLT_results);
    else
        Ct_Denoisy=cat(1, Ct_Denoisy,transpose(iFLT_results));
    end
end
Ct_Denoisy(Ct_Denoisy < 0)=0; % to remove negative values

for i=1:1:Num_real
    %tic;
    %% Time Series Classification by Deep Learning
    %organ=double(classify(net,Ct_Denoisy(i,:)));
    %param=k_True_class(organ,:);
    %if i==1
    %    chosen_params=param;
    %else
    %    chosen_params=cat(1, chosen_params, param);
    %end

    %% Original Algorithm
    Y_data_repmat=repmat(Ct_Denoisy(i,:), size(permutes,1),1);

    %% Exp_fit for Noisy data
    %if Ct_Denoisy(i,1) > Ct_Denoisy(i,end) % Neg. Slope
    %    Starting=[-1*max(Ct_Denoisy(i,:)),0,0];
    %    lb=[-10000,-10000,-10000];
    %    ub=[10000,10000,10000];
    %else % Pos. Slope
    %    Starting=[0,0, max(Ct_Denoisy(i,:))];
    %    lb=[-10000,-10000,-10000];
    %    ub=[10000,10000,10000];
    %end
    %[Estimates,SSE,Residual,d,e,f,Jacobian]=lsqcurvefit(@Exp_New, Starting, PI_Time,Ct_Denoisy(i,:),lb,ub,options); % for C-A*exp(-B*t)
    %Fitted_Noisy=Exp_New(Estimates,[10:10:90]); % for C-A*exp(-B*t)
    %Y_data_repmat=repmat(Fitted_Noisy, size(permutes,1),1);


    %[sort_val,sort_ind]=sort( sum(abs(true_database-Y_data_repmat) , 2) ); % 
    [sort_val,sort_ind]=sort( sum(abs(true_database-Y_data_repmat).^2 , 2) ); % 


    %[ind_min]=Similarity_Measure(permutes, sort_ind, Ct_Denoisy(i,:), PI_Time);
    [ind_min]=Similarity_Measure2(permutes, sort_ind, Ct_Denoisy(i,:), PI_Time, PI_Time_fine);

    if i==1
        chosen_params=permutes(ind_min,:);
    else
        chosen_params=cat(1, chosen_params, permutes(ind_min,:));
    end
    Min_ind(1,i)=ind_min;
    %toc;
end
%% Generating artificial Ct at Early PI Time
%Early_PI_Time=[0:1:9];
%for i=1:1:Num_real
%    if i==1
%        Ct_early=TTCM_analytic(chosen_params(i,:),Early_PI_Time);
%    else
%        Ct_early=cat(1,Ct_early,TTCM_analytic(chosen_params(i,:),Early_PI_Time));
%    end
%end
%PI_Time_full=cat(2,Early_PI_Time,PI_Time);
%Ct_full=cat(2, Ct_early,Ct_Denoisy); % artificial Ct (Ct_full= Ct_early + Ct_late)

% fitting with the artificial Ct
%Starting_PCDE_FLT=[0.5;0.5;0.05;0];
%LB_PCDE_FLT=[0;0;0;0];
%UB_PCDE_FLT=[1;1;1;0];
%for i=1:1:Num_real
%    x_temp=PI_Time_full;
%    y_temp=Ct_full(i,:);
%    [Estimates,SSE,Residual,d,e,f,Jacobian]=lsqcurvefit(@TTCM_analytic, Starting_PCDE_FLT, x_temp,y_temp, LB_PCDE_FLT, UB_PCDE_FLT);
%    [ci, se]=nlparci(Estimates, Residual, 'jacobian', Jacobian);
%    parameters_PCDE_FLT{i,1}=Estimates; % for Micro-parameters
%    RE_PCDE_FLT{i,1}=abs((se./Estimates))*100;
%    %MSE_PCDE{i,1}=SSE/size(y_temp,1);
%    Ki_PCDE_FLT{i,1}=(Estimates(1)*Estimates(3)) / (Estimates(2)+Estimates(3)); % for Ki
%    Vd_PCDE_FLT{i,1}=(Estimates(1)*Estimates(2)) / ((Estimates(2)+Estimates(3))^2); % for Vd
%    k1_PCDE_FLT{i,1}=Estimates(1); % for k1
%    k2_PCDE_FLT{i,1}=Estimates(2); % for k2
%    k3_PCDE_FLT{i,1}=Estimates(3); % for k3
%    k4_PCDE_FLT{i,1}=Estimates(4); % for k4
%end

% data saving w/o fitting
for i=1:1:Num_real
    k1_PCDE_FLT{i,1}=chosen_params(i,1); % for k1
    k2_PCDE_FLT{i,1}=chosen_params(i,2); % for k2
    k3_PCDE_FLT{i,1}=chosen_params(i,3); % for k3
    k4_PCDE_FLT{i,1}=chosen_params(i,4); % for k4
    Ki_PCDE_FLT{i,1}=(chosen_params(i,1)*chosen_params(i,3)) / (chosen_params(i,2)+chosen_params(i,3)); % for Ki
    Vd_PCDE_FLT{i,1}=(chosen_params(i,1)*chosen_params(i,2)) / ((chosen_params(i,2)+chosen_params(i,3))^2); % for Vd
end


%% 5) PCDE with comparison in L-domain
%W_T=PI_Time.^(-1); % Weights
%NW_T=W_T./sum(W_T); % Normalized Weights
%W_L=[1:1:5].^(-1);
%NW_L=W_L/sum(W_L);
%for i=1:1:Num_real
%    tic;
%    Y_data_repmat=repmat(Ct_Denoisy(i,:), size(permutes,1),1);
%    [val,ind]=sort( sum(NW_T.*abs(true_database-Y_data_repmat) , 2) ); % LSE
%    sel_True_TACs=true_database(ind(1:10),:);
%    sel_FLT_database=make_FLT_database(sel_True_TACs); % FLT of selected True TACs
%    Ct_Noisy_FLT=make_FLT_database(Ct_Denoisy(i,:)); % FLT of Ct_Noisy
%    Ct_Noisy_FLT=repmat(Ct_Noisy_FLT, 10,1);
%    [val_temp,ind_temp]=sort( sum( NW_L.*abs(sel_FLT_database-Ct_Noisy_FLT) , 2) );
%    ind_min=ind(ind_temp(1));
%    if i==1
%        chosen_params=permutes(ind_min,:);
%    else
%        chosen_params=cat(1, chosen_params, permutes(ind_min,:));
%    end
%    Min_ind(1,i)=ind_min;
%    toc;
%end

%% Comparison of results between the three methods (1. 2TCM, 2. PCDE, 3. Patlak)

% Bias [%]
% for Ki
Bias_Ki_2TCM=abs(mean(cell2mat(Ki_2TCM),'all')-Ki_True);
Bias_Ki_PCDE=abs(mean(cell2mat(Ki_PCDE),'all')-Ki_True);
Bias_Ki_PCDE_FLT=abs(mean(cell2mat(Ki_PCDE_FLT),'all')-Ki_True);
Bias_Ki_Patlak=abs(mean(cell2mat(Ki_Patlak),'all')-Ki_True);
NBias_Ki_2TCM=abs(mean(cell2mat(Ki_2TCM),'all')-Ki_True)/Ki_True*100;
NBias_Ki_PCDE=abs(mean(cell2mat(Ki_PCDE),'all')-Ki_True)/Ki_True*100;
NBias_Ki_PCDE_FLT=abs(mean(cell2mat(Ki_PCDE_FLT),'all')-Ki_True)/Ki_True*100;
NBias_Ki_Patlak=abs(mean(cell2mat(Ki_Patlak),'all')-Ki_True)/Ki_True*100;
% for Vd
Bias_Vd_2TCM=abs(mean(cell2mat(Vd_2TCM),'all')-Vd_True);
Bias_Vd_PCDE=abs(mean(cell2mat(Vd_PCDE),'all')-Vd_True);
Bias_Vd_PCDE_FLT=abs(mean(cell2mat(Vd_PCDE_FLT),'all')-Vd_True);
Bias_Vd_Patlak=abs(mean(cell2mat(Vd_Patlak),'all')-Vd_True);
NBias_Vd_2TCM=abs(mean(cell2mat(Vd_2TCM),'all')-Vd_True)/Vd_True*100;
NBias_Vd_PCDE=abs(mean(cell2mat(Vd_PCDE),'all')-Vd_True)/Vd_True*100;
NBias_Vd_PCDE_FLT=abs(mean(cell2mat(Vd_PCDE_FLT),'all')-Vd_True)/Vd_True*100;
NBias_Vd_Patlak=abs(mean(cell2mat(Vd_Patlak),'all')-Vd_True)/Vd_True*100;
% for k1
Bias_k1_2TCM=abs(mean(cell2mat(k1_2TCM),'all')-k1_True);
Bias_k1_PCDE=abs(mean(cell2mat(k1_PCDE),'all')-k1_True);
Bias_k1_PCDE_FLT=abs(mean(cell2mat(k1_PCDE_FLT),'all')-k1_True);
NBias_k1_2TCM=abs(mean(cell2mat(k1_2TCM),'all')-k1_True)/k1_True*100;
NBias_k1_PCDE=abs(mean(cell2mat(k1_PCDE),'all')-k1_True)/k1_True*100;
NBias_k1_PCDE_FLT=abs(mean(cell2mat(k1_PCDE_FLT),'all')-k1_True)/k1_True*100;
% for k2
Bias_k2_2TCM=abs(mean(cell2mat(k2_2TCM),'all')-k2_True);
Bias_k2_PCDE=abs(mean(cell2mat(k2_PCDE),'all')-k2_True);
Bias_k2_PCDE_FLT=abs(mean(cell2mat(k2_PCDE_FLT),'all')-k2_True);
NBias_k2_2TCM=abs(mean(cell2mat(k2_2TCM),'all')-k2_True)/k2_True*100;
NBias_k2_PCDE=abs(mean(cell2mat(k2_PCDE),'all')-k2_True)/k2_True*100;
NBias_k2_PCDE_FLT=abs(mean(cell2mat(k2_PCDE_FLT),'all')-k2_True)/k2_True*100;
% for k3
Bias_k3_2TCM=abs(mean(cell2mat(k3_2TCM),'all')-k3_True);
Bias_k3_PCDE=abs(mean(cell2mat(k3_PCDE),'all')-k3_True);
Bias_k3_PCDE_FLT=abs(mean(cell2mat(k3_PCDE_FLT),'all')-k3_True);
NBias_k3_2TCM=abs(mean(cell2mat(k3_2TCM),'all')-k3_True)/k3_True*100;
NBias_k3_PCDE=abs(mean(cell2mat(k3_PCDE),'all')-k3_True)/k3_True*100;
NBias_k3_PCDE_FLT=abs(mean(cell2mat(k3_PCDE_FLT),'all')-k3_True)/k3_True*100;

% for k4
Bias_k4_2TCM=abs(mean(cell2mat(k4_2TCM),'all')-k4_True);
Bias_k4_PCDE=abs(mean(cell2mat(k4_PCDE),'all')-k4_True);
Bias_k4_PCDE_FLT=abs(mean(cell2mat(k4_PCDE_FLT),'all')-k4_True);
NBias_k4_2TCM=abs(mean(cell2mat(k4_2TCM),'all')-k4_True)/k4_True*100;
NBias_k4_PCDE=abs(mean(cell2mat(k4_PCDE),'all')-k4_True)/k4_True*100;
NBias_k4_PCDE_FLT=abs(mean(cell2mat(k4_PCDE_FLT),'all')-k4_True)/k4_True*100;

% SD
Mean_Pred_Ki_2TCM=mean(cell2mat(Ki_2TCM),'all');
Mean_Pred_Ki_PCDE=mean(cell2mat(Ki_PCDE),'all');
Mean_Pred_Ki_PCDE_FLT=mean(cell2mat(Ki_PCDE_FLT),'all');
Mean_Pred_Ki_Patlak=mean(cell2mat(Ki_Patlak),'all');
Mean_Pred_Vd_2TCM=mean(cell2mat(Vd_2TCM),'all');
Mean_Pred_Vd_PCDE=mean(cell2mat(Vd_PCDE),'all');
Mean_Pred_Vd_PCDE_FLT=mean(cell2mat(Vd_PCDE_FLT),'all');
Mean_Pred_Vd_Patlak=mean(cell2mat(Vd_Patlak),'all');
Mean_Pred_k1_2TCM=mean(cell2mat(k1_2TCM),'all');
Mean_Pred_k1_PCDE=mean(cell2mat(k1_PCDE),'all');
Mean_Pred_k1_PCDE_FLT=mean(cell2mat(k1_PCDE_FLT),'all');
Mean_Pred_k2_2TCM=mean(cell2mat(k2_2TCM),'all');
Mean_Pred_k2_PCDE=mean(cell2mat(k2_PCDE),'all');
Mean_Pred_k2_PCDE_FLT=mean(cell2mat(k2_PCDE_FLT),'all');
Mean_Pred_k3_2TCM=mean(cell2mat(k3_2TCM),'all');
Mean_Pred_k3_PCDE=mean(cell2mat(k3_PCDE),'all');
Mean_Pred_k3_PCDE_FLT=mean(cell2mat(k3_PCDE_FLT),'all');
Mean_Pred_k4_2TCM=mean(cell2mat(k4_2TCM),'all');
Mean_Pred_k4_PCDE=mean(cell2mat(k4_PCDE),'all');
Mean_Pred_k4_PCDE_FLT=mean(cell2mat(k4_PCDE_FLT),'all');
% for Ki
SD_Ki_2TCM=std(cell2mat(Ki_2TCM),1,'all');
SD_Ki_PCDE=std(cell2mat(Ki_PCDE),1,'all');
SD_Ki_PCDE_FLT=std(cell2mat(Ki_PCDE_FLT),1,'all');
SD_Ki_Patlak=std(cell2mat(Ki_Patlak),1,'all');
NSD_Ki_2TCM=std(cell2mat(Ki_2TCM),1,'all')/Mean_Pred_Ki_2TCM*100;
NSD_Ki_PCDE=std(cell2mat(Ki_PCDE),1,'all')/Mean_Pred_Ki_PCDE*100;
NSD_Ki_PCDE_FLT=std(cell2mat(Ki_PCDE_FLT),1,'all')/Mean_Pred_Ki_PCDE_FLT*100;
NSD_Ki_Patlak=std(cell2mat(Ki_Patlak),1,'all')/Mean_Pred_Ki_Patlak*100;
% for Vd
SD_Vd_2TCM=std(cell2mat(Vd_2TCM),1,'all');
SD_Vd_PCDE=std(cell2mat(Vd_PCDE),1,'all');
SD_Vd_PCDE_FLT=std(cell2mat(Vd_PCDE_FLT),1,'all');
SD_Vd_Patlak=std(cell2mat(Vd_Patlak),1,'all');
NSD_Vd_2TCM=std(cell2mat(Vd_2TCM),1,'all')/Mean_Pred_Vd_2TCM*100;
NSD_Vd_PCDE=std(cell2mat(Vd_PCDE),1,'all')/Mean_Pred_Vd_PCDE*100;
NSD_Vd_PCDE_FLT=std(cell2mat(Vd_PCDE_FLT),1,'all')/Mean_Pred_Vd_PCDE_FLT*100;
NSD_Vd_Patlak=std(cell2mat(Vd_Patlak),1,'all')/Mean_Pred_Vd_Patlak*100;
% for k1
SD_k1_2TCM=std(cell2mat(k1_2TCM),1,'all');
SD_k1_PCDE=std(cell2mat(k1_PCDE),1,'all');
SD_k1_PCDE_FLT=std(cell2mat(k1_PCDE_FLT),1,'all');
NSD_k1_2TCM=std(cell2mat(k1_2TCM),1,'all')/Mean_Pred_k1_2TCM*100;
NSD_k1_PCDE=std(cell2mat(k1_PCDE),1,'all')/Mean_Pred_k1_PCDE*100;
NSD_k1_PCDE_FLT=std(cell2mat(k1_PCDE_FLT),1,'all')/Mean_Pred_k1_PCDE_FLT*100;
% for k2
SD_k2_2TCM=std(cell2mat(k2_2TCM),1,'all');
SD_k2_PCDE=std(cell2mat(k2_PCDE),1,'all');
SD_k2_PCDE_FLT=std(cell2mat(k2_PCDE_FLT),1,'all');
NSD_k2_2TCM=std(cell2mat(k2_2TCM),1,'all')/Mean_Pred_k2_2TCM*100;
NSD_k2_PCDE=std(cell2mat(k2_PCDE),1,'all')/Mean_Pred_k2_PCDE*100;
NSD_k2_PCDE_FLT=std(cell2mat(k2_PCDE_FLT),1,'all')/Mean_Pred_k2_PCDE_FLT*100;
% for k3
SD_k3_2TCM=std(cell2mat(k3_2TCM),1,'all');
SD_k3_PCDE=std(cell2mat(k3_PCDE),1,'all');
SD_k3_PCDE_FLT=std(cell2mat(k3_PCDE_FLT),1,'all');
NSD_k3_2TCM=std(cell2mat(k3_2TCM),1,'all')/Mean_Pred_k3_2TCM*100;
NSD_k3_PCDE=std(cell2mat(k3_PCDE),1,'all')/Mean_Pred_k3_PCDE*100;
NSD_k3_PCDE_FLT=std(cell2mat(k3_PCDE_FLT),1,'all')/Mean_Pred_k3_PCDE_FLT*100;
% for k4
SD_k4_2TCM=std(cell2mat(k4_2TCM),1,'all');
SD_k4_PCDE=std(cell2mat(k4_PCDE),1,'all');
SD_k4_PCDE_FLT=std(cell2mat(k4_PCDE_FLT),1,'all');
NSD_k4_2TCM=std(cell2mat(k4_2TCM),1,'all')/Mean_Pred_k4_2TCM*100;
NSD_k4_PCDE=std(cell2mat(k4_PCDE),1,'all')/Mean_Pred_k4_PCDE*100;
NSD_k4_PCDE_FLT=std(cell2mat(k4_PCDE_FLT),1,'all')/Mean_Pred_k4_PCDE_FLT*100;

% MSE (MSE=Bias^2+Variance=Bias^2+SD^2)
% for Ki
MSE_Ki_2TCM=mean((cell2mat(Ki_2TCM)-repmat(Ki_True,Num_real,1)).^(2),'all');
MSE_Ki_PCDE=mean((cell2mat(Ki_PCDE)-repmat(Ki_True,Num_real,1)).^(2),'all');
MSE_Ki_PCDE_FLT=mean((cell2mat(Ki_PCDE_FLT)-repmat(Ki_True,Num_real,1)).^(2),'all');
MSE_Ki_Patlak=mean((cell2mat(Ki_Patlak)-repmat(Ki_True,Num_real,1)).^(2),'all');
NMSE_Ki_2TCM= (((MSE_Ki_2TCM)^(0.5))/Ki_True)*100;
NMSE_Ki_PCDE= (((MSE_Ki_PCDE)^(0.5))/Ki_True)*100;
NMSE_Ki_PCDE_FLT= (((MSE_Ki_PCDE_FLT)^(0.5))/Ki_True)*100;
NMSE_Ki_Patlak= (((MSE_Ki_Patlak)^(0.5))/Ki_True)*100;

% for Vd
MSE_Vd_2TCM=mean((cell2mat(Vd_2TCM)-repmat(Vd_True,Num_real,1)).^(2),'all');
MSE_Vd_PCDE=mean((cell2mat(Vd_PCDE)-repmat(Vd_True,Num_real,1)).^(2),'all');
MSE_Vd_PCDE_FLT=mean((cell2mat(Vd_PCDE_FLT)-repmat(Vd_True,Num_real,1)).^(2),'all');
MSE_Vd_Patlak=mean((cell2mat(Vd_Patlak)-repmat(Vd_True,Num_real,1)).^(2),'all');
NMSE_Vd_2TCM= (((MSE_Vd_2TCM)^(0.5))/Vd_True)*100;
NMSE_Vd_PCDE= (((MSE_Vd_PCDE)^(0.5))/Vd_True)*100;
NMSE_Vd_PCDE_FLT= (((MSE_Vd_PCDE_FLT)^(0.5))/Vd_True)*100;
NMSE_Vd_Patlak= (((MSE_Vd_Patlak)^(0.5))/Vd_True)*100;

% for k1
MSE_k1_2TCM=mean((cell2mat(k1_2TCM)-repmat(k1_True,Num_real,1)).^(2),'all');
MSE_k1_PCDE=mean((cell2mat(k1_PCDE)-repmat(k1_True,Num_real,1)).^(2),'all');
MSE_k1_PCDE_FLT=mean((cell2mat(k1_PCDE_FLT)-repmat(k1_True,Num_real,1)).^(2),'all');
NMSE_k1_2TCM= (((MSE_k1_2TCM)^(0.5))/k1_True)*100;
NMSE_k1_PCDE= (((MSE_k1_PCDE)^(0.5))/k1_True)*100;
NMSE_k1_PCDE_FLT= (((MSE_k1_PCDE_FLT)^(0.5))/k1_True)*100;
% for k2
MSE_k2_2TCM=mean((cell2mat(k2_2TCM)-repmat(k2_True,Num_real,1)).^(2),'all');
MSE_k2_PCDE=mean((cell2mat(k2_PCDE)-repmat(k2_True,Num_real,1)).^(2),'all');
MSE_k2_PCDE_FLT=mean((cell2mat(k2_PCDE_FLT)-repmat(k2_True,Num_real,1)).^(2),'all');
NMSE_k2_2TCM= (((MSE_k2_2TCM)^(0.5))/k2_True)*100;
NMSE_k2_PCDE= (((MSE_k2_PCDE)^(0.5))/k2_True)*100;
NMSE_k2_PCDE_FLT= (((MSE_k2_PCDE_FLT)^(0.5))/k2_True)*100;
% for k3
MSE_k3_2TCM=mean((cell2mat(k3_2TCM)-repmat(k3_True,Num_real,1)).^(2),'all');
MSE_k3_PCDE=mean((cell2mat(k3_PCDE)-repmat(k3_True,Num_real,1)).^(2),'all');
MSE_k3_PCDE_FLT=mean((cell2mat(k3_PCDE_FLT)-repmat(k3_True,Num_real,1)).^(2),'all');
NMSE_k3_2TCM= (((MSE_k3_2TCM)^(0.5))/k3_True)*100;
NMSE_k3_PCDE= (((MSE_k3_PCDE)^(0.5))/k3_True)*100;
NMSE_k3_PCDE_FLT= (((MSE_k3_PCDE_FLT)^(0.5))/k3_True)*100;
% for k4
MSE_k4_2TCM=mean((cell2mat(k4_2TCM)-repmat(k4_True,Num_real,1)).^(2),'all');
MSE_k4_PCDE=mean((cell2mat(k4_PCDE)-repmat(k4_True,Num_real,1)).^(2),'all');
MSE_k4_PCDE_FLT=mean((cell2mat(k4_PCDE_FLT)-repmat(k4_True,Num_real,1)).^(2),'all');
NMSE_k4_2TCM= (((MSE_k4_2TCM)^(0.5))/k4_True)*100;
NMSE_k4_PCDE= (((MSE_k4_PCDE)^(0.5))/k4_True)*100;
NMSE_k4_PCDE_FLT= (((MSE_k4_PCDE_FLT)^(0.5))/k4_True)*100;

%% Summarizing the results
% Bias
% for Micro-parameters
Bias_micro_2TCM=[Bias_k1_2TCM;Bias_k2_2TCM;Bias_k3_2TCM;Bias_k4_2TCM];
Bias_micro_PCDE=[Bias_k1_PCDE;Bias_k2_PCDE;Bias_k3_PCDE;Bias_k4_PCDE];
Bias_micro_PCDE_FLT=[Bias_k1_PCDE_FLT;Bias_k2_PCDE_FLT;Bias_k3_PCDE_FLT;Bias_k4_PCDE_FLT];
NBias_micro_2TCM=[NBias_k1_2TCM;NBias_k2_2TCM;NBias_k3_2TCM;NBias_k4_2TCM];
NBias_micro_PCDE=[NBias_k1_PCDE;NBias_k2_PCDE;NBias_k3_PCDE;NBias_k4_PCDE];
NBias_micro_PCDE_FLT=[NBias_k1_PCDE_FLT;NBias_k2_PCDE_FLT;NBias_k3_PCDE_FLT;NBias_k4_PCDE_FLT];
% for Macro-parameters
Bias_macro_2TCM=[Bias_Ki_2TCM;Bias_Vd_2TCM];
Bias_macro_PCDE=[Bias_Ki_PCDE;Bias_Vd_PCDE];
Bias_macro_PCDE_FLT=[Bias_Ki_PCDE_FLT;Bias_Vd_PCDE_FLT];
Bias_macro_Patlak=[Bias_Ki_Patlak;Bias_Vd_Patlak];
NBias_macro_2TCM=[NBias_Ki_2TCM;NBias_Vd_2TCM];
NBias_macro_PCDE=[NBias_Ki_PCDE;NBias_Vd_PCDE];
NBias_macro_PCDE_FLT=[NBias_Ki_PCDE_FLT;NBias_Vd_PCDE_FLT];
NBias_macro_Patlak=[NBias_Ki_Patlak;NBias_Vd_Patlak];

% SD
% for Micro-parameters
SD_micro_2TCM=[SD_k1_2TCM;SD_k2_2TCM;SD_k3_2TCM;SD_k4_2TCM];
SD_micro_PCDE=[SD_k1_PCDE;SD_k2_PCDE;SD_k3_PCDE;SD_k4_PCDE];
SD_micro_PCDE_FLT=[SD_k1_PCDE_FLT;SD_k2_PCDE_FLT;SD_k3_PCDE_FLT;SD_k4_PCDE_FLT];
NSD_micro_2TCM=[NSD_k1_2TCM;NSD_k2_2TCM;NSD_k3_2TCM;NSD_k4_2TCM];
NSD_micro_PCDE=[NSD_k1_PCDE;NSD_k2_PCDE;NSD_k3_PCDE;NSD_k4_PCDE];
NSD_micro_PCDE_FLT=[NSD_k1_PCDE_FLT;NSD_k2_PCDE_FLT;NSD_k3_PCDE_FLT;NSD_k4_PCDE_FLT];
% for Macro-parameters
SD_macro_2TCM=[SD_Ki_2TCM;SD_Vd_2TCM];
SD_macro_PCDE=[SD_Ki_PCDE;SD_Vd_PCDE];
SD_macro_PCDE_FLT=[SD_Ki_PCDE_FLT;SD_Vd_PCDE_FLT];
SD_macro_Patlak=[SD_Ki_Patlak;SD_Vd_Patlak];
NSD_macro_2TCM=[NSD_Ki_2TCM;NSD_Vd_2TCM];
NSD_macro_PCDE=[NSD_Ki_PCDE;NSD_Vd_PCDE];
NSD_macro_PCDE_FLT=[NSD_Ki_PCDE_FLT;NSD_Vd_PCDE_FLT];
NSD_macro_Patlak=[NSD_Ki_Patlak;NSD_Vd_Patlak];

% MSE
% for Micro-parameters
MSE_micro_2TCM=[MSE_k1_2TCM;MSE_k2_2TCM;MSE_k3_2TCM;MSE_k4_2TCM];
MSE_micro_PCDE=[MSE_k1_PCDE;MSE_k2_PCDE;MSE_k3_PCDE;MSE_k4_PCDE];
MSE_micro_PCDE_FLT=[MSE_k1_PCDE_FLT;MSE_k2_PCDE_FLT;MSE_k3_PCDE_FLT;MSE_k4_PCDE_FLT];
NMSE_micro_2TCM=[NMSE_k1_2TCM;NMSE_k2_2TCM;NMSE_k3_2TCM;NMSE_k4_2TCM];
NMSE_micro_PCDE=[NMSE_k1_PCDE;NMSE_k2_PCDE;NMSE_k3_PCDE;NMSE_k4_PCDE];
NMSE_micro_PCDE_FLT=[NMSE_k1_PCDE_FLT;NMSE_k2_PCDE_FLT;NMSE_k3_PCDE_FLT;NMSE_k4_PCDE_FLT];
% for Macro-parameters
MSE_macro_2TCM=[MSE_Ki_2TCM;MSE_Vd_2TCM];
MSE_macro_PCDE=[MSE_Ki_PCDE;MSE_Vd_PCDE];
MSE_macro_PCDE_FLT=[MSE_Ki_PCDE_FLT;MSE_Vd_PCDE_FLT];
MSE_macro_Patlak=[MSE_Ki_Patlak;MSE_Vd_Patlak];
NMSE_macro_2TCM=[NMSE_Ki_2TCM;NMSE_Vd_2TCM];
NMSE_macro_PCDE=[NMSE_Ki_PCDE;NMSE_Vd_PCDE];
NMSE_macro_PCDE_FLT=[NMSE_Ki_PCDE_FLT;NMSE_Vd_PCDE_FLT];
NMSE_macro_Patlak=[NMSE_Ki_Patlak;NMSE_Vd_Patlak];
% for Mean_Pred
% for Micro-parameters
Mean_Pred_micro_2TCM=[Mean_Pred_k1_2TCM;Mean_Pred_k2_2TCM;Mean_Pred_k3_2TCM;Mean_Pred_k4_2TCM];
Mean_Pred_micro_PCDE=[Mean_Pred_k1_PCDE;Mean_Pred_k2_PCDE;Mean_Pred_k3_PCDE;Mean_Pred_k4_PCDE];
Mean_Pred_micro_PCDE_FLT=[Mean_Pred_k1_PCDE_FLT;Mean_Pred_k2_PCDE_FLT;Mean_Pred_k3_PCDE_FLT;Mean_Pred_k4_PCDE_FLT];
% for Macro-parameters
Mean_Pred_macro_2TCM=[Mean_Pred_Ki_2TCM;Mean_Pred_Vd_2TCM];
Mean_Pred_macro_PCDE=[Mean_Pred_Ki_PCDE;Mean_Pred_Vd_PCDE];
Mean_Pred_macro_PCDE_FLT=[Mean_Pred_Ki_PCDE_FLT;Mean_Pred_Vd_PCDE_FLT];
Mean_Pred_macro_Patlak=[Mean_Pred_Ki_Patlak;Mean_Pred_Vd_Patlak];
% for excel file
Bias_Excel=[Bias_micro_2TCM;Bias_macro_2TCM;Bias_micro_PCDE;Bias_macro_PCDE;Bias_micro_PCDE_FLT;Bias_macro_PCDE_FLT;Bias_macro_Patlak];
SD_Excel=[SD_micro_2TCM;SD_macro_2TCM;SD_micro_PCDE;SD_macro_PCDE;SD_micro_PCDE_FLT;SD_macro_PCDE_FLT;SD_macro_Patlak];
NBias_Excel=[NBias_micro_2TCM;NBias_macro_2TCM;NBias_micro_PCDE;NBias_macro_PCDE;NBias_micro_PCDE_FLT;NBias_macro_PCDE_FLT;NBias_macro_Patlak];
NSD_Excel=[NSD_micro_2TCM;NSD_macro_2TCM;NSD_micro_PCDE;NSD_macro_PCDE;NSD_micro_PCDE_FLT;NSD_macro_PCDE_FLT;NSD_macro_Patlak];
NMSE_Excel=[NMSE_micro_2TCM;NMSE_macro_2TCM;NMSE_micro_PCDE;NMSE_macro_PCDE;NMSE_micro_PCDE_FLT;NMSE_macro_PCDE_FLT;NMSE_macro_Patlak];
Mean_Pred_Excel=[Mean_Pred_micro_2TCM;Mean_Pred_macro_2TCM;Mean_Pred_micro_PCDE;Mean_Pred_macro_PCDE;Mean_Pred_micro_PCDE_FLT;Mean_Pred_macro_PCDE_FLT;Mean_Pred_macro_Patlak];
Excel=[NMSE_Excel,NBias_Excel,NSD_Excel,Mean_Pred_Excel];
% NBias==> [%], NSD==> [%], NMSE ==> [%]


% for calculation of RMSE (Noisy v.s. denoised by FLT)
% for Noisy data
Squared_E=(Ct_Noisy-Ct_True).^(2);
R_Sum_Squared_E=(sum(Squared_E,2)).^(0.5);
RMSE=mean(R_Sum_Squared_E);
% for Denoised data
De_Squared_E=(Ct_Denoisy-Ct_True).^(2);
De_R_Sum_Squared_E=(sum(De_Squared_E,2)).^(0.5);
De_RMSE=mean(De_R_Sum_Squared_E);
RMSE_Info=[RMSE, De_RMSE]; % RMSE_Noisy, RMSE_Denoised

end

