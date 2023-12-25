function C_tot=Patlak_vector(params, x) 
% Patlak Analysis for Kinetic Modeling (Linearized model!!)

global Local_Estimates;
global Feng_values;
global C_p_integral;

% All of params, Xdata and C_tot: Column type! (i.e., Vector!) 
% for testing
%K_i=0.8;
%V_d=0.05;
K_i=params(1);
V_d=params(2);

% Defining x
 t=x; % t: PI Times [min] (getting from the Mutiple WB scanning data)

% Defining functions to be used for the next step
%Func_Feng=@(tau) Feng(Local_Estimates,tau);
%Feng_value=Feng(Local_Estimates, t);
%for i=1:1:size(t,1)
%    C_p_integral(i,1)=integral(Func_Feng, 0, t(i,1), 'ArrayValued',true);
%end

% Defining Patlak Analysis
%C_tot_over_C_p=(C_p_integral./Feng_values)*K_i + V_d;
C_tot=(K_i*C_p_integral) + V_d*Feng_values;


