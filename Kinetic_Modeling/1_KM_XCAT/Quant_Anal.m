%% Qauntitative Analysis

function [NBias,NSD,NMSE,NSD_spa,SNR_ROI,SNR_BKG,TBR,CNR,TBR_RD,TC_RD]=Quant_Anal(ROI_Result,ROI,BKG_ROI,Num_Iter,Model_ind,Param_ind,Reals_Ind_Batch)


%% Quantitative Analysis (i.e., NBias, NSD, NMSE, NSD_spatial, TBR Constrast, CNR)
% Loading 
ROI_Names=["BrainGM", "BrainWM", "Thyroid", "Myocardium", "Spleen", "Pancreas", "Kidney", "Liver", "Lung", "Muscle", "Bone", "LungTumor", "LiverTumor", "BrainTumor"];
Field_names=["PGA_Ki", "PGA_Vd", "TTCM_K1", "TTCM_k2", "TTCM_k3", "PCDE_K1", "PCDE_k2", "PCDE_k3", "PCDE_Ki", "PCDE_Vd"];

% Loading Ground Truth
load True_params.mat
True_param=True_params(ROI,Param_ind);

% The # of Noise Realized Data to be used
R=size(ROI_Result,2);

% Loading BKG Results
filename= string([char(ROI_Names(BKG_ROI)),'_Iter_', num2str(Num_Iter),'.mat']);
BKG=load(filename);
BKG_Result=BKG.ROI_Result.(Field_names(Model_ind));
BKG_Result=BKG_Result(:,Reals_Ind_Batch);

% NBias [%]
NBias_i=(abs(mean(ROI_Result,2)-True_param))./ True_param;
NBias_i(isnan(NBias_i))=[];
NBias=mean(NBias_i)*100;
NBias_SD=std(NBias_i)/mean(NBias_i)*100;
% NSD [%]
NSD_i= ((sum((ROI_Result-mean(ROI_Result,2)).^(2),2) ./ (R-1)).^(0.5))./mean(ROI_Result,2) ;
NSD_i(isnan(NSD_i))=[];
NSD=mean(NSD_i)*100;
NSD_SD=std(NSD_i)/mean(NSD_i)*100;
% NMSE [%]
NMSE_i=((sum((ROI_Result-True_param).^(2),2)./R).^(0.5)) ./ True_param;
NMSE_i(isnan(NMSE_i))=[];
NMSE=mean(NMSE_i)*100;
NMSE_SD=std(NMSE_i)/mean(NMSE_i)*100;
% NSD_spatial [%]
%Num_vox=size(ROI_Result,1);
%NSD_spa= ((sum((mean(ROI_Result,2)-mean(mean(ROI_Result,2))).^(2))/(Num_vox-1))^(0.5)) / mean(mean(ROI_Result,2)) *100;
SD_r=std(ROI_Result,0,1);
Mean_r=mean(ROI_Result,1);
NSD_spa=mean(SD_r ./ Mean_r.*100,'omitnan');

% SNR_ROI
mean_ROI=mean(ROI_Result,1);
SD_ROI=std(ROI_Result,0,1);
SNR_ROI=mean(mean_ROI./SD_ROI,'omitnan');
% SNR_BKG
mean_BKG=mean(BKG_Result,1);
SD_BKG=std(BKG_Result,0,1);
SNR_BKG=mean(mean_BKG./SD_BKG,'omitnan');
% TBR (Tumor-to-Background Ratio) (but, if BKG > Tumor ==> then, its inverse!)
%if mean(mean_ROI) >= mean(mean_BKG) 
%    temp=mean_ROI./mean_BKG;
%    temp(isinf(temp))=[];
%    TBR=mean(temp,'omitnan');
%else
%    temp=mean_BKG./mean_ROI;
%    temp(isinf(temp))=[];
%    TBR=mean(temp,'omitnan');
%end
temp=mean_ROI./mean_BKG;
temp(isinf(temp))=[]; % to remove inf
TBR=mean(temp,'omitnan');

% TBR_RD [%]
TBR_true=True_params(ROI,Param_ind)/True_params(BKG_ROI,Param_ind);
TBR_RD=abs((mean_ROI./mean_BKG)-TBR_true)./TBR_true.*100;
TBR_RD(isinf(TBR_RD))=[]; % to remove inf
TBR_RD=mean(TBR_RD,'omitnan');


% CNR (Contrast Noise Ratio)
CNR= mean(abs((mean_ROI-mean_BKG)./SD_BKG),'omitnan');

% Tumor Contrast_RD [%]
TC_m=abs((mean_ROI-mean_BKG));
TC_true= abs(True_params(ROI,Param_ind)-True_params(BKG_ROI,Param_ind));
TC_RD= abs(TC_m-TC_true)./TC_true.*100;
TC_RD(isinf(TC_RD))=[]; % to remove inf
TC_RD=mean(TC_RD,'omitnan');

end