function [FLT_result_update_Cts,FLT_result_update_Slope,FLT_result_update_Acc]=L_Spectrum_Database(prom_permutes,PI_Time)

options = optimoptions('lsqcurvefit','Display', 'off');

global Local_Estimates
%Local_Estimates=[17.86;0.00841;-3423.59;1.23;3348.58;1.13929;17.67;0.06774];

Cts=TTCM_analytic_Multi(prom_permutes, PI_Time);


% Exp_fit
for i=1:1:size(Cts,1)
   %Starting_Lin_Exp=[Cts(i,1),0.25];
   %lb_Exp=[0,0];
   %ub_Exp=[1.5*Cts(i,1),0.5];
   %[Estimates_Lin_Exp,SSE,Residual,d,e,f,Jacobian]=lsqcurvefit(@Lin_Exp, Starting_Lin_Exp, PI_Time,Cts(i,:),lb_Exp,ub_Exp); % for Exp
   
   %Starting=[0,Cts(i,1)];
   %lb=[0,-10000];
   %ub=[10000,10000];
   %[Estimates,SSE,Residual,d,e,f,Jacobian]=lsqcurvefit(@Inv_X_S, Starting, PI_Time,Cts(i,:),lb,ub,options); % for 1/x^2

   if Cts(i,1) > Cts(i,end) % Neg. Slope
      Starting=[-1*max(Cts(i,:)),0,0];
      lb=[-10000,-10000,-10000];
      ub=[10000,10000,10000];
   else % Pos. Slope
      Starting=[0,0, max(Cts(i,:))];
      lb=[-10000,-10000,-10000];
      ub=[10000,10000,10000];
   end
   [Estimates,SSE,Residual,d,e,f,Jacobian]=lsqcurvefit(@Exp_New, Starting, PI_Time,Cts(i,:),lb,ub,options); % for 1/x^2
   
   if i==1
        %Estimates_update=Estimates_Lin_Exp; % for Exp
        Estimates_update=Estimates;
   else
        %Estimates_update=cat(1,Estimates_update, Estimates_Lin_Exp); % for Exp
        Estimates_update=cat(1,Estimates_update, Estimates);
   end
end

% Fitted data
%Fitted_Cts=Lin_Exp(Estimates_update,[10:0.1:90]); % for Exp
%Fitted_Cts=Inv_X_S(Estimates_update,[10:0.1:90]); % for 1/x^2
Fitted_Cts=Exp_New(Estimates_update,[10:0.1:90]); % for C-A*exp(-B*t)

% Calc. AUC
for i=1:1:size(Fitted_Cts,1)
    Integ_Fitted_Cts(i,:)=cumtrapz([10:0.1:90],Fitted_Cts(i,:),2);
end
AUC_Fitted_Cts=Integ_Fitted_Cts(:,end);

% Normalized Fitted_Cts
for i=1:1:size(Fitted_Cts,1)
    N_Fitted_Cts(i,:)= Fitted_Cts(i,:)./AUC_Fitted_Cts(i,1);
end


% Exp_fit for Normalized Cts
for i=1:1:size(N_Fitted_Cts,1)
   %Starting_Lin_Exp=[Cts(i,1),0.25];
   %lb_Exp=[0,0];
   %ub_Exp=[1.5*Cts(i,1),0.5];
   %[Estimates_Lin_Exp,SSE,Residual,d,e,f,Jacobian]=lsqcurvefit(@Lin_Exp, Starting_Lin_Exp, PI_Time,Cts(i,:),lb_Exp,ub_Exp); % for Exp
  
   %Starting=[0, N_Fitted_Cts(i,1)];
   %lb=[0,-10000];
   %ub=[10000,10000];
   %[Estimates,SSE,Residual,d,e,f,Jacobian]=lsqcurvefit(@Inv_X_S, Starting, [10:0.1:90],N_Fitted_Cts(i,:),lb,ub,options); % for 1/x^2

   if N_Fitted_Cts(i,1) > N_Fitted_Cts(i,end) % Neg. Slope
      Starting=[-1*max(N_Fitted_Cts(i,:)),0,0];
      lb=[-10000,-10000,-10000];
      ub=[10000,10000,10000];
   else % Pos. Slope
      Starting=[0,0, max(N_Fitted_Cts(i,:))];
      lb=[-10000,-10000,-10000];
      ub=[10000,10000,10000];
   end
   [Estimates,SSE,Residual,d,e,f,Jacobian]=lsqcurvefit(@Exp_New, Starting, [10:0.1:90],N_Fitted_Cts(i,:),lb,ub,options); % for C-A*exp(-B*t)

   if i==1
        %Estimates_update=Estimates_Lin_Exp; % for Exp
        Estimates_update=Estimates; 
   else
        %Estimates_update=cat(1,Estimates_update, Estimates_Lin_Exp); % for Exp
        Estimates_update=cat(1,Estimates_update, Estimates); 
   end
end

% Calc. Slope & Acc
%N_Slope=abs(-2.*Estimates_update(:,1).*([10:0.1:90].^(-3))); % Converting original slope (negative) into Positive Slope!!
%N_Acc=6.*Estimates_update(:,1).*([10:0.1:90].^(-4));
N_Slope=abs(Estimates_update(:,1).*Estimates_update(:,2).*exp(-1.*Estimates_update(:,2)*[10:0.1:90]));
N_Acc=abs(-1.*Estimates_update(:,1).*((Estimates_update(:,2)).^(2)).*exp(-1.*Estimates_update(:,2)*[10:0.1:90]));

% Getting of L-Spectrum
nl=10; % Legendre Polynomial's max order
for i=1:1:size(N_Fitted_Cts,1) % for N_Fitted_Cts
    y_py=py.numpy.array(transpose(N_Fitted_Cts(i,:)));
    FLT_results_py= py.LegendrePolynomials.LT(y_py,py.numpy.array(nl));	% FLT 
    FLT_results=double(FLT_results_py);
    if i==1
        FLT_result_update_Cts=FLT_results;
    else
        FLT_result_update_Cts=cat(1, FLT_result_update_Cts,FLT_results);
    end
end
for i=1:1:size(N_Slope,1) % for N_Slope
    y_py=py.numpy.array(transpose(N_Slope(i,:)));
    FLT_results_py= py.LegendrePolynomials.LT(y_py,py.numpy.array(nl));	% FLT 
    FLT_results=double(FLT_results_py);
    if i==1
        FLT_result_update_Slope=FLT_results;
    else
        FLT_result_update_Slope=cat(1, FLT_result_update_Slope,FLT_results);
    end
end
for i=1:1:size(N_Acc,1) % for N_Acc
    y_py=py.numpy.array(transpose(N_Acc(i,:)));
    FLT_results_py= py.LegendrePolynomials.LT(y_py,py.numpy.array(nl));	% FLT 
    FLT_results=double(FLT_results_py);
    if i==1
        FLT_result_update_Acc=FLT_results;
    else
        FLT_result_update_Acc=cat(1, FLT_result_update_Acc,FLT_results);
    end
end








end