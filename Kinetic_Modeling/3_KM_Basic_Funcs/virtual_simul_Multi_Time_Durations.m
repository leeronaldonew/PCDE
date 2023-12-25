function []=virtual_simul_Multi_Time_Durations(noise_level,num_batch,num_realization)

% Common Setting
%noise_level=10;
%num_batch=5;
%num_realization=1000;

Num_TimeDu=6; % the # of time durations
%Times{1,1}=[10:5:40]; % 30 [min]
%Times_fine{1,1}=[10:0.1:40];
%Times{2,1}=[10:5:70]; % 60 [min]
%Times_fine{2,1}=[10:0.1:70];
%Times{3,1}=[10:5:100]; % 90 [min]
%Times_fine{3,1}=[10:0.1:100];

%Times{1,1}=[10:5:55]; % 45 [min]
%Times_fine{1,1}=[10:0.1:55];
%Times{2,1}=[10:5:85]; % 75 [min]
%Times_fine{2,1}=[10:0.1:85];



%Times{1,1}=[0.5:5:30.5]; % 30 [min]
%Times_fine{1,1}=[0.5:0.1:30.5];
%Times{2,1}=[0.5:5:60.5]; % 60 [min]
%Times_fine{2,1}=[0.5:0.1:60.5];
%Times{3,1}=[0.5:5:90.5]; % 90 [min]
%Times_fine{3,1}=[0.5:0.1:90.5];

% Dual Scanning (20+10=30 min)
%Times{1,1}=[10:5:30,40:5:50]; % 40-50 [min]
%Times_fine{1,1}=[10:0.1:30,40:0.1:50];
%Times{2,1}=[10:5:30,60:5:70]; % 60-70 [min]
%Times_fine{2,1}=[10:0.1:30,60:0.1:70];
%Times{3,1}=[10:5:30,80:5:90]; % 80-90 [min]
%Times_fine{3,1}=[10:0.1:30,80:0.1:90];

Times{1,1}=[10:5:25,45:5:60]; % 45-60 [min]
Times_fine{1,1}=[10:0.1:25,45:0.1:60];
Times{2,1}=[10:5:25,60:5:75]; % 60-75 [min]
Times_fine{2,1}=[10:0.1:25,60:0.1:75];
Times{3,1}=[10:5:25,75:5:90]; % 75-90 [min]
Times_fine{3,1}=[10:0.1:25,75:0.1:90];

Times{4,1}=[10:5:20,30:5:50]; % 30-50 [min]
Times_fine{4,1}=[10:0.1:20,30:0.1:50];
Times{5,1}=[10:5:20,50:5:70]; % 50-70 [min]
Times_fine{5,1}=[10:0.1:20,50:0.1:70];
Times{6,1}=[10:5:20,70:5:90]; % 70-90 [min]
Times_fine{6,1}=[10:0.1:20,70:0.1:90];


