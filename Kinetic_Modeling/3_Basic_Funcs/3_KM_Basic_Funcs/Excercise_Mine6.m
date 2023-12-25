%% Excercise_Mine_6

%% Filtering out using Ki (from Patlak)
options = optimoptions('lsqcurvefit','Display', 'off');
global Local_Estimates
%Local_Estimates=[17.86;0.00841;-3423.59;1.23;3348.58;1.13929;17.67;0.06774];
Local_Estimates=[0.735;851.1;21.88;20.81;4.134;0.1191;0.01043]; % using Feng. eq.
PI_Time=[10:5:90];

Num_real=10;
scale_factor=10;

%k_True=[0.09,0.25,0.22,0]; %1
%k_True=[0.03,0.13,0.05,0]; %2
%k_True=[0.13,0.63,0.19,0]; %3
k_True=[0.97,1,0.07,0]; %  %4
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

%k_True=[0.6,1.2,0.1,0.001]; % Myocardium

k1=k_True(1);
k2=k_True(2);
k3=k_True(3);
k4=k_True(4);
Ki_True= (k1*k3) / (k2+k3);
Vd_True= (k1*k2) /((k2+k3)^2);

%Ct_True=TTCM_analytic_Multi(k_True,PI_Time); % with Exp_4
%Ct_True=transpose(TTCM_vector(k_True,transpose(PI_Time)));
Ct_True=TTCM_Conv(k_True,PI_Time);
Ct_True=repmat(Ct_True,Num_real,1);

Ct_Noisy=Ct_True + (Ct_True.*scale_factor*0.01.*randn(Num_real,size(PI_Time,2)));


% Denosing by FLT
%nl=10; % Legendre Polynomial's max order
%kmax=3; % cut-off order for denoising
%Num_p=size(PI_Time,2); % # of data points
%for i=1:1:Num_real
%    y_py=py.numpy.array(transpose(Ct_Noisy(i,:)));
%    FLT_results_py= py.LegendrePolynomials.LT(y_py,py.numpy.array(nl));	% FLT 
%    FLT_results=double(FLT_results_py);
%    FLT_results_truncated=FLT_results(1,1:kmax);
%    FLT_results_truncated_py=py.numpy.array(FLT_results_truncated);
%    iFLT_results_py=py.LegendrePolynomials.iLT(FLT_results_truncated_py,py.numpy.array(Num_p)); % iFLT
%    iFLT_results=transpose(double(iFLT_results_py));
%    if i==1
%        Ct_Denoisy=transpose(iFLT_results);
%    else
%        Ct_Denoisy=cat(1, Ct_Denoisy,transpose(iFLT_results));
%    end
%end
%Ct_Denoisy(Ct_Denoisy < 0)=0; % to remove negative values



% Patlak Plot
%Func_Exp_4=@(tau) Exp_4(Local_Estimates,tau); % for Exp_4
%Cp=Exp_4(Local_Estimates,PI_Time); % for Exp_4
Func_Exp_4=@(t) Feng(Local_Estimates,t); % for Feng's eq.
Cp=transpose(Feng(Local_Estimates,PI_Time)); % for Feng's eq.

for i=1:1:Num_real
    for p=1:1:size(PI_Time,2)
        X_Patlak(i,p)=integral(Func_Exp_4, 0, PI_Time(p), 'ArrayValued',true)/Cp(p); % for Exp_4
        Y_Patlak(i,p)=Ct_Noisy(i,p)/Cp(p);
    end
end
%plot(X_Patlak,Y_Patlak);
for i=1:1:Num_real
    p_Patlak=polyfit(X_Patlak(i,:), Y_Patlak(i,:),1);
    params_Patlak(i,:)=p_Patlak;
end

% Generating database
tic;
[permutes,true_database]=make_database_NH_FDG_Full_Non_analytic(PI_Time);
toc;

for i=1:1:Num_real
    tic;
    Y_data_repmat=repmat(Ct_Noisy(i,:), size(permutes,1),1);
    [sort_val,sort_ind]=sort( sum(abs(true_database-Y_data_repmat) , 2) ); % 
    temp_comp=permutes(sort_ind(1:300),:);

    temp_Ki_DB=temp_comp(:,1).*temp_comp(:,3)./(temp_comp(:,2)+temp_comp(:,3));
    temp_Ki_Noisy=repmat(params_Patlak(i,1),300,1);

    %temp_Vd_DB=temp_comp(:,1).*temp_comp(:,2)./(temp_comp(:,2)+temp_comp(:,3)).^(2);
    %temp_Vd_Noisy=repmat(params_Patlak(i,2),300,1);
    %[min_val,min_ind]=min(  (abs(temp_Ki_Noisy-temp_Ki_DB).^(2)) + (abs(temp_Vd_Noisy-temp_Vd_DB).^(2))  );

    [min_val,min_ind]=min(  (abs(temp_Ki_Noisy-temp_Ki_DB).^(2)) );
    optim_params(i,:)=permutes(sort_ind(min_ind),:);

    toc;
end

[mean(optim_params(:,1)), mean(optim_params(:,2)), mean(optim_params(:,3))]



%% Testing for Faster LSE







