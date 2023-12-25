function [sort_val_Ct,sort_ind_Ct]=Rank_Ct(Ct_DB,Fitted_Noisy,PI_Time_fine)
% Ranking based on difference of Ct values

Fitted_Noisy_repmat=repmat(Fitted_Noisy,size(Ct_DB,1),1);

[sort_val_Ct, sort_ind_Ct]=sort(sum(abs(Ct_DB-Fitted_Noisy_repmat),2));









end


