function C_tot=TTCM_analytic(params, x) 

%load("Local_Estimates");

global Local_Estimates;

%syms k1_p k2_p k3_p k4_p alpha_TTCM beta_TTCM A1 A2 A3 A4 B1 B2 B3 B4 x C_tot_TTCM
A1=Local_Estimates(1);
A2=Local_Estimates(3);
A3=Local_Estimates(5);
A4=Local_Estimates(7);
B1=Local_Estimates(2);
B2=Local_Estimates(4);
B3=Local_Estimates(6);
B4=Local_Estimates(8);

k1_p=params(1);
k2_p=params(2);
k3_p=params(3);
k4_p=params(4);

alpha_TTCM=  ( (k2_p+k3_p+k4_p) + (((k2_p+k3_p+k4_p)^2)-(4*k2_p*k4_p))^(0.5) ) / 2;
beta_TTCM=   ( (k2_p+k3_p+k4_p) - (((k2_p+k3_p+k4_p)^2)-(4*k2_p*k4_p))^(0.5) ) / 2;

%C_tot_TTCM= matlabFunction( ( ((k1_p*(alpha_TTCM-k4_p)-k1_p*k3_p)/(alpha_TTCM-beta_TTCM)) * (((A1/(alpha_TTCM-B1))*(exp(-1*B1*x)-exp(-1*alpha_TTCM*x))) + ((A2/(alpha_TTCM-B2))*(exp(-1*B2*x)-exp(-1*alpha_TTCM*x))) + ((A3/(alpha_TTCM-B3))*(exp(-1*B3*x)-exp(-1*alpha_TTCM*x))) + ((A4/(alpha_TTCM-B4))*(exp(-1*B4*x)-exp(-1*alpha_TTCM*x)))) ) + ( ((k1_p*k3_p-(k1_p*(beta_TTCM-k4_p)))/(alpha_TTCM-beta_TTCM)) * (((A1/(beta_TTCM-B1))*(exp(-1*B1*x)-exp(-1*beta_TTCM*x))) + ((A2/(beta_TTCM-B2))*(exp(-1*B2*x)-exp(-1*beta_TTCM*x))) + ((A3/(beta_TTCM-B3))*(exp(-1*B3*x)-exp(-1*beta_TTCM*x))) + ((A4/(beta_TTCM-B4))*(exp(-1*B4*x)-exp(-1*beta_TTCM*x)))) ) );
%C_tot=C_tot_TTCM(t);

C_tot=( ((k1_p*(alpha_TTCM-k4_p)-k1_p*k3_p)/(alpha_TTCM-beta_TTCM)) * (((A1/(alpha_TTCM-B1))*(exp(-1*B1*x)-exp(-1*alpha_TTCM*x))) + ((A2/(alpha_TTCM-B2))*(exp(-1*B2*x)-exp(-1*alpha_TTCM*x))) + ((A3/(alpha_TTCM-B3))*(exp(-1*B3*x)-exp(-1*alpha_TTCM*x))) + ((A4/(alpha_TTCM-B4))*(exp(-1*B4*x)-exp(-1*alpha_TTCM*x)))) ) + ( ((k1_p*k3_p-(k1_p*(beta_TTCM-k4_p)))/(alpha_TTCM-beta_TTCM)) * (((A1/(beta_TTCM-B1))*(exp(-1*B1*x)-exp(-1*beta_TTCM*x))) + ((A2/(beta_TTCM-B2))*(exp(-1*B2*x)-exp(-1*beta_TTCM*x))) + ((A3/(beta_TTCM-B3))*(exp(-1*B3*x)-exp(-1*beta_TTCM*x))) + ((A4/(beta_TTCM-B4))*(exp(-1*B4*x)-exp(-1*beta_TTCM*x)))) );



end