function [ind_min]=Similarity_Measure(permutes, sort_ind, Ct_Noisy, PI_Time)

[sort_val_AUC,sort_ind_AUC]=Selector_AUC(permutes(sort_ind(1:300),:),Ct_Noisy,PI_Time);
   
%[sort_ind_Slope]=Selector_Overall_Slope( permutes(sort_ind(sort_ind_AUC(1:10)),:),Ct_Noisy(i,:),PI_Time );
%ind_min=sort_ind(sort_ind_AUC(sort_ind_Slope(1)));
   
% Getting L-Spectrum
[FLT_database_Cts,FLT_database_Slope,FLT_database_Acc]=L_Spectrum_Database(permutes(sort_ind(sort_ind_AUC(1:10)),:),PI_Time);
[FLT_noisy_Cts,FLT_noisy_Slope,FLT_noisy_Acc]=L_Spectrum_Noisy(Ct_Noisy,PI_Time);
    
% Comparison in L-Space
[sort_val_Cts,sort_ind_Cts]=Comp_L_Space(FLT_database_Cts,FLT_noisy_Cts);
[sort_val_Slope,sort_ind_Slope]=Comp_L_Space(FLT_database_Slope,FLT_noisy_Slope);
[sort_val_Acc,sort_ind_Acc]=Comp_L_Space(FLT_database_Acc,FLT_noisy_Acc);

% Scoring (perfect score: 1 = (1/40)*(10+10+10+10))// AUC & Ct & Slope & Acc
[sort_val_Score, sort_ind_Score]= ToT_Score(permutes,sort_ind,sort_ind_AUC, sort_ind_Cts, sort_ind_Slope, sort_ind_Acc);

ind_min=sort_ind(sort_ind_AUC(sort_ind_Score(1)));
