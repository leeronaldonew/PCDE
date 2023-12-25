function [ind_min]=Acc_Similarity_Measure2(permutes, sort_ind, Noisy, PI_Time, PI_Time_fine)


%tic;
Ct_DB=TTCM_analytic_Multi(permutes(sort_ind(1:300),:),PI_Time_fine); % using TTCM_analytic

options = optimoptions('lsqcurvefit','Display', 'off');
%% Exp_fit for Noisy data
%tic;
if Noisy(1,1) > Noisy(1,end) % Neg. Slope
    Starting=[-1*max(Noisy(1,:)),0,0];
    lb=[-10000,-10000,-10000];
    ub=[10000,10000,10000];
else % Pos. Slope
    Starting=[0,0, max(Noisy(1,:))];
    lb=[-10000,-10000,-10000];
    ub=[10000,10000,10000];
end
%toc;
%tic;
[Estimates,SSE,Residual,d,e,f,Jacobian]=lsqcurvefit(@Exp_New, Starting, PI_Time,Noisy,lb,ub,options); % for C-A*exp(-B*t)
Fitted_Noisy=Exp_New(Estimates,PI_Time_fine); % for C-A*exp(-B*t)
tic;
[sort_val_AUC,sort_ind_AUC]=Rank_AUC(Ct_DB,Fitted_Noisy,PI_Time_fine);
toc;
Ct_DB=TTCM_analytic_Multi(permutes(sort_ind(sort_ind_AUC(1:10)),:),PI_Time_fine); % using TTCM_analytic
%toc;

% Ranking the Physical Features
%tic;
[sort_val_Overlap,sort_ind_Overlap]=Rank_AUC_Overlapped(Ct_DB,Fitted_Noisy,PI_Time_fine);
[sort_val_Ct,sort_ind_Ct]=Rank_Ct(Ct_DB,Fitted_Noisy,PI_Time_fine);
[sort_val_Acc,sort_ind_Acc,sort_val_Slope,sort_ind_Slope]=Rank_Slope_Acc(Ct_DB,Fitted_Noisy,PI_Time_fine);
[sort_val_Con_Ct,sort_ind_Con_Ct,sort_val_Con_Slope,sort_ind_Con_Slope]=Rank_Connect(Ct_DB,Fitted_Noisy,PI_Time_fine);
%toc;
% Ranking the Statistical Feature
%tic;
[sort_val_MI,sort_ind_MI]=Rank_MI(Ct_DB,Fitted_Noisy,PI_Time);
sort_inds=[transpose([1:1:10]), sort_ind_Overlap, sort_ind_Ct, sort_ind_Slope, sort_ind_Acc, sort_ind_Con_Ct, sort_ind_Con_Slope, sort_ind_MI];
sort_vals=[sort_val_AUC(1:10), sort_val_Overlap, sort_val_Ct, sort_val_Slope, sort_val_Acc, sort_val_Con_Ct, sort_val_Con_Slope, sort_val_MI];
%toc;

% Calc. of Tot. Score & Ranking
%tic;
[sort_val_Score,sort_ind_Score]=Calc_ToT_Score(sort_vals,sort_inds,permutes, sort_ind(sort_ind_AUC(1:10)),1);
ind_min=sort_ind(sort_ind_AUC(sort_ind_Score(1)));
toc;
end