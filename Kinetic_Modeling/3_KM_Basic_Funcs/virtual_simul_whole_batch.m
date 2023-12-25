function[Excels_N1, Excels_N2]=virtual_simul_whole_batch(noise_levels,num_batch,num_realization,org_ind)
% noise levels ==> two noise levels [%]

Num_real=num_realization; % the # of realizations per batch

% Indexing for each organ (i.e., org_ind)
% 3: Brain, 4: Thyroid, 5: Myocardium, 8: Spleen, 9: Pancreas, 10: Kidney, 13: Liver

for b=1:1:num_batch
[RMSE_Info,k_True,Ki_True,Vd_True,Excel,Bias_Excel,SD_Excel,NBias_Excel,NSD_Excel,MSE_Excel,NBias_micro_2TCM,NBias_micro_PCDE,NBias_macro_2TCM,NBias_macro_PCDE,NBias_macro_Patlak,NSD_micro_2TCM,NSD_micro_PCDE,NSD_macro_2TCM,NSD_macro_PCDE,NSD_macro_Patlak,MSE_micro_2TCM,MSE_micro_PCDE,MSE_macro_2TCM,MSE_macro_PCDE,MSE_macro_Patlak]=virtual_simul(noise_levels(1),Num_real, org_ind);
    if b==1
        Excels_N1=Excel;
    else
        Excels_N1=cat(2,Excels_N1,Excel);
    end
end

clear Excel;

for b=1:1:num_batch
[RMSE_Info,k_True,Ki_True,Vd_True,Excel,Bias_Excel,SD_Excel,NBias_Excel,NSD_Excel,MSE_Excel,NBias_micro_2TCM,NBias_micro_PCDE,NBias_macro_2TCM,NBias_macro_PCDE,NBias_macro_Patlak,NSD_micro_2TCM,NSD_micro_PCDE,NSD_macro_2TCM,NSD_macro_PCDE,NSD_macro_Patlak,MSE_micro_2TCM,MSE_micro_PCDE,MSE_macro_2TCM,MSE_macro_PCDE,MSE_macro_Patlak]=virtual_simul(noise_levels(2),Num_real, org_ind);
    if b==1
        Excels_N2=Excel;
    else
        Excels_N2=cat(2,Excels_N2,Excel);
    end
end






end