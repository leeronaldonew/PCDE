function [Organ_NMSE_k1,Organ_NMSE_k2,Organ_NMSE_k3,Organ_NMSE_k4,Organ_NMSE_Ki,Organ_NMSE_Vd,Organ_NBias_k1,Organ_NBias_k2,Organ_NBias_k3,Organ_NBias_k4,Organ_NBias_Ki,Organ_NBias_Vd,Organ_NSD_k1,Organ_NSD_k2,Organ_NSD_k3,Organ_NSD_k4,Organ_NSD_Ki,Organ_NSD_Vd,Results,Results_Mean_SD,TTCM_WB,PCDE_WB,PCDE_FLT_WB,Patlak_WB,TTCM_SD_WB,PCDE_SD_WB,PCDE_FLT_SD_WB,Patlak_SD_WB,NMSE_k1,NMSE_k2,NMSE_k3,NMSE_k4,NMSE_Ki,NMSE_Vd,NBias_k1,NBias_k2,NBias_k3,NBias_k4,NBias_Ki,NBias_Vd,NSD_k1,NSD_k2,NSD_k3,NSD_k4,NSD_Ki,NSD_Vd,NMSE_micro,NMSE_macro,NBias_micro,NBias_macro,NSD_micro,NSD_macro]=virtual_simul_whole_batch_Multi_Organs(noise_level,num_batch,num_realization,PI_Time,PI_Time_fine)
% PI Time setting
%PI_Time=[10:5:40],PI_Time_fine=[10:0.1:40];

% noise levels ==> 10 [%]
Num_real=num_realization; % the # of realizations per batch

% Indexing for each organ (i.e., org_ind)
% 3: Brain, 4: Thyroid, 5: Myocardium, 8: Spleen, 9: Pancreas, 10: Kidney, 13: Liver
org_inds=[3,4,5,8,9,10,13];

for org_index=1:1:7
    for b=1:1:num_batch
        [RMSE_Info,k_True,Ki_True,Vd_True,Excel,Bias_Excel,SD_Excel,NBias_Excel,NSD_Excel,NMSE_Excel,NBias_micro_2TCM,NBias_micro_PCDE,NBias_macro_2TCM,NBias_macro_PCDE,NBias_macro_Patlak,NSD_micro_2TCM,NSD_micro_PCDE,NSD_macro_2TCM,NSD_macro_PCDE,NSD_macro_Patlak,MSE_micro_2TCM,MSE_micro_PCDE,MSE_macro_2TCM,MSE_macro_PCDE,MSE_macro_Patlak]=virtual_simul_Updated(noise_level,Num_real,org_inds(org_index),PI_Time,PI_Time_fine);
        if b==1
            Excels=Excel;
        else
            Excels=cat(2,Excels,Excel);
        end
    end
    Results{org_index,1}=Excels;
end

% Averaged over all batches
for org_index=1:1:7
    row_inds_NMSE=[1:4:4*num_batch];
    row_inds_NBias=[2:4:4*num_batch];
    row_inds_NSD=[3:4:4*num_batch];
    Mean_NMSE=mean(Results{org_index,1}(:,row_inds_NMSE),2);
    SD_NMSE=std(Results{org_index,1}(:,row_inds_NMSE),0,2);
    Mean_NBias=mean(Results{org_index,1}(:,row_inds_NBias),2);
    SD_NBias=std(Results{org_index,1}(:,row_inds_NBias),0,2);
    Mean_NSD=mean(Results{org_index,1}(:,row_inds_NSD),2);
    SD_NSD=std(Results{org_index,1}(:,row_inds_NSD),0,2);
    Mean_NMSE(isnan(Mean_NMSE))=0;
    Mean_NBias(isnan(Mean_NBias))=0;
    Mean_NSD(isnan(Mean_NSD))=0;
    Results_Mean{org_index,1}(:,1)=Mean_NMSE; 
    Results_Mean{org_index,1}(:,2)=Mean_NBias;
    Results_Mean{org_index,1}(:,3)=Mean_NSD;

    Results_Mean_SD{org_index,1}(:,1)=Mean_NMSE;
    Results_Mean_SD{org_index,1}(:,2)=SD_NMSE;
    Results_Mean_SD{org_index,1}(:,3)=Mean_NBias;
    Results_Mean_SD{org_index,1}(:,4)=SD_NBias;
    Results_Mean_SD{org_index,1}(:,5)=Mean_NSD;
    Results_Mean_SD{org_index,1}(:,6)=SD_NSD;
