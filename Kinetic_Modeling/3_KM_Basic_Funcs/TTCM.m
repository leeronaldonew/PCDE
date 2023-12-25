function C_tot=TTCM(params, x) 
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
Func_Exp_First=@(tau,t_temp) A*exp(-alpha*(-tau+t_temp));
Func_Exp_Second=@(tau,t_temp) B*exp(-beta*(-tau+t_temp));

% For Testing the algorithm
%Func_Feng=@(tau) Feng([0 0 1 0 0 -1 -1], tau); % for testing
%Func_Feng=@(tau) exp(-tau); % for testing
%Func_Exp_First=@(tau) 1;
%Func_Multiplied_First=@(tau) Func_Feng(tau) .* Func_Exp_First(tau);
%C_tot_temp_First=integral(@(tau) Func_Multiplied_First(tau), 0, 1, 'ArrayValued',true);
%Integ_value=integral(@(tau) Func_Feng(tau), 0, 1, 'ArrayValued',true);

% Defining 2 Tissue Comp. Model
for i=1:1:size(t,1)
    clear t_temp; % for initialization
    clear Func_Multiplied_First Func_Multiplied_Second; % for initialization
    clear C_tot_temp_First C_tot_temp_Second; % for initialization
    t_temp=t(i,1);
    Func_Multiplied_First=@(tau,t_temp) Func_Feng(tau).* Func_Exp_First(tau,t_temp);
    Func_Multiplied_Second=@(tau,t_temp) Func_Feng(tau).* Func_Exp_Second(tau,t_temp);
    C_tot_temp_First=integral(@(tau) Func_Multiplied_First(tau, t_temp), 0, t_temp, 'ArrayValued',true);
    C_tot_temp_Second=integral(@(tau) Func_Multiplied_Second(tau, t_temp), 0, t_temp, 'ArrayValued',true);
    C_tot_temp(i,1)=C_tot_temp_First-C_tot_temp_Second;
end

C_tot=C_tot_temp;
