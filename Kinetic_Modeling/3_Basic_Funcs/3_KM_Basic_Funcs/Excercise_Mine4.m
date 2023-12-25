%% Object #1 test!!
options = optimoptions('lsqcurvefit','Display', 'off');
global Local_Estimates
Local_Estimates=[17.86;0.00841;-3423.59;1.23;3348.58;1.13929;17.67;0.06774];
PI_Time=[0:1:120];

Num_real=10;
scale_factor=10;

%k_True=[0.6,0.2,0.1,0.001];
%k_True=[0.03,0.13,0.05,0.001]; %2

k_True=[0.09,0.25,0.22,0.001]; %1
%k_True=[0.03,0.13,0.05,0.001]; %2
%k_True=[0.13,0.63,0.19,0]; %3
%k_True=[0.97,1,0.07,0]; %  %4
%k_True=[0.82,1,0.19,0]; %  %5
%k_True=[0.01,0.36,0.03,0]; %6
%k_True=[0.41,0.51,0.01,0]; %7
%k_True=[0.88,1,0.04,0]; %  %8
%k_True=[0.36,1,0.08,0]; %  %9
%k_True=[0.70,1,0.18,0]; %  %10
%k_True=[0.03,0.32,0.05,0]; %11
%k_True=[0.15,0.71,0.05,0]; %12
%k_True=[0.86,0.98,0.01,0]; %13
%k_True=[0.11,0.74,0.02,0]; %14

k1_True=k_True(1);
k2_True=k_True(2);
k3_True=k_True(3);
k4_True=k_True(4);

global Ct_Noisy;
Ct_True=TTCM_analytic_Multi(k_True,PI_Time); % with Exp_4
Ct_True=repmat(Ct_True,Num_real,1);
Ct_Noisy=Ct_True + (Ct_True.*scale_factor*0.01.*randn(Num_real,size(PI_Time,2))); % original noise model

%% Generalized PATLAK & (for True data)
k_loss= (k2_True*k4_True) / (k2_True+k3_True);
Func_Exp_4_Multiplied = @(tau) Exp_4_Multiplied_Exp_Loss([Local_Estimates;k_loss], tau);
Cp=Exp_4(Local_Estimates,PI_Time); % for Exp_4

% Patlak
for i=1:1:Num_real
    for p=1:1:size(PI_Time,2)
        X_Patlak(i,p)=(exp(-1*k_loss*PI_Time(p))*integral(Func_Exp_4_Multiplied, 0, PI_Time(p), 'ArrayValued',true)) / Cp(p); % for Exp_4
        Y_Patlak(i,p)=Ct_True(i,p)/Cp(p);
    end
end

% Polyfit (for Patlak plot) ==> having same results with TPL
%for i=1:1:Num_real
%    p_Patlak = polyfit(X_Patlak(i,:),Y_Patlak(i,:),1);
%    Params_Patlak_poly_True(i,:)=p_Patlak;
%end
% Two_Phase_Lin (for Patlak plot)
Starting=[0,0,0,0];
LB=[0,-100000,0,-100000];
UB=[100000,100000,100000,100000];
for i=1:1:Num_real
    X_temp=X_Patlak(i,:);
    Y_temp=Y_Patlak(i,:);
    [Estimates,SSE,Residual,d,e,f,Jacobian]=lsqcurvefit(@Two_phase_Lin, Starting, X_temp, Y_temp, LB, UB,options);
    Params_Patlak_TPL_True(i,:)=Estimates;
end

% True values of Ki,Vd,Vb
Ki_True= Params_Patlak_TPL_True(:,3);
Vd_True= Params_Patlak_TPL_True(:,4);
Vb_True= Params_Patlak_TPL_True(:,4) - ( k1_True*k2_True/((k2_True+k3_True)^2) );


%% Generalized PATLAK (for Noisy data at late PI Time)
Time_Noisy=[10:3:120];
Ct_Noisy_sel=Ct_Noisy(:,Time_Noisy);
Func_Exp_4_Multiplied = @(tau) Exp_4_Multiplied_Exp_Loss([Local_Estimates;k_loss], tau);
Cp_Noisy=Exp_4(Local_Estimates,Time_Noisy); % for Exp_4

% Patlak
for i=1:1:Num_real
    for p=1:1:size(Time_Noisy,2)
        X_Patlak_Noisy(i,p)= (exp(-1*k_loss*Time_Noisy(p))*integral(Func_Exp_4_Multiplied, 0, Time_Noisy(p), 'ArrayValued',true)) / Cp_Noisy(p);% for Exp_4      
        Y_Patlak_Noisy(i,p)=Ct_Noisy_sel(i,p)/Cp_Noisy(p);
    end