end


% Results for each organ
for org_index=1:1:7
    k1_ind=[1,7,13];
    k2_ind=[2,8,14];
    k3_ind=[3,9,15];
    k4_ind=[4,10,16];
    Ki_ind=[5,11,17,19];
    Vd_ind=[6,12,18,20];
    for ind=1:1:size(k1_ind,2)
        if ind ==1
            temp_update_NMSE=Results_Mean_SD{org_index,1}(k1_ind(ind),1:2);
            temp_update_NBias=Results_Mean_SD{org_index,1}(k1_ind(ind),3:4);
            temp_update_NSD=Results_Mean_SD{org_index,1}(k1_ind(ind),5:6);
        else
            temp_update_NMSE=cat(2, temp_update_NMSE,Results_Mean_SD{org_index,1}(k1_ind(ind),1:2));
            temp_update_NBias=cat(2, temp_update_NBias,Results_Mean_SD{org_index,1}(k1_ind(ind),3:4));
            temp_update_NSD=cat(2, temp_update_NSD,Results_Mean_SD{org_index,1}(k1_ind(ind),5:6));
        end
    end
    Organ_NMSE_k1{org_index,1}=temp_update_NMSE;
    Organ_NBias_k1{org_index,1}=temp_update_NBias;
    Organ_NSD_k1{org_index,1}=temp_update_NSD;
    clear temp_update_NMSE temp_update_NBias temp_update_NSD
    for ind=1:1:size(k2_ind,2)
        if ind ==1
            temp_update_NMSE=Results_Mean_SD{org_index,1}(k2_ind(ind),1:2);
            temp_update_NBias=Results_Mean_SD{org_index,1}(k2_ind(ind),3:4);
            temp_update_NSD=Results_Mean_SD{org_index,1}(k2_ind(ind),5:6);
        else
            temp_update_NMSE=cat(2, temp_update_NMSE,Results_Mean_SD{org_index,1}(k2_ind(ind),1:2));
            temp_update_NBias=cat(2, temp_update_NBias,Results_Mean_SD{org_index,1}(k2_ind(ind),3:4));
            temp_update_NSD=cat(2, temp_update_NSD,Results_Mean_SD{org_index,1}(k2_ind(ind),5:6));
        end
    end
    Organ_NMSE_k2{org_index,1}=temp_update_NMSE;
    Organ_NBias_k2{org_index,1}=temp_update_NBias;
    Organ_NSD_k2{org_index,1}=temp_update_NSD;
    clear temp_update_NMSE temp_update_NBias temp_update_NSD
    for ind=1:1:size(k3_ind,2)
        if ind ==1
            temp_update_NMSE=Results_Mean_SD{org_index,1}(k3_ind(ind),1:2);
            temp_update_NBias=Results_Mean_SD{org_index,1}(k3_ind(ind),3:4);
            temp_update_NSD=Results_Mean_SD{org_index,1}(k3_ind(ind),5:6);
        else
            temp_update_NMSE=cat(2, temp_update_NMSE,Results_Mean_SD{org_index,1}(k3_ind(ind),1:2));
            temp_update_NBias=cat(2, temp_update_NBias,Results_Mean_SD{org_index,1}(k3_ind(ind),3:4));
            temp_update_NSD=cat(2, temp_update_NSD,Results_Mean_SD{org_index,1}(k3_ind(ind),5:6));
        end
    end
    Organ_NMSE_k3{org_index,1}=temp_update_NMSE;
    Organ_NBias_k3{org_index,1}=temp_update_NBias;
    Organ_NSD_k3{org_index,1}=temp_update_NSD;
    clear temp_update_NMSE temp_update_NBias temp_update_NSD
    for ind=1:1:size(k4_ind,2)
        if ind ==1
            temp_update_NMSE=Results_Mean_SD{org_index,1}(k4_ind(ind),1:2);
            temp_update_NBias=Results_Mean_SD{org_index,1}(k4_ind(ind),3:4);
            temp_update_NSD=Results_Mean_SD{org_index,1}(k4_ind(ind),5:6);
        else
            temp_update_NMSE=cat(2, temp_update_NMSE,Results_Mean_SD{org_index,1}(k4_ind(ind),1:2));
            temp_update_NBias=cat(2, temp_update_NBias,Results_Mean_SD{org_index,1}(k4_ind(ind),3:4));
            temp_update_NSD=cat(2, temp_update_NSD,Results_Mean_SD{org_index,1}(k4_ind(ind),5:6));
        end
    end
    Organ_NMSE_k4{org_index,1}=temp_update_NMSE;
    Organ_NBias_k4{org_index,1}=temp_update_NBias;
    Organ_NSD_k4{org_index,1}=temp_update_NSD;
    clear temp_update_NMSE temp_update_NBias temp_update_NSD
    for ind=1:1:size(Ki_ind,2)
        if ind ==1
            temp_update_NMSE=Results_Mean_SD{org_index,1}(Ki_ind(ind),1:2);
            temp_update_NBias=Results_Mean_SD{org_index,1}(Ki_ind(ind),3:4);
            temp_update_NSD=Results_Mean_SD{org_index,1}(Ki_ind(ind),5:6);
        else
            temp_update_NMSE=cat(2, temp_update_NMSE,Results_Mean_SD{org_index,1}(Ki_ind(ind),1:2));
            temp_update_NBias=cat(2, temp_update_NBias,Results_Mean_SD{org_index,1}(Ki_ind(ind),3:4));
            temp_update_NSD=cat(2, temp_update_NSD,Results_Mean_SD{org_index,1}(Ki_ind(ind),5:6));
        end
    end
    Organ_NMSE_Ki{org_index,1}=temp_update_NMSE;
    Organ_NBias_Ki{org_index,1}=temp_update_NBias;
    Organ_NSD_Ki{org_index,1}=temp_update_NSD;
    clear temp_update_NMSE temp_update_NBias temp_update_NSD
    for ind=1:1:size(Vd_ind,2)
        if ind ==1
            temp_update_NMSE=Results_Mean_SD{org_index,1}(Vd_ind(ind),1:2);
            temp_update_NBias=Results_Mean_SD{org_index,1}(Vd_ind(ind),3:4);
            temp_update_NSD=Results_Mean_SD{org_index,1}(Vd_ind(ind),5:6);
        else
            temp_update_NMSE=cat(2, temp_update_NMSE,Results_Mean_SD{org_index,1}(Vd_ind(ind),1:2));
            temp_update_NBias=cat(2, temp_update_NBias,Results_Mean_SD{org_index,1}(Vd_ind(ind),3:4));
            temp_update_NSD=cat(2, temp_update_NSD,Results_Mean_SD{org_index,1}(Vd_ind(ind),5:6));
        end
    end
    Organ_NMSE_Vd{org_index,1}=temp_update_NMSE;
    Organ_NBias_Vd{org_index,1}=temp_update_NBias;
    Organ_NSD_Vd{org_index,1}=temp_update_NSD;
    clear temp_update_NMSE temp_update_NBias temp_update_NSD
