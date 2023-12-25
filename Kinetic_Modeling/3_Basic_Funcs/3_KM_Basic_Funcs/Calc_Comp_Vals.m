function [Comp_vals]=Calc_Comp_Vals(params)

options = optimoptions('lsqcurvefit','Display', 'off');
global Local_Estimates

% Calc. of Ki, Vd, A1,B1,A2
PI_Time=[1:1:120];
k1=params(1);k2=params(2);k3=params(3);k4=params(4);

Ki= (k1*k3) / (k2+k3);
Vd= (k1*k2) / ((k2+k3)^2);

Ct_True=TTCM_analytic_Multi(params,PI_Time);

Func_TTCM=@(tau) TTCM_analytic_Multi(params,tau);
Ct_True=TTCM_analytic_Multi(params,PI_Time); % with Exp_4
Func_Exp_4=@(tau) Exp_4(Local_Estimates,tau); % for Exp_4
Cp=Exp_4(Local_Estimates,PI_Time); % for Exp_4

% Logan
for p=1:1:size(PI_Time,2)
    X_Logan(p)=integral(Func_Exp_4, 0, PI_Time(p), 'ArrayValued',true) / Ct_True(p); % for Exp_4
    Y_Logan(p)=integral(Func_TTCM,0,PI_Time(p),'ArrayValued', true) / Ct_True(p);
end

% Two_Phase_Lin (for Logan plot)
Starting=[0,0,0,0];
LB=[0,-100000,0,-100000];
UB=[100000,100000,100000,100000];
[Estimates,SSE,Residual,d,e,f,Jacobian]=lsqcurvefit(@Two_phase_Lin, Starting, X_Logan, Y_Logan, LB, UB,options);
%Fitted=[transpose([0:0.1:10]), transpose(Two_phase_Lin(Estimates,[0:0.1:10]))];


Comp_vals=[Ki,Vd,Estimates(1),Estimates(2),Estimates(3)];

end