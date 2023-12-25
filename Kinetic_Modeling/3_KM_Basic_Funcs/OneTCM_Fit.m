function [Ct]=OneTCM_Fit(params,x)

global Local_Estimates;

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


a_TCM=((k1_p.*A1)./(k2_p-B1));
b_TCM=((k1_p.*A2)./(k2_p-B2));
c_TCM=((k1_p.*A3)./(k2_p-B3));
d_TCM=((k1_p.*A4)./(k2_p-B4));


Ct=(a_TCM.*(exp(-B1.*x)-exp(-k2_p.*x))) + (b_TCM.*(exp(-B2.*x)-exp(-k2_p.*x))) + (c_TCM.*(exp(-B3.*x)-exp(-k2_p.*x))) + (d_TCM.*(exp(-B4.*x)-exp(-k2_p.*x))); 


end