function [C1]=TTCM_C1(params,x)

global Local_Estimates;

A1=Local_Estimates(1);
A2=Local_Estimates(3);
A3=Local_Estimates(5);
A4=Local_Estimates(7);
B1=Local_Estimates(2);
B2=Local_Estimates(4);
B3=Local_Estimates(6);
B4=Local_Estimates(8);

k1_p=params(:,1);
k2_p=params(:,2);
k3_p=params(:,3);
k4_p=params(:,4);

alpha_TTCM= ( (k2_p+k3_p+k4_p) + (((k2_p+k3_p+k4_p).^2)-(4.*k2_p.*k4_p)).^(0.5) ) ./ 2 ;
beta_TTCM=  ( (k2_p+k3_p+k4_p) - (((k2_p+k3_p+k4_p).^2)-(4.*k2_p.*k4_p)).^(0.5) ) ./ 2 ;

a_TTCM=A1./(k2_p+k3_p-B1);
b_TTCM=A2./(k2_p+k3_p-B2);
c_TTCM=A3./(k2_p+k3_p-B3);
d_TTCM=A4./(k2_p+k3_p-B4);


C1=k1_p.*( (a_TTCM.*exp(-B1.*x)+b_TTCM.*exp(-B2.*x)+c_TTCM.*exp(-B3.*x)+d_TTCM.*exp(-B4.*x)) - (exp(-(k2_p+k3_p).*x).*(a_TTCM+b_TTCM+c_TTCM+d_TTCM))    );



end