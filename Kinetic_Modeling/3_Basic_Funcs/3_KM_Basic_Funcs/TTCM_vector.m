function C_tot=TTCM_vector(params, x) 
% Two Tissue Compartments Model (TTCM) for Kinetic Modeling (Non-linearized!!)

% Parameters for 2 Tissue Comp. Model (X linearized)

global Local_Estimates;

% All of params, Xdata and C_tot: Column type! (i.e., Vector!) 
% for testing
%K_1=0.9;
%K_2=0.5;
%K_3=0.7;
%K_4=0.8;
K_1=params(1);
K_2=params(2);
K_3=params(3);
K_4=params(4);
alpha=( (K_2+K_3+K_4) + (( ((K_2+K_3+K_4)^(2))-(4*K_2*K_4) )^(0.5)) ) / 2 ;
beta=( (K_2+K_3+K_4) - (( ((K_2+K_3+K_4)^(2))-(4*K_2*K_4) )^(0.5)) ) / 2 ;
A=(K_1/(alpha-beta))*(alpha-K_3-K_4); 
B=(K_1/(alpha-beta))*(beta-K_3-K_4);

% Defining x
 t=x; % t: PI Times [min] (getting from the Mutiple WB scanning data)

% Defining functions to be used for Convolution Process
Func_Feng=@(tau) Feng(Local_Estimates,tau);
%Func_Exp_4=@(tau) Exp_4(Local_Estimates,tau);

Func_Exp_First=@(tau,t) A.*exp(-alpha.*(-tau+t));
Func_inside_first=@(tau,t) Func_Feng(tau) * Func_Exp_First(tau,t);
%Func_inside_first=@(tau,t) Func_Exp_4(tau) * Func_Exp_First(tau,t);

Func_Exp_Second=@(tau,t) B*exp(-beta*(-tau+t));
Func_inside_second=@(tau,t) Func_Feng(tau) * Func_Exp_Second(tau,t);
%Func_inside_second=@(tau,t) Func_Exp_4(tau) * Func_Exp_Second(tau,t);

for i=1:1:size(t,1)
    Integ_first(i,1)=integral(@(tau) Func_inside_first(tau, t(i,1)), 0, t(i,1), 'ArrayValued',true);
    Integ_second(i,1)=integral(@(tau) Func_inside_second(tau, t(i,1)), 0, t(i,1), 'ArrayValued',true);
end

C_tot=Integ_first - Integ_second;