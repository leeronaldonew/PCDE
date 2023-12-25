function Ct=Patlak_NL_New(params, t) 
% Patlak with Non-linear form

% Loading necessary data
load("Local_Estimates.mat");

Ki=params(2);
Vd=params(1);

Func_Exp_4=@(tau) Exp_4(Local_Estimates,tau);
Cp=Exp_4(Local_Estimates,t);

Ct=zeros(size(t,1),size(t,2));


for i=1:1:size(t,1)
    Ct(i,1)=Ki*(integral(Func_Exp_4, 0, t(i), 'ArrayValued',true)) + Vd*Cp(i);
end

