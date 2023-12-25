function [N_Cts_AUC,N_Cts_MM,Fitted_Cts]=Norm_Cts(comb,Noisy,PI_Time,index)

options = optimoptions('lsqcurvefit','Display', 'off');

switch index
    case 1 % for DB
        global Local_Estimates
        Ct=TTCM_analytic_Multi(comb,[10:0.1:90]);    
        % Exp_fit
        for i=1:1:size(Ct,1)
            if Ct(i,1) > Ct(i,end) % Neg. Slope
               Starting=[-1*max(Ct(i,:)),0,0];
               lb=[-10000,-10000,-10000];
               ub=[10000,10000,10000];
            else % Pos. Slope
                Starting=[0,0, max(Ct(i,:))];
                lb=[-10000,-10000,-10000];
                ub=[10000,10000,10000];
            end
            [Estimates,SSE,Residual,d,e,f,Jacobian]=lsqcurvefit(@Exp_New, Starting,[10:0.1:90],Ct(i,:),lb,ub,options); 
            if i==1
                Estimates_update=Estimates; 
            else
                Estimates_update=cat(1,Estimates_update, Estimates);
            end
        end
        % Fitted Cts
        Fitted_Cts=Exp_New(Estimates_update,[10:0.1:90]); % for C-A*exp(-B*t)
    case 2 % for Noisy data
        %Ct=Noisy;
        %if Ct(1,1) > Ct(1,end) % Neg. Slope
        %    Starting=[-1*max(Ct(1,:)),0,0];
        %    lb=[-10000,-10000,-10000];
        %    ub=[10000,10000,10000];
        %else % Pos. Slope
        %    Starting=[0,0, max(Ct(1,:))];
        %    lb=[-10000,-10000,-10000];
        %    ub=[10000,10000,10000];
        %end
        %[Estimates,SSE,Residual,d,e,f,Jacobian]=lsqcurvefit(@Exp_New, Starting,PI_Time,Ct(1,:),lb,ub,options);
        %% Fitted Cts
        %Fitted_Cts=Exp_New(Estimates,[10:0.1:90]); % for C-A*exp(-B*t)
        Fitted_Cts=Noisy;
end

%% Norm. by AUC
% Calc. AUC 
for i=1:1:size(Fitted_Cts,1)
    AUC_Cts(i,1)=trapz([10:0.1:90],Fitted_Cts(i,:),2); % using fitted data
end
AUC_Cts_repmat=repmat(AUC_Cts,1,size(Fitted_Cts,2));
N_Cts_AUC=Fitted_Cts ./ AUC_Cts_repmat;

%% Norm by Min-Max value
rowmin = min(Fitted_Cts,[],2);
rowmax = max(Fitted_Cts,[],2);
N_Cts_MM = rescale(Fitted_Cts,'InputMin',rowmin,'InputMax',rowmax);


end