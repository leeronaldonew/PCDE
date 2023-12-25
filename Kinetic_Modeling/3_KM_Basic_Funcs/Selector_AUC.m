function [sort_val,sort_ind]=Selector_AUC(selected_comb,Noisy,PI_Time)

options = optimoptions('lsqcurvefit','Display', 'off');

global Local_Estimates
selected_Ct=TTCM_analytic_Multi(selected_comb,[10:0.1:90]);

% Exp_fit
%for i=1:1:size(selected_Ct,1)
   %Starting=[0,selected_Ct(i,1)];
   %lb=[-10000,-10000];
   %ub=[10000,10000];
   %[Estimates,SSE,Residual,d,e,f,Jacobian]=lsqcurvefit(@Inv_X_S, Starting, [10:0.1:90],selected_Ct(i,:),lb,ub,options); % for 1/x^2
   
   %Starting=[0,0, selected_Ct(i,1)];
   %lb=[-10000,-10000,-10000];
   %ub=[10000,10000,10000];
   %[Estimates,SSE,Residual,d,e,f,Jacobian]=lsqcurvefit(@Neg_Poly_2, Starting, [10:0.1:90],selected_Ct(i,:),lb,ub,options); % for 1/x^2
   
%   if selected_Ct(i,1) > selected_Ct(i,end) % Neg. Slope
%      Starting=[-1*max(selected_Ct(i,:)),0,0];
%      lb=[-10000,-10000,-10000];
%      ub=[10000,10000,10000];
%   else % Pos. Slope
%      Starting=[0,0, max(selected_Ct(i,:))];
%      lb=[-10000,-10000,-10000];
%      ub=[10000,10000,10000];
%   end
%   [Estimates,SSE,Residual,d,e,f,Jacobian]=lsqcurvefit(@Exp_New, Starting,[10:0.1:90],selected_Ct(i,:),lb,ub,options); 

%   if i==1
%        %Estimates_update=Estimates_Lin_Exp; % for Exp
%        Estimates_update=Estimates; 
%   else
%        %Estimates_update=cat(1,Estimates_update, Estimates_Lin_Exp); % for Exp
%        Estimates_update=cat(1,Estimates_update, Estimates);
%   end
%end

% Fitted data
%Fitted_Cts=Lin_Exp(Estimates_update,[10:0.1:90]); % for Exp
%Fitted_Cts=Inv_X_S(Estimates_update,[10:0.1:90]); % for 1/x^2
%Fitted_Cts=Neg_Poly_2(Estimates_update,[10:0.1:90]); 
%Fitted_Cts=Exp_New(Estimates_update,[10:0.1:90]); % for C-A*exp(-B*t)

% Calc. AUC (using Fitting)
%for i=1:1:size(Fitted_Cts,1)
%   % Integ_Fitted_Cts(i,:)=cumtrapz([10:0.1:90],Fitted_Cts(i,:),2); % using C-A*exp(-B*t) Fit model
%    Integ_Fitted_Cts(i,:)=cumtrapz([10:0.1:90],selected_Ct(i,:),2); % just using true data points
%end
%AUC_Fitted_Cts=Integ_Fitted_Cts(:,end);

% Calc. AUC (using just true data points)
for i=1:1:size(selected_Ct,1)
    Integ_Fitted_Cts(i,:)=cumtrapz([10:0.1:90],selected_Ct(i,:),2); % just using true data points
end
AUC_Fitted_Cts=Integ_Fitted_Cts(:,end);


% Exp_fit for Noisy data
if Noisy(1,1) > Noisy(1,end) % Neg. Slope
   Starting=[-1*max(Noisy(1,:)),0,0];
   lb=[-10000,-10000,-10000];
   ub=[10000,10000,10000];
else % Pos. Slope
   Starting=[0,0, max(Noisy(1,:))];
   lb=[-10000,-10000,-10000];
   ub=[10000,10000,10000];
end
%Starting=[0,Noisy(1,1)];
%lb=[-10000,-10000];
%ub=[10000,10000];
%[Estimates,SSE,Residual,d,e,f,Jacobian]=lsqcurvefit(@Inv_X_S, Starting, PI_Time,Noisy,lb,ub,options); % for 1/x^2
%Fitted_Cts_Noisy=Inv_X_S(Estimates,[10:0.1:90]); % for 1/x^2

[Estimates,SSE,Residual,d,e,f,Jacobian]=lsqcurvefit(@Exp_New, Starting, PI_Time,Noisy,lb,ub,options); % for C-A*exp(-B*t)
Fitted_Cts_Noisy=Exp_New(Estimates,[10:0.1:90]); % for C-A*exp(-B*t)

% Calc. AUC for Noisy data
Integ_Fitted_Cts_Noisy=cumtrapz([10:0.1:90],Fitted_Cts_Noisy,2);
AUC_Noisy=Integ_Fitted_Cts_Noisy(:,end);
AUC_Noisy=repmat(AUC_Noisy,size(selected_comb,1),1);



[sort_val,sort_ind]=sort(sum(abs(AUC_Fitted_Cts-AUC_Noisy),2));







end