end


% Averaged over all WB organs
Results_Mean_WB=(Results_Mean{1,1}+Results_Mean{2,1}+Results_Mean{3,1}+Results_Mean{4,1}+Results_Mean{5,1}+Results_Mean{6,1}+Results_Mean{7,1})./7;

for j=1:1:3
    for i=1:1:20
        Results_SD_WB(i,j)=std([Results_Mean{1,1}(i,j),Results_Mean{2,1}(i,j),Results_Mean{3,1}(i,j),Results_Mean{4,1}(i,j),Results_Mean{5,1}(i,j),Results_Mean{6,1}(i,j),Results_Mean{7,1}(i,j)]);
    end
end
% Mean & SD
TTCM_WB=Results_Mean_WB(1:6,:);
PCDE_WB=Results_Mean_WB(7:12,:);
PCDE_FLT_WB=Results_Mean_WB(13:18,:);
Patlak_WB=Results_Mean_WB(19:20,:);
TTCM_SD_WB=Results_SD_WB(1:6,:);
PCDE_SD_WB=Results_SD_WB(7:12,:);
PCDE_FLT_SD_WB=Results_SD_WB(13:18,:);
Patlak_SD_WB=Results_SD_WB(19:20,:);

% NMSE
NMSE_k1=[TTCM_WB(1,1),TTCM_SD_WB(1,1),PCDE_WB(1,1),PCDE_SD_WB(1,1),PCDE_FLT_WB(1,1),PCDE_FLT_SD_WB(1,1)]; % 2TCM v.s. PCDE v.s PCDE_FLT
NMSE_k2=[TTCM_WB(2,1),TTCM_SD_WB(2,1),PCDE_WB(2,1),PCDE_SD_WB(2,1),PCDE_FLT_WB(2,1),PCDE_FLT_SD_WB(2,1)];
NMSE_k3=[TTCM_WB(3,1),TTCM_SD_WB(3,1),PCDE_WB(3,1),PCDE_SD_WB(3,1),PCDE_FLT_WB(3,1),PCDE_FLT_SD_WB(3,1)];
NMSE_k4=[TTCM_WB(4,1),TTCM_SD_WB(4,1),PCDE_WB(4,1),PCDE_SD_WB(4,1),PCDE_FLT_WB(4,1),PCDE_FLT_SD_WB(4,1)];
NMSE_Ki=[TTCM_WB(5,1),TTCM_SD_WB(5,1),PCDE_WB(5,1),PCDE_SD_WB(5,1),PCDE_FLT_WB(5,1),PCDE_FLT_SD_WB(5,1),Patlak_WB(1,1),Patlak_SD_WB(1,1)]; % 2TCM v.s. PCDE v.s. PCDE_FLT v.s. Patlak
NMSE_Vd=[TTCM_WB(6,1),TTCM_SD_WB(6,1),PCDE_WB(6,1),PCDE_SD_WB(6,1),PCDE_FLT_WB(6,1),PCDE_FLT_SD_WB(6,1),Patlak_WB(2,1),Patlak_SD_WB(2,1)]; 
NMSE_micro=[mean(TTCM_WB(1:4,1)),std(TTCM_WB(1:4,1)),mean(PCDE_WB(1:4,1)),std(PCDE_WB(1:4,1)),mean(PCDE_FLT_WB(1:4,1)),std(PCDE_FLT_WB(1:4,1))];
NMSE_macro=[mean(TTCM_WB(5:6,1)),std(TTCM_WB(5:6,1)),mean(PCDE_WB(5:6,1)),std(PCDE_WB(5:6,1)),mean(PCDE_FLT_WB(5:6,1)),std(PCDE_FLT_WB(5:6,1)),mean(Patlak_WB(1:2,1)),std(Patlak_WB(1:2,1))];
% NBias
NBias_k1=[TTCM_WB(1,2),TTCM_SD_WB(1,2),PCDE_WB(1,2),PCDE_SD_WB(1,2),PCDE_FLT_WB(1,2),PCDE_FLT_SD_WB(1,2)]; % 2TCM v.s. PCDE v.s PCDE_FLT
NBias_k2=[TTCM_WB(2,2),TTCM_SD_WB(2,2),PCDE_WB(2,2),PCDE_SD_WB(2,2),PCDE_FLT_WB(2,2),PCDE_FLT_SD_WB(2,2)];
NBias_k3=[TTCM_WB(3,2),TTCM_SD_WB(3,2),PCDE_WB(3,2),PCDE_SD_WB(3,2),PCDE_FLT_WB(3,2),PCDE_FLT_SD_WB(3,2)];
NBias_k4=[TTCM_WB(4,2),TTCM_SD_WB(4,2),PCDE_WB(4,2),PCDE_SD_WB(4,2),PCDE_FLT_WB(4,2),PCDE_FLT_SD_WB(4,2)];
NBias_Ki=[TTCM_WB(5,2),TTCM_SD_WB(5,2),PCDE_WB(5,2),PCDE_SD_WB(5,2),PCDE_FLT_WB(5,2),PCDE_FLT_SD_WB(5,2),Patlak_WB(1,2),Patlak_SD_WB(1,2)]; % 2TCM v.s. PCDE v.s. PCDE_FLT v.s. Patlak
NBias_Vd=[TTCM_WB(6,2),TTCM_SD_WB(6,2),PCDE_WB(6,2),PCDE_SD_WB(6,2),PCDE_FLT_WB(6,2),PCDE_FLT_SD_WB(6,2),Patlak_WB(2,2),Patlak_SD_WB(2,2)];
NBias_micro=[mean(TTCM_WB(1:4,2)),std(TTCM_WB(1:4,2)),mean(PCDE_WB(1:4,2)),std(PCDE_WB(1:4,2)),mean(PCDE_FLT_WB(1:4,2)),std(PCDE_FLT_WB(1:4,2))];
NBias_macro=[mean(TTCM_WB(5:6,2)),std(TTCM_WB(5:6,2)),mean(PCDE_WB(5:6,2)),std(PCDE_WB(5:6,2)),mean(PCDE_FLT_WB(5:6,2)),std(PCDE_FLT_WB(5:6,2)),mean(Patlak_WB(1:2,2)),std(Patlak_WB(1:2,2))];
% NSD
NSD_k1=[TTCM_WB(1,3),TTCM_SD_WB(1,3),PCDE_WB(1,3),PCDE_SD_WB(1,3),PCDE_FLT_WB(1,3),PCDE_FLT_SD_WB(1,3)]; % 2TCM v.s. PCDE v.s PCDE_FLT
NSD_k2=[TTCM_WB(2,3),TTCM_SD_WB(2,3),PCDE_WB(2,3),PCDE_SD_WB(2,3),PCDE_FLT_WB(2,3),PCDE_FLT_SD_WB(2,3)];
NSD_k3=[TTCM_WB(3,3),TTCM_SD_WB(3,3),PCDE_WB(3,3),PCDE_SD_WB(3,3),PCDE_FLT_WB(3,3),PCDE_FLT_SD_WB(3,3)];
NSD_k4=[TTCM_WB(4,3),TTCM_SD_WB(4,3),PCDE_WB(4,3),PCDE_SD_WB(4,3),PCDE_FLT_WB(4,3),PCDE_FLT_SD_WB(4,3)];
NSD_Ki=[TTCM_WB(5,3),TTCM_SD_WB(5,3),PCDE_WB(5,3),PCDE_SD_WB(5,3),PCDE_FLT_WB(5,3),PCDE_FLT_SD_WB(5,3),Patlak_WB(1,3),Patlak_SD_WB(1,3)]; % 2TCM v.s. PCDE v.s. PCDE_FLT v.s. Patlak
NSD_Vd=[TTCM_WB(6,2),TTCM_SD_WB(6,3),PCDE_WB(6,3),PCDE_SD_WB(6,3),PCDE_FLT_WB(6,3),PCDE_FLT_SD_WB(6,3),Patlak_WB(2,3),Patlak_SD_WB(2,3)];
NSD_micro=[mean(TTCM_WB(1:4,3)),std(TTCM_WB(1:4,3)),mean(PCDE_WB(1:4,3)),std(PCDE_WB(1:4,3)),mean(PCDE_FLT_WB(1:4,3)),std(PCDE_FLT_WB(1:4,3))];
NSD_macro=[mean(TTCM_WB(5:6,3)),std(TTCM_WB(5:6,3)),mean(PCDE_WB(5:6,3)),std(PCDE_WB(5:6,3)),mean(PCDE_FLT_WB(5:6,3)),std(PCDE_FLT_WB(5:6,3)),mean(Patlak_WB(1:2,3)),std(Patlak_WB(1:2,3))];



