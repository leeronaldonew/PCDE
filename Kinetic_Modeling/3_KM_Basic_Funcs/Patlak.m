function C_tot=Patlak(params, x) 
% Patlak Analysis for Kinetic Modeling (Linearized model!!)

global Local_Estimates;

% All of params, Xdata and C_tot: Column type! (i.e., Vector!) 
% for testing
%K_i=0.8;
%V_d=0.05;
K_i=params(1);
V_d=params(2);

% Defining x
 t=x; % t: PI Times [min] (getting from the Mutiple WB scanning data)

% Defining functions to be used for the next step
Func_Feng=@(tau) Feng(Local_Estimates,tau);

% Defining Patlak Analysis
for i=1:1:size(t,1)
    clear t_temp; % for initialization
    clear C_p_integral; % for initialization
    t_temp=t(i,1);
    C_p_integral=integral(Func_Feng, 0, t_temp, 'ArrayValued',true);
    C_tot(i,1)=(K_i*C_p_integral) + V_d*Feng(Local_Estimates,t_temp);
end

