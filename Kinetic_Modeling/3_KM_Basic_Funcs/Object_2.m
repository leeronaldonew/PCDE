function [obj_val]=Object_1(params)

options = optimoptions('lsqcurvefit','Display', 'off');
global Local_Estimates
global PI_Time
global Integ_Cp
global Ct_Noisy

k1=params(1);
k2=params(2);
k3=params(3);
k4=params(4);


IRF= (k1.*k3./(k2+k3)) + (k1.*k2./(k2+k3)).*exp(-1.*(k2+k3).*PI_Time);

obj_val=sum((Ct_Noisy-(IRF.*Integ_Cp)).^(2));






end



