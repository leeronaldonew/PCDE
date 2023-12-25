function [Quant]=Quant_Anal_main(ROI_Result_temp,ROI,BKG_ROI,Num_Iter,Reals_Ind_Batch)

%% Quantitative Analysis
% ROI
% 1: Brain_GM, 2: Brain_WM, 3: Thyroid, 4: Myocardium, 5: Spleen
% 6: Pancreas, 7: Kidney, 8: Liver, 9: Lung
% 12: Lung Tumor, 13: Liver Tumor, 14: Brain Tumor
% BKG_ROI
% for Normal Organs ==> each ROI (e.g., 8: Liver), for Tumors ==> 2: Brain_WM, 9:Lung, 8: Liver
% Model_ind
% 1: PGA_Ki, 2: PGA_Vd, 3:TTCM_K1, 4: TTCM_k2, 5: TTCM_k3, 
% 6: PCDE_K1, 7: PCDE_k2, 8: PCDE_k3, 9: PCDE_Ki, 10: PCDE_Vd
% Param_ind
% 1: K1, 2: k2, 3: k3, 4: k4, 5: Ki, 6: Vd

% PGA
[NBias,NSD,NMSE,NSD_spa,SNR_ROI,SNR_BKG,TBR,CNR,TBR_RD,TC_RD]=Quant_Anal(ROI_Result_temp.PGA_Ki,ROI,BKG_ROI,Num_Iter,1,5,Reals_Ind_Batch);
Quant(1,:)=[NBias,NSD,NMSE,NSD_spa,SNR_ROI,SNR_BKG,TBR,CNR,TBR_RD,TC_RD]; % Ki
[NBias,NSD,NMSE,NSD_spa,SNR_ROI,SNR_BKG,TBR,CNR,TBR_RD]=Quant_Anal(ROI_Result_temp.PGA_Vd,ROI,BKG_ROI,Num_Iter,2,6,Reals_Ind_Batch);
Quant(2,:)=[NBias,NSD,NMSE,NSD_spa,SNR_ROI,SNR_BKG,TBR,CNR,TBR_RD,TC_RD]; % Vd
% 2TCM
[NBias,NSD,NMSE,NSD_spa,SNR_ROI,SNR_BKG,TBR,CNR,TBR_RD,TC_RD]=Quant_Anal(ROI_Result_temp.TTCM_K1,ROI,BKG_ROI,Num_Iter,3,1,Reals_Ind_Batch);
Quant(3,:)=[NBias,NSD,NMSE,NSD_spa,SNR_ROI,SNR_BKG,TBR,CNR,TBR_RD,TC_RD]; % K1
[NBias,NSD,NMSE,NSD_spa,SNR_ROI,SNR_BKG,TBR,CNR,TBR_RD,TC_RD]=Quant_Anal(ROI_Result_temp.TTCM_k2,ROI,BKG_ROI,Num_Iter,4,2,Reals_Ind_Batch);
Quant(4,:)=[NBias,NSD,NMSE,NSD_spa,SNR_ROI,SNR_BKG,TBR,CNR,TBR_RD,TC_RD]; % k2
[NBias,NSD,NMSE,NSD_spa,SNR_ROI,SNR_BKG,TBR,CNR,TBR_RD,TC_RD]=Quant_Anal(ROI_Result_temp.TTCM_k3,ROI,BKG_ROI,Num_Iter,5,3,Reals_Ind_Batch);
Quant(5,:)=[NBias,NSD,NMSE,NSD_spa,SNR_ROI,SNR_BKG,TBR,CNR,TBR_RD,TC_RD]; % k3
% PCDE
[NBias,NSD,NMSE,NSD_spa,SNR_ROI,SNR_BKG,TBR,CNR,TBR_RD,TC_RD]=Quant_Anal(ROI_Result_temp.PCDE_K1,ROI,BKG_ROI,Num_Iter,6,1,Reals_Ind_Batch);
Quant(6,:)=[NBias,NSD,NMSE,NSD_spa,SNR_ROI,SNR_BKG,TBR,CNR,TBR_RD,TC_RD]; % K1
[NBias,NSD,NMSE,NSD_spa,SNR_ROI,SNR_BKG,TBR,CNR,TBR_RD,TC_RD]=Quant_Anal(ROI_Result_temp.PCDE_k2,ROI,BKG_ROI,Num_Iter,7,2,Reals_Ind_Batch);
Quant(7,:)=[NBias,NSD,NMSE,NSD_spa,SNR_ROI,SNR_BKG,TBR,CNR,TBR_RD,TC_RD]; % k2
[NBias,NSD,NMSE,NSD_spa,SNR_ROI,SNR_BKG,TBR,CNR,TBR_RD,TC_RD]=Quant_Anal(ROI_Result_temp.PCDE_k3,ROI,BKG_ROI,Num_Iter,8,3,Reals_Ind_Batch);
Quant(8,:)=[NBias,NSD,NMSE,NSD_spa,SNR_ROI,SNR_BKG,TBR,CNR,TBR_RD,TC_RD]; % k3
[NBias,NSD,NMSE,NSD_spa,SNR_ROI,SNR_BKG,TBR,CNR,TBR_RD,TC_RD]=Quant_Anal(ROI_Result_temp.PCDE_Ki,ROI,BKG_ROI,Num_Iter,9,5,Reals_Ind_Batch);
Quant(9,:)=[NBias,NSD,NMSE,NSD_spa,SNR_ROI,SNR_BKG,TBR,CNR,TBR_RD,TC_RD]; % Ki
[NBias,NSD,NMSE,NSD_spa,SNR_ROI,SNR_BKG,TBR,CNR,TBR_RD,TC_RD]=Quant_Anal(ROI_Result_temp.PCDE_Vd,ROI,BKG_ROI,Num_Iter,10,6,Reals_Ind_Batch);
Quant(10,:)=[NBias,NSD,NMSE,NSD_spa,SNR_ROI,SNR_BKG,TBR,CNR,TBR_RD,TC_RD]; % Vd

end