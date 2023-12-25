%% New_Study_with_TTCM_Conv
options = optimoptions('lsqcurvefit','Display', 'off');
global Local_Estimates
Local_Estimates=[0.735;851.1;21.88;20.81;4.134;0.1191;0.01043]; % using Feng. eq.
PI_Time=[10:5:90];
Num_real=10;
scale_factor=10;
k_True=[0.09,0.25,0.22,0.001]; %1
%k_True=[0.03,0.13,0.05,0.001]; %2
%k_True=[0.13,0.63,0.19,0.001]; %3
%k_True=[0.97,1,0.07,0.001]; %  %4
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

%k_True=[0.360,0.125,0.018,0.062];

k1=k_True(1);
k2=k_True(2);
k3=k_True(3);
k4=k_True(4);
Ki_True= (k1*k3) / (k2+k3);
Vd_True= (k1*k2) /((k2+k3)^2);
%Ko_True= (k2*k4) / (k2+k3);
Ct_True=TTCM_Conv(k_True,PI_Time);
Ct_True=repmat(Ct_True,Num_real,1);
Ct_Noisy=Ct_True + (Ct_True.*scale_factor*0.01.*randn(Num_real,size(PI_Time,2)));

% Patlak Plot
Func_Feng=@(t) Feng(Local_Estimates,t); % for Feng's eq.
Cp=transpose(Feng(Local_Estimates,PI_Time)); % for Feng's eq.
for i=1:1:Num_real
    for p=1:1:size(PI_Time,2)
        X_Patlak(i,p)=integral(Func_Feng, 0, PI_Time(p), 'ArrayValued',true)/Cp(p); % for Exp_4
        Y_Patlak(i,p)=Ct_Noisy(i,p)/Cp(p);
    end
end
%plot(X_Patlak,Y_Patlak);
for i=1:1:Num_real
    p_Patlak=polyfit(X_Patlak(i,:), Y_Patlak(i,:),1);
    params_Patlak(i,:)=p_Patlak;
end


% Generalized PATLAK
k_loss= (k2*k4)/(k2+k3);
Func_Feng_Multiplied = @(tau) Feng_Multiplied_Exp_Loss([Local_Estimates;k_loss], tau);
Cp=Feng(Local_Estimates,PI_Time); % for Exp_4

% Patlak
for i=1:1:Num_real
    for p=1:1:size(PI_Time,2)
        X_Gen_Patlak(i,p)= (exp(-1*k_loss*PI_Time(p))*integral(Func_Feng_Multiplied, 0, PI_Time(p), 'ArrayValued',true)) / Cp(p);% for Exp_4      
        Y_Gen_Patlak(i,p)=Ct_Noisy(i,p)/Cp(p);
    end
end
for i=1:1:Num_real
    p_Patlak=polyfit(X_Gen_Patlak(i,:), Y_Gen_Patlak(i,:),1);
    params_Gen_Patlak(i,:)=p_Patlak;
end

% Two_Phase_Lin (for Patlak plot)
%Starting=[0,0,0,0];
%LB=[0,-100000,0,-100000];
%UB=[100000,100000,100000,100000];
%for i=1:1:Num_real
%    [Estimates_Patlak,SSE,Residual,d,e,f,Jacobian]=lsqcurvefit(@Two_phase_Lin, Starting, X_Gen_Patlak(i,:), Y_Gen_Patlak(i,:), LB, UB,options);
%    %Fitted=[transpose(X_Patlak), transpose(Two_phase_Lin(Estimates_Patlak,X_Patlak))];
%    %Teq_in_Patlak_Plot(i)=(Estimates_Patlak(2)-Estimates_Patlak(4)) / (Estimates_Patlak(3)-Estimates_Patlak(1));
%    %Teq=PI_Time(max(find(X_Patlak <= Teq_in_Patlak_Plot)));
%    params_TPL_Gen_Patlak(i,:)=Estimates_Patlak;
%end

% Ito
Func_TTCM=@(tau) TTCM_Conv(k_True,tau);
Func_Feng=@(t) Feng(Local_Estimates,t);
PI_Time_Art=[10:5:90];

Ct_Art=TTCM_Conv(k_True,PI_Time_Art);
Ct_Art=repmat(Ct_Art,Num_real,1);

% Integ_Cp
for p=1:1:size(PI_Time_Art,2)
    if [0:0.01:PI_Time_Art(p)] == 0
        Integ_Cp(p)=0;
    else
        Cp_val_temp=transpose(Feng(Local_Estimates,[0:0.01:PI_Time_Art(p)]));
        Integ_Cp(p)=trapz([0:0.01:PI_Time_Art(p)],Cp_val_temp);
    end
end
% Integ_Ct
for i=1:1:Num_real
    for p=1:1:size(PI_Time_Art,2)
        %if [0:0.01:PI_Time_Art(p)] == 0
        %    Integ_Ct(p)=0;
        %else
        %Ct_val_temp=TTCM_Conv(k_True,[0:0.01:PI_Time_Art(p)]);
        %Integ_Ct(p)=trapz([0:0.01:PI_Time_Art(p)],Ct_val_temp);
        if p==1
            Integ_Ct(i,p)=0;
        else
            Ct_val_temp=Ct_Art(i,1:p);
            Integ_Ct(i,p)=trapz(PI_Time_Art(1:p),Ct_val_temp);
        end  
        %end
    end
end
% Calc. of X & Y Ito
for i=1:1:Num_real
    for p=1:1:size(PI_Time_Art,2)
        if Integ_Ct(p)==0
            X_Ito(i,p)=0;
            Y_Ito(i,p)=0;
        else
            X_Ito(i,p)=Integ_Ct(i,p) / Integ_Cp(p) ; % for Exp_4
            Y_Ito(i,p)=Ct_Art(i,p) / Integ_Cp(p);
        end 
    end
end
X_Ito(:,1)=[]; % removing zero value
Y_Ito(:,1)=[];
plot_XY=[transpose(X_Ito(1,:)),transpose(Y_Ito(1,:))];


% Two_Phase_Lin (for Ito plot)
%options = optimoptions('lsqcurvefit','Algorithm', 'levenberg-marquardt', 'FunctionTolerance', 1e-8);
%Starting=[-1*k2,k1,-1*Ko_True,Ki_True];
Starting=[0,0,1,0];
LB=[0,0,0,0];
UB=[1,1,5,1];
for i=1:1:Num_real
    [Estimates_Ito,SSE,Residual,d,e,f,Jacobian]=lsqcurvefit(@Two_phase_Lin_Ito, Starting, X_Ito(i,:), Y_Ito(i,:), LB, UB,options);
    %Fitted=[transpose([0:0.1:2.5]), transpose(Two_phase_Lin(Estimates_Ito, [0:0.1:2.5]))];
    %Teq_in_Ito_Plot(i)=(Estimates_Ito(2)-Estimates_Ito(4)) / (Estimates_Ito(3)-Estimates_Ito(1));
    %Teq=PI_Time(max(find(X_Patlak <= Teq_in_Patlak_Plot)));
    params_TPL_Ito(i,:)=Estimates_Ito;
end
k1_Ito=params_TPL_Ito(:,2);
k2_Ito=params_TPL_Ito(:,1);
Ki_Ito=(params_TPL_Ito(:,3).*(params_TPL_Ito(:,4)-params_TPL_Ito(:,1)))+params_TPL_Ito(:,2);
k3_Ito=Ki_Ito.*k2_Ito./(k1_Ito-Ki_Ito);
k4_Ito=(k1_Ito.*k3_Ito./k2_Ito).*( 1./( (Ki_Ito./params_TPL_Ito(:,4))-(k1_Ito./k2_Ito) )  ) ; 
k_Ito=[k1_Ito,k2_Ito,k3_Ito,k4_Ito];


plot_XY_fitted=[transpose([0:0.1:5]), transpose(Two_phase_Lin_Ito(params_TPL_Ito(1,:),[0:0.1:5]))];