for T=1:1:Num_TimeDu
    [Organ_NMSE_k1,Organ_NMSE_k2,Organ_NMSE_k3,Organ_NMSE_k4,Organ_NMSE_Ki,Organ_NMSE_Vd,Organ_NBias_k1,Organ_NBias_k2,Organ_NBias_k3,Organ_NBias_k4,Organ_NBias_Ki,Organ_NBias_Vd,Organ_NSD_k1,Organ_NSD_k2,Organ_NSD_k3,Organ_NSD_k4,Organ_NSD_Ki,Organ_NSD_Vd,Results,Results_Mean_SD,TTCM_WB,PCDE_WB,PCDE_FLT_WB,Patlak_WB,TTCM_SD_WB,PCDE_SD_WB,PCDE_FLT_SD_WB,Patlak_SD_WB,NMSE_k1,NMSE_k2,NMSE_k3,NMSE_k4,NMSE_Ki,NMSE_Vd,NBias_k1,NBias_k2,NBias_k3,NBias_k4,NBias_Ki,NBias_Vd,NSD_k1,NSD_k2,NSD_k3,NSD_k4,NSD_Ki,NSD_Vd,NMSE_micro,NMSE_macro,NBias_micro,NBias_macro,NSD_micro,NSD_macro]=virtual_simul_whole_batch_Multi_Organs(noise_level,num_batch,num_realization,Times{T,1},Times_fine{T,1});
    %file_name=append('Results_B_',num2str(num_batch),'_TimeDu_',num2str(max(Times{T,1})-min(Times{T,1})),'_wo.mat');
    file_name=append('Results_B_',num2str(num_batch),'_TimeDu_30','_TimeGap_',num2str(T+3),'_wo.mat');
    save(file_name, 'Organ_NMSE_k1','Organ_NMSE_k2','Organ_NMSE_k3','Organ_NMSE_k4','Organ_NMSE_Ki','Organ_NMSE_Vd','Organ_NBias_k1','Organ_NBias_k2','Organ_NBias_k3','Organ_NBias_k4','Organ_NBias_Ki','Organ_NBias_Vd','Organ_NSD_k1','Organ_NSD_k2','Organ_NSD_k3','Organ_NSD_k4','Organ_NSD_Ki','Organ_NSD_Vd','Results','Results_Mean_SD','TTCM_WB','PCDE_WB','PCDE_FLT_WB','Patlak_WB','TTCM_SD_WB','PCDE_SD_WB','PCDE_FLT_SD_WB','Patlak_SD_WB','NMSE_k1','NMSE_k2','NMSE_k3','NMSE_k4','NMSE_Ki','NMSE_Vd','NBias_k1','NBias_k2','NBias_k3','NBias_k4','NBias_Ki','NBias_Vd','NSD_k1','NSD_k2','NSD_k3','NSD_k4','NSD_Ki','NSD_Vd','NMSE_micro','NMSE_macro','NBias_micro','NBias_macro','NSD_micro','NSD_macro');

end