end
% Two_Phase_Lin (for Patlak plot)
Starting=[0,0,0,0];
LB=[0,-100000,0,0];
UB=[100000,100000,100000,100000];
for i=1:1:Num_real
    X_temp=X_Patlak_Noisy(i,:);
    Y_temp=Y_Patlak_Noisy(i,:);
    [Estimates,SSE,Residual,d,e,f,Jacobian]=lsqcurvefit(@Two_phase_Lin, Starting, X_temp, Y_temp, LB, UB,options);
    Params_Patlak_TPL_Noisy(i,:)=Estimates;
end


%% Denoising
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


%% Generalized PATLAK (for Denoisy data at late PI Time)
Ct_Denoisy_sel=Ct_Denoisy(:,Time_Noisy);
Func_Exp_4_Multiplied = @(tau) Exp_4_Multiplied_Exp_Loss([Local_Estimates;k_loss], tau);
Cp_Denoisy=Exp_4(Local_Estimates,Time_Noisy); % for Exp_4

% Patlak
for i=1:1:Num_real
    for p=1:1:size(Time_Noisy,2)
        X_Patlak_Denoisy(i,p)=(exp(-1*k_loss*Time_Noisy(p))*integral(Func_Exp_4_Multiplied, 0, Time_Noisy(p), 'ArrayValued',true)) / Cp_Denoisy(p); % for Exp_4
        Y_Patlak_Denoisy(i,p)=Ct_Denoisy_sel(i,p)/Cp_Denoisy(p);
    end
end
% Two_Phase_Lin (for Patlak plot)
Starting=[0,0,0,0];
LB=[0,-100000,0,0];
UB=[100000,100000,100000,100000];
for i=1:1:Num_real
    X_temp=X_Patlak_Denoisy(i,:);
    Y_temp=Y_Patlak_Denoisy(i,:);
    [Estimates,SSE,Residual,d,e,f,Jacobian]=lsqcurvefit(@Two_phase_Lin, Starting, X_temp, Y_temp, LB, UB,options);
    Params_Patlak_TPL_Denoisy(i,:)=Estimates;
end


%% LOGAN (for True data)
Func_TTCM=@(tau) TTCM_analytic_Multi(k_True,tau);
Func_Exp_4=@(tau) Exp_4(Local_Estimates,tau); % for Exp_4
Cp=Exp_4(Local_Estimates,PI_Time); % for Exp_4
% Logan
for i=1:1:Num_real
    for p=1:1:size(PI_Time,2)
        X_Logan(i,p)=integral(Func_Exp_4, 0, PI_Time(p), 'ArrayValued',true) / Ct_True(i,p); % for Exp_4
        Y_Logan(i,p)=integral(Func_TTCM, 0, PI_Time(p),'ArrayValued', true) / Ct_True(i,p);
    end
end
X_Logan(:,1)=0; %removing NaN
Y_Logan(:,1)=0;

% Two_Phase_Lin (for Logan plot)
Starting=[0,0,0,0];
LB=[0,-100000,0,-100000];
UB=[100000,100000,100000,100000];
for i=1:1:Num_real
    X_temp=X_Logan(i,:);
    Y_temp=Y_Logan(i,:);
    [Estimates,SSE,Residual,d,e,f,Jacobian]=lsqcurvefit(@Two_phase_Lin, Starting, X_temp, Y_temp, LB, UB,options);
    Params_Logan_TPL_True(i,:)=Estimates;
end
%t_thre=(Params_Logan_TPL_True(1,2)-Params_Logan_TPL_True(1,4)) / (Params_Logan_TPL_True(1,3)-Params_Logan_TPL_True(1,1));
%Fitted=[transpose([0:1:40]), transpose(Two_phase_Lin(Params_Logan_TPL_True(1,:),[0:1:40]))];
%plot(X_Logan(1,:),Y_Logan(1,:))

%% LOGAN (for for Noisy data at late PI Time)
Ct_art_Noisy=[Ct_True(:,1:10),Ct_Noisy_sel];
Time_art=[0:1:9,Time_Noisy];
Func_Exp_4=@(tau) Exp_4(Local_Estimates,tau); % for Exp_4
Cp=Exp_4(Local_Estimates,Time_art); % for Exp_4

% Logan
for i=1:1:Num_real
    for p=1:1:size(Time_art,2)
        if p==1
            X_Logan_art_Noisy(i,p)=0;
            Y_Logan_art_Noisy(i,p)=0;
        else
            X_Logan_art_Noisy(i,p)=integral(Func_Exp_4, 0, Time_art(p), 'ArrayValued',true) / Ct_art_Noisy(i,p); % for Exp_4
            Y_Logan_art_Noisy(i,p)= trapz(Time_art(1:p),Ct_art_Noisy(i,1:p)) / Ct_art_Noisy(i,p);
        end    
    end
