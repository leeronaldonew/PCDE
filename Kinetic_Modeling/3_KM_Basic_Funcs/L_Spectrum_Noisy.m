function [FLT_results_Cts,FLT_results_Slope,FLT_results_Acc]=L_Spectrum_Noisy(Ct_Noisy,PI_Time)

options = optimoptions('lsqcurvefit','Display', 'off');

% Exp_fit
%Starting=[0,Ct_Noisy(1,1)];
%lb=[0,-10000];
%ub=[10000,10000];
%[Estimates,SSE,Residual,d,e,f,Jacobian]=lsqcurvefit(@Inv_X_S, Starting, PI_Time,Ct_Noisy,lb,ub,options); % for 1/x^2

if Ct_Noisy(1,1) > Ct_Noisy(1,end) % Neg. Slope
   Starting=[-1*max(Ct_Noisy(1,:)),0,0];
   lb=[-10000,-10000,-10000];
   ub=[10000,10000,10000];
else % Pos. Slope
   Starting=[0,0, max(Ct_Noisy(1,:))];
   lb=[-10000,-10000,-10000];
   ub=[10000,10000,10000];
end
[Estimates,SSE,Residual,d,e,f,Jacobian]=lsqcurvefit(@Exp_New, Starting, PI_Time,Ct_Noisy,lb,ub,options); % for C-A*exp(-B*t)

% Fitted data
%Fitted_Cts=Inv_X_S(Estimates,[10:0.1:90]); % for 1/x^2
Fitted_Cts=Exp_New(Estimates,[10:0.1:90]); % for C-A*exp(-B*t)

% Calc. AUC
Integ_Fitted_Cts=cumtrapz([10:0.1:90],Fitted_Cts,2);
AUC_Fitted_Cts=Integ_Fitted_Cts(end);

% Normalized Fitted_Cts
N_Fitted_Cts= Fitted_Cts./AUC_Fitted_Cts;


% Exp_fit for Normalized Cts
%Starting=[0, N_Fitted_Cts(1,1)];
%lb=[0,-10000];
%ub=[10000,10000];
%[Estimates,SSE,Residual,d,e,f,Jacobian]=lsqcurvefit(@Inv_X_S, Starting, [10:0.1:90],N_Fitted_Cts,lb,ub,options); % for 1/x^2

if N_Fitted_Cts(1,1) > N_Fitted_Cts(1,end) % Neg. Slope
   Starting=[-1*max(N_Fitted_Cts(1,:)),0,0];
   lb=[-10000,-10000,-10000];
   ub=[10000,10000,10000];
else % Pos. Slope
   Starting=[0,0, max(N_Fitted_Cts(1,:))];
   lb=[-10000,-10000,-10000];
   ub=[10000,10000,10000];
end
[Estimates,SSE,Residual,d,e,f,Jacobian]=lsqcurvefit(@Exp_New, Starting, [10:0.1:90],N_Fitted_Cts,lb,ub,options); % for C-A*exp(-B*t)


% Calc. Slope & Acc
%N_Slope=abs(-2.*Estimates(:,1).*([10:0.1:90].^(-3))); % Converting original slope (negative) into Positive Slope!!
%N_Acc=6.*Estimates(:,1).*([10:0.1:90].^(-4));
N_Slope=abs(Estimates(:,1).*Estimates(:,2).*exp(-1.*Estimates(:,2)*[10:0.1:90]));
N_Acc=abs(-1.*Estimates(:,1).*((Estimates(:,2)).^(2)).*exp(-1.*Estimates(:,2)*[10:0.1:90]));


% Getting of L-Spectrum
nl=10; % Legendre Polynomial's max order

y_py=py.numpy.array(transpose(N_Fitted_Cts));
FLT_results_py= py.LegendrePolynomials.LT(y_py,py.numpy.array(nl));	% FLT 
FLT_results_Cts=double(FLT_results_py);

y_py=py.numpy.array(transpose(N_Slope));
FLT_results_py= py.LegendrePolynomials.LT(y_py,py.numpy.array(nl));	% FLT 
FLT_results_Slope=double(FLT_results_py);

y_py=py.numpy.array(transpose(N_Acc));
FLT_results_py= py.LegendrePolynomials.LT(y_py,py.numpy.array(nl));	% FLT 
FLT_results_Acc=double(FLT_results_py);








end