function [sort_val_Con_Ct,sort_ind_Con_Ct,sort_val_Con_Slope,sort_ind_Con_Slope]=Rank_Connect(Ct_DB,Fitted_Noisy,PI_Time_fine)
% Calc. & Ranking the connectivity at 10 min PI Time

Slope_Ct=diff(Ct_DB,1,2) ./ 0.1; % First derivative
Slope_Noisy=diff(Fitted_Noisy,1,2) ./ 0.1; % First derivative

% Calc. of Connectivity (Slope)
Slope_Noisy_repmat=repmat(Slope_Noisy(1,1),size(Slope_Ct,1),1);
[sort_val_Con_Slope,sort_ind_Con_Slope]=sort(abs(Slope_Ct(:,1)-Slope_Noisy_repmat));

% Calc. of Connectivity (Ct)
Fitted_Noisy_repmat=repmat(Fitted_Noisy(1), size(Ct_DB,1),1);
[sort_val_Con_Ct,sort_ind_Con_Ct]=sort(abs(Ct_DB(:,1)-Fitted_Noisy_repmat));

end