end
% Two_Phase_Lin (for Logan plot)
Starting=[0,0,0,0];
LB=[0,-100000,0,-100000];
UB=[100000,100000,100000,100000];
for i=1:1:Num_real
    X_temp=X_Logan_art_Noisy(i,:);
    Y_temp=Y_Logan_art_Noisy(i,:);
    [Estimates,SSE,Residual,d,e,f,Jacobian]=lsqcurvefit(@Two_phase_Lin, Starting, X_temp, Y_temp, LB, UB,options);
    Params_Logan_TPL_art_Noisy(i,:)=Estimates;
end


%% LOGAN (for Denoisy data at late PI Time)
Ct_art_Denoisy=[Ct_True(:,1:10),Ct_Denoisy_sel];
Time_art=[0:1:9,Time_Noisy];
Func_Exp_4=@(tau) Exp_4(Local_Estimates,tau); % for Exp_4
Cp=Exp_4(Local_Estimates,Time_art); % for Exp_4

% Logan
for i=1:1:Num_real
    for p=1:1:size(Time_art,2)
        if p==1
            X_Logan_art_Denoisy(i,p)=0;
            Y_Logan_art_Denoisy(i,p)=0;
        else
            X_Logan_art_Denoisy(i,p)=integral(Func_Exp_4, 0, Time_art(p), 'ArrayValued',true) / Ct_art_Denoisy(i,p); % for Exp_4
            Y_Logan_art_Denoisy(i,p)= trapz(Time_art(1:p),Ct_art_Denoisy(i,1:p)) / Ct_art_Denoisy(i,p);
        end    
    end
end
% Two_Phase_Lin (for Logan plot)
Starting=[0,0,0,0];
LB=[0,-100000,0,-100000];
UB=[100000,100000,100000,100000];
for i=1:1:Num_real
    X_temp=X_Logan_art_Denoisy(i,:);
    Y_temp=Y_Logan_art_Denoisy(i,:);
    [Estimates,SSE,Residual,d,e,f,Jacobian]=lsqcurvefit(@Two_phase_Lin, Starting, X_temp, Y_temp, LB, UB,options);
    Params_Logan_TPL_art_Denoisy(i,:)=Estimates;
end












%% Optimization
% Object #1 test!!
options = optimoptions('lsqcurvefit','Display', 'off');
global Local_Estimates
Local_Estimates=[17.86;0.00841;-3423.59;1.23;3348.58;1.13929;17.67;0.06774];
PI_Time=[0:1:120];

Num_real=10;
scale_factor=10;

%k_True=[0.6,0.2,0.1,0.001];
%k_True=[0.03,0.13,0.05,0.001]; %2

k_True=[0.09,0.25,0.22,0.001]; %1
%k_True=[0.03,0.13,0.05,0.001]; %2
%k_True=[0.13,0.63,0.19,0]; %3
%k_True=[0.97,1,0.07,0]; %  %4
%k_True=[0.82,1,0.19,0]; %  %5
%k_True=[0.01,0.36,0.03,0]; %6
%k_True=[0.41,0.51,0.01,0]; %7
%k_True=[0.88,1,0.04,0]; %  %8
%k_True=[0.36,1,0.08,0]; %  %9
%k_True=[0.70,1,0.18,0]; %  %10
%k_True=[0.03,0.32,0.05,0]; %11
%k_True=[0.15,0.71,0.05,0]; %12
%k_True=[0.86,0.98,0.01,0]; %13
%k_True=[0.11,0.74,0.02,0]; %14

k1_True=k_True(1);
k2_True=k_True(2);
k3_True=k_True(3);
k4_True=k_True(4);

global Ct_Noisy;
Ct_True=TTCM_analytic_Multi(k_True,PI_Time); % with Exp_4
Ct_True=repmat(Ct_True,Num_real,1);
Ct_Noisy=Ct_True + (Ct_True.*scale_factor*0.01.*randn(Num_real,size(PI_Time,2))); % original noise model


% Denoising
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


global PI_Time_Noisy;
PI_Time_Noisy=[10:3:120];
Ct_Denoisy=Ct_Denoisy(:,PI_Time_Noisy);
%options = optimoptions('fmincon','StepTolerance',1e-10,'MaxIterations',50);
for i=1:1:Num_real
    tic;
    Ct_Noisy=Ct_Denoisy(i,:);
    [params,obj_val] = fmincon(@Object_1,k_True,[],[],[],[],[0;0;0;0.001],[1.001;1.001;0.5001;0.001],[]);
    Para_comb{i,1}=params;
    toc;
end
chosen_params=cell2mat(Para_comb);

for i=1:1:Num_real
    k1_PCDE{i,1}=chosen_params(i,1); % for k1
    k2_PCDE{i,1}=chosen_params(i,2); % for k2
    k3_PCDE{i,1}=chosen_params(i,3); % for k3
    k4_PCDE{i,1}=chosen_params(i,4); % for k4
    Ki_PCDE{i,1}=(chosen_params(i,1)*chosen_params(i,3)) / (chosen_params(i,2)+chosen_params(i,3)); % for Ki
    Vd_PCDE{i,1}=(chosen_params(i,1)*chosen_params(i,2)) / ((chosen_params(i,2)+chosen_params(i,3))^2); % for Vd
end

% Bias [%]
% for Ki
NBias_Ki_PCDE=abs(mean(cell2mat(Ki_PCDE),'all')-Ki_True)/Ki_True*100;
% for Vd
NBias_Vd_PCDE=abs(mean(cell2mat(Vd_PCDE),'all')-Vd_True)/Vd_True*100;
% for k1
NBias_k1_PCDE=abs(mean(cell2mat(k1_PCDE),'all')-k1_True)/k1_True*100;
% for k2
NBias_k2_PCDE=abs(mean(cell2mat(k2_PCDE),'all')-k2_True)/k2_True*100;
% for k3
NBias_k3_PCDE=abs(mean(cell2mat(k3_PCDE),'all')-k3_True)/k3_True*100;
% SD
Mean_Pred_Ki_PCDE=mean(cell2mat(Ki_PCDE),'all');
Mean_Pred_Vd_PCDE=mean(cell2mat(Vd_PCDE),'all');
Mean_Pred_k1_PCDE=mean(cell2mat(k1_PCDE),'all');
Mean_Pred_k2_PCDE=mean(cell2mat(k2_PCDE),'all');
Mean_Pred_k3_PCDE=mean(cell2mat(k3_PCDE),'all');
% for Ki
NSD_Ki_PCDE=std(cell2mat(Ki_PCDE),1,'all')/Mean_Pred_Ki_PCDE*100;
% for Vd
NSD_Vd_PCDE=std(cell2mat(Vd_PCDE),1,'all')/Mean_Pred_Vd_PCDE*100;
% for k1
NSD_k1_PCDE=std(cell2mat(k1_PCDE),1,'all')/Mean_Pred_k1_PCDE*100;
% for k2
NSD_k2_PCDE=std(cell2mat(k2_PCDE),1,'all')/Mean_Pred_k2_PCDE*100;
% for k3
NSD_k3_PCDE=std(cell2mat(k3_PCDE),1,'all')/Mean_Pred_k3_PCDE*100;
% MSE (MSE=Bias^2+Variance=Bias^2+SD^2)
% for Ki
MSE_Ki_PCDE=mean((cell2mat(Ki_PCDE)-repmat(Ki_True,Num_real,1)).^(2),'all');
% for Vd
MSE_Vd_PCDE=mean((cell2mat(Vd_PCDE)-repmat(Vd_True,Num_real,1)).^(2),'all');
% for k1
MSE_k1_PCDE=mean((cell2mat(k1_PCDE)-repmat(k1_True,Num_real,1)).^(2),'all');
% for k2
MSE_k2_PCDE=mean((cell2mat(k2_PCDE)-repmat(k2_True,Num_real,1)).^(2),'all');
% for k3
MSE_k3_PCDE=mean((cell2mat(k3_PCDE)-repmat(k3_True,Num_real,1)).^(2),'all');




%% Ito curve
options = optimoptions('lsqcurvefit','Display', 'off');
global Local_Estimates
Local_Estimates=[17.86;0.00841;-3423.59;1.23;3348.58;1.13929;17.67;0.06774];
PI_Time=[0:1:120];

Num_real=10;
scale_factor=10;

%k_True=[0.6,0.2,0.1,0.001];
%k_True=[0.03,0.13,0.05,0.001]; %2

k_True=[0.09,0.25,0.22,0.001]; %1
%k_True=[0.03,0.13,0.05,0.001]; %2
%k_True=[0.13,0.63,0.19,0]; %3
%k_True=[0.97,1,0.07,0]; %  %4
%k_True=[0.82,1,0.19,0]; %  %5
%k_True=[0.01,0.36,0.03,0]; %6
%k_True=[0.41,0.51,0.01,0]; %7
%k_True=[0.88,1,0.04,0]; %  %8
%k_True=[0.36,1,0.08,0]; %  %9
%k_True=[0.70,1,0.18,0]; %  %10
%k_True=[0.03,0.32,0.05,0]; %11
%k_True=[0.15,0.71,0.05,0]; %12
%k_True=[0.86,0.98,0.01,0]; %13
%k_True=[0.11,0.74,0.02,0]; %14




