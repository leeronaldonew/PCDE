function [sort_val_Q,sort_ind_Q]=Comp_L_Space(FLT_database_Q,FLT_noisy_Q)

temp=repmat(FLT_noisy_Q, size(FLT_database_Q,1),1);

[sort_val_Q,sort_ind_Q]=sort(sum(abs(FLT_database_Q-temp),2));
%sort_ind_Q=sort_ind_Q(1:10);
%sort_val_Q=sort_val_Q(1:10);


end