%% Quant_Anal_main_Batch
% ROI
% 1: Brain_GM, 2: Brain_WM, 3: Thyroid, 4: Myocardium, 5: Spleen
% 6: Pancreas, 7: Kidney, 8: Liver, 9: Lung
% 12: Lung Tumor, 13: Liver Tumor, 14: Brain Tumor
% BKG_ROI
% 0: for Normal Organs, others: for Tumors ==> 2: Brain_WM, 9:Lung, 8: Liver

clear

% Entering ROI and Num_Iter Info. to Analyze
ROI=9;
BKG_ROI=9;
Num_Iter=5;
Num_Batch=2;

%Reals_Ind_Batch{1,1}=[1,2];
%Reals_Ind_Batch{2,1}=[3,4];
Reals_Ind_Batch{1,1}=[1:5];
Reals_Ind_Batch{2,1}=[6:10];
%Reals_Ind_Batch{1,1}=[1:10];
%Reals_Ind_Batch{2,1}=[11:20];

% Loading Data to Analyze
ROI_Names=["BrainGM", "BrainWM", "Thyroid", "Myocardium", "Spleen", "Pancreas", "Kidney", "Liver", "Lung", "Muscle", "Bone", "LungTumor", "LiverTumor", "BrainTumor"];
filename= string([char(ROI_Names(ROI)),'_Iter_', num2str(Num_Iter),'.mat']);
load(filename);

% Collecting Results Batch-by-Batch
for B=1:1:Num_Batch
    ind=Reals_Ind_Batch{B,1};
    ROI_Result_temp.PGA_Ki=ROI_Result.PGA_Ki(:,ind);
    ROI_Result_temp.PGA_Vd=ROI_Result.PGA_Vd(:,ind);
    ROI_Result_temp.TTCM_K1=ROI_Result.TTCM_K1(:,ind);
    ROI_Result_temp.TTCM_k2=ROI_Result.TTCM_k2(:,ind);
    ROI_Result_temp.TTCM_k3=ROI_Result.TTCM_k3(:,ind);
    ROI_Result_temp.PCDE_K1=ROI_Result.PCDE_K1(:,ind);
    ROI_Result_temp.PCDE_k2=ROI_Result.PCDE_k2(:,ind);
    ROI_Result_temp.PCDE_k3=ROI_Result.PCDE_k3(:,ind);
    ROI_Result_temp.PCDE_Ki=ROI_Result.PCDE_Ki(:,ind);
    ROI_Result_temp.PCDE_Vd=ROI_Result.PCDE_Vd(:,ind);
    [Quant]=Quant_Anal_main(ROI_Result_temp,ROI,BKG_ROI,Num_Iter,ind);
    Result_Batch{B,1}=Quant;
end


for param=1:1:10 % the # of parameter types
    for stat=1:1:10 % the # of quantities
        switch Num_Batch
            case 1 % when using 1 batches
                Result_Final(param,2*(stat-1)+1)=Result_Batch{1,1}(param,stat); 
                Result_Final(param,2*stat)=0;
            case 2 % when using 2 batches
                Result_Final(param,2*(stat-1)+1)=mean([Result_Batch{1,1}(param,stat),Result_Batch{2,1}(param,stat)]); 
                Result_Final(param,2*stat)=std([Result_Batch{1,1}(param,stat),Result_Batch{2,1}(param,stat)]);
            case 3 % when using 3 batches   
                Result_Final(param,2*(stat-1)+1)=mean([Result_Batch{1,1}(param,stat),Result_Batch{2,1}(param,stat),Result_Batch{3,1}(param,stat)]); 
                Result_Final(param,2*stat)=std([Result_Batch{1,1}(param,stat),Result_Batch{2,1}(param,stat),Result_Batch{3,1}(param,stat)]);
        end
    end
end

filename= string(['FinalResult_',char(ROI_Names(ROI)),'_Iter_', num2str(Num_Iter),'.mat']);
save(filename,'Result_Final');
clear