%% for Origin plotting!
%R1=load('Results_B_5_TimeDu_30_TimeGap_1_wo.mat');
%R2=load('Results_B_5_TimeDu_30_TimeGap_2_wo.mat');
%R3=load('Results_B_5_TimeDu_30_TimeGap_3_wo.mat');
%R4=load('Results_B_5_TimeDu_30_TimeGap_4_wo.mat');
%R5=load('Results_B_5_TimeDu_30_TimeGap_5_wo.mat');
%R6=load('Results_B_5_TimeDu_30_TimeGap_6_wo.mat');
%R7=load('Results_B_5_TimeDu_30_TimeGap_7_wo.mat');
%R8=load('Results_B_5_TimeDu_30_TimeGap_8_wo.mat');
%R9=load('Results_B_5_TimeDu_30_TimeGap_9_wo.mat');
%Num_R=9;
%org_ind=7;
%for R=1:1:Num_R
%    if R==1
%        k1=[R1.Organ_NMSE_k1{org_ind,1},R1.Organ_NBias_k1{org_ind,1},R1.Organ_NSD_k1{org_ind,1}];
%        k2=[R1.Organ_NMSE_k2{org_ind,1},R1.Organ_NBias_k2{org_ind,1},R1.Organ_NSD_k2{org_ind,1}];
%        k3=[R1.Organ_NMSE_k3{org_ind,1},R1.Organ_NBias_k3{org_ind,1},R1.Organ_NSD_k3{org_ind,1}];
%        Ki=[R1.Organ_NMSE_Ki{org_ind,1},R1.Organ_NBias_Ki{org_ind,1},R1.Organ_NSD_Ki{org_ind,1}];
%        Vd=[R1.Organ_NMSE_Vd{org_ind,1},R1.Organ_NBias_Vd{org_ind,1},R1.Organ_NSD_Vd{org_ind,1}];
%    elseif R==2
%        k1=cat(1, k1, [R2.Organ_NMSE_k1{org_ind,1},R2.Organ_NBias_k1{org_ind,1},R2.Organ_NSD_k1{org_ind,1}]);
%        k2=cat(1, k2, [R2.Organ_NMSE_k2{org_ind,1},R2.Organ_NBias_k2{org_ind,1},R2.Organ_NSD_k2{org_ind,1}]);
%        k3=cat(1, k3, [R2.Organ_NMSE_k3{org_ind,1},R2.Organ_NBias_k3{org_ind,1},R2.Organ_NSD_k3{org_ind,1}]);
%        Ki=cat(1, Ki, [R2.Organ_NMSE_Ki{org_ind,1},R2.Organ_NBias_Ki{org_ind,1},R2.Organ_NSD_Ki{org_ind,1}]);
%        Vd=cat(1, Vd, [R2.Organ_NMSE_Vd{org_ind,1},R2.Organ_NBias_Vd{org_ind,1},R2.Organ_NSD_Vd{org_ind,1}]);
%    elseif R==3
%        k1=cat(1, k1, [R3.Organ_NMSE_k1{org_ind,1},R3.Organ_NBias_k1{org_ind,1},R3.Organ_NSD_k1{org_ind,1}]);
%        k2=cat(1, k2, [R3.Organ_NMSE_k2{org_ind,1},R3.Organ_NBias_k2{org_ind,1},R3.Organ_NSD_k2{org_ind,1}]);
%        k3=cat(1, k3, [R3.Organ_NMSE_k3{org_ind,1},R3.Organ_NBias_k3{org_ind,1},R3.Organ_NSD_k3{org_ind,1}]);
%        Ki=cat(1, Ki, [R3.Organ_NMSE_Ki{org_ind,1},R3.Organ_NBias_Ki{org_ind,1},R3.Organ_NSD_Ki{org_ind,1}]);
%        Vd=cat(1, Vd, [R3.Organ_NMSE_Vd{org_ind,1},R3.Organ_NBias_Vd{org_ind,1},R3.Organ_NSD_Vd{org_ind,1}]);
%    elseif R==4
%        k1=cat(1, k1, [R4.Organ_NMSE_k1{org_ind,1},R4.Organ_NBias_k1{org_ind,1},R4.Organ_NSD_k1{org_ind,1}]);
%        k2=cat(1, k2, [R4.Organ_NMSE_k2{org_ind,1},R4.Organ_NBias_k2{org_ind,1},R4.Organ_NSD_k2{org_ind,1}]);
%        k3=cat(1, k3, [R4.Organ_NMSE_k3{org_ind,1},R4.Organ_NBias_k3{org_ind,1},R4.Organ_NSD_k3{org_ind,1}]);
%        Ki=cat(1, Ki, [R4.Organ_NMSE_Ki{org_ind,1},R4.Organ_NBias_Ki{org_ind,1},R4.Organ_NSD_Ki{org_ind,1}]);
%        Vd=cat(1, Vd, [R4.Organ_NMSE_Vd{org_ind,1},R4.Organ_NBias_Vd{org_ind,1},R4.Organ_NSD_Vd{org_ind,1}]);
%    elseif R==5
%        k1=cat(1, k1, [R5.Organ_NMSE_k1{org_ind,1},R5.Organ_NBias_k1{org_ind,1},R5.Organ_NSD_k1{org_ind,1}]);
%        k2=cat(1, k2, [R5.Organ_NMSE_k2{org_ind,1},R5.Organ_NBias_k2{org_ind,1},R5.Organ_NSD_k2{org_ind,1}]);
%        k3=cat(1, k3, [R5.Organ_NMSE_k3{org_ind,1},R5.Organ_NBias_k3{org_ind,1},R5.Organ_NSD_k3{org_ind,1}]);
%        Ki=cat(1, Ki, [R5.Organ_NMSE_Ki{org_ind,1},R5.Organ_NBias_Ki{org_ind,1},R5.Organ_NSD_Ki{org_ind,1}]);
%        Vd=cat(1, Vd, [R5.Organ_NMSE_Vd{org_ind,1},R5.Organ_NBias_Vd{org_ind,1},R5.Organ_NSD_Vd{org_ind,1}]);
%    elseif R==6
%        k1=cat(1, k1, [R6.Organ_NMSE_k1{org_ind,1},R6.Organ_NBias_k1{org_ind,1},R6.Organ_NSD_k1{org_ind,1}]);
%        k2=cat(1, k2, [R6.Organ_NMSE_k2{org_ind,1},R6.Organ_NBias_k2{org_ind,1},R6.Organ_NSD_k2{org_ind,1}]);
%        k3=cat(1, k3, [R6.Organ_NMSE_k3{org_ind,1},R6.Organ_NBias_k3{org_ind,1},R6.Organ_NSD_k3{org_ind,1}]);
%        Ki=cat(1, Ki, [R6.Organ_NMSE_Ki{org_ind,1},R6.Organ_NBias_Ki{org_ind,1},R6.Organ_NSD_Ki{org_ind,1}]);
%        Vd=cat(1, Vd, [R6.Organ_NMSE_Vd{org_ind,1},R6.Organ_NBias_Vd{org_ind,1},R6.Organ_NSD_Vd{org_ind,1}]);
%    elseif R==7
%        k1=cat(1, k1, [R7.Organ_NMSE_k1{org_ind,1},R7.Organ_NBias_k1{org_ind,1},R7.Organ_NSD_k1{org_ind,1}]);
%        k2=cat(1, k2, [R7.Organ_NMSE_k2{org_ind,1},R7.Organ_NBias_k2{org_ind,1},R7.Organ_NSD_k2{org_ind,1}]);
%        k3=cat(1, k3, [R7.Organ_NMSE_k3{org_ind,1},R7.Organ_NBias_k3{org_ind,1},R7.Organ_NSD_k3{org_ind,1}]);
%        Ki=cat(1, Ki, [R7.Organ_NMSE_Ki{org_ind,1},R7.Organ_NBias_Ki{org_ind,1},R7.Organ_NSD_Ki{org_ind,1}]);
%        Vd=cat(1, Vd, [R7.Organ_NMSE_Vd{org_ind,1},R7.Organ_NBias_Vd{org_ind,1},R7.Organ_NSD_Vd{org_ind,1}]);
%    elseif R==8
%        k1=cat(1, k1, [R8.Organ_NMSE_k1{org_ind,1},R8.Organ_NBias_k1{org_ind,1},R8.Organ_NSD_k1{org_ind,1}]);
%        k2=cat(1, k2, [R8.Organ_NMSE_k2{org_ind,1},R8.Organ_NBias_k2{org_ind,1},R8.Organ_NSD_k2{org_ind,1}]);
%        k3=cat(1, k3, [R8.Organ_NMSE_k3{org_ind,1},R8.Organ_NBias_k3{org_ind,1},R8.Organ_NSD_k3{org_ind,1}]);
%        Ki=cat(1, Ki, [R8.Organ_NMSE_Ki{org_ind,1},R8.Organ_NBias_Ki{org_ind,1},R8.Organ_NSD_Ki{org_ind,1}]);
%        Vd=cat(1, Vd, [R8.Organ_NMSE_Vd{org_ind,1},R8.Organ_NBias_Vd{org_ind,1},R8.Organ_NSD_Vd{org_ind,1}]);
%    elseif R==9
%        k1=cat(1, k1, [R9.Organ_NMSE_k1{org_ind,1},R9.Organ_NBias_k1{org_ind,1},R9.Organ_NSD_k1{org_ind,1}]);
%        k2=cat(1, k2, [R9.Organ_NMSE_k2{org_ind,1},R9.Organ_NBias_k2{org_ind,1},R9.Organ_NSD_k2{org_ind,1}]);
%        k3=cat(1, k3, [R9.Organ_NMSE_k3{org_ind,1},R9.Organ_NBias_k3{org_ind,1},R9.Organ_NSD_k3{org_ind,1}]);
%        Ki=cat(1, Ki, [R9.Organ_NMSE_Ki{org_ind,1},R9.Organ_NBias_Ki{org_ind,1},R9.Organ_NSD_Ki{org_ind,1}]);
%        Vd=cat(1, Vd, [R9.Organ_NMSE_Vd{org_ind,1},R9.Organ_NBias_Vd{org_ind,1},R9.Organ_NSD_Vd{org_ind,1}]);
%    end
%end