save('Results_B_5_TimeDu_30_TimeGap_3_wo.mat', 'Organ_NMSE_k1','Organ_NMSE_k2','Organ_NMSE_k3','Organ_NMSE_k4','Organ_NMSE_Ki','Organ_NMSE_Vd','Organ_NBias_k1','Organ_NBias_k2','Organ_NBias_k3','Organ_NBias_k4','Organ_NBias_Ki','Organ_NBias_Vd','Organ_NSD_k1','Organ_NSD_k2','Organ_NSD_k3','Organ_NSD_k4','Organ_NSD_Ki','Organ_NSD_Vd','Results','Results_Mean_SD','TTCM_WB','PCDE_WB','PCDE_FLT_WB','Patlak_WB','TTCM_SD_WB','PCDE_SD_WB','PCDE_FLT_SD_WB','Patlak_SD_WB','NMSE_k1','NMSE_k2','NMSE_k3','NMSE_k4','NMSE_Ki','NMSE_Vd','NBias_k1','NBias_k2','NBias_k3','NBias_k4','NBias_Ki','NBias_Vd','NSD_k1','NSD_k2','NSD_k3','NSD_k4','NSD_Ki','NSD_Vd','NMSE_micro','NMSE_macro','NBias_micro','NBias_macro','NSD_micro','NSD_macro');

%save('Results_B_D_WB.mat','Results','TTCM_WB','PCDE_WB','PCDE_FLT_WB','Patlak_WB','TTCM_SD_WB','PCDE_SD_WB','PCDE_FLT_SD_WB','Patlak_SD_WB','NMSE_k1','NMSE_k2','NMSE_k3','NMSE_k4','NMSE_Ki','NMSE_Vd','NBias_k1','NBias_k2','NBias_k3','NBias_k4','NBias_Ki','NBias_Vd','NSD_k1','NSD_k2','NSD_k3','NSD_k4','NSD_Ki','NSD_Vd','NMSE_micro','NMSE_macro','NBias_micro','NBias_macro','NSD_micro','NSD_macro');

end