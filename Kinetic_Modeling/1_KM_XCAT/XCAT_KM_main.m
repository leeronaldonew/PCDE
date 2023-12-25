%% XCAT_KM_main
function []=XCAT_KM_main(ROI,Num_Iter,Num_Real,Num_Pass,Decay_Ind,Denoising_Ind)
%% Setting Physical Decay Correction & Denoising with FLT
%Decay_Ind=0; % 1: Doing Decay Correction, 0: X Decay Correction
%Denoising_Ind=0; % 1: Denoising with FLT, 0: X Denoising

%% Selection of ROI & Num_Iter(MLEM) to Analyze
% 0: WB (Whole-Body)
% 1: Brain_GM, 2: Brain_WM, 3: Thyroid, 4: Myocardium, 5: Spleen
% 6: Pancreas, 7: Kidney, 8: Liver, 9: Lung
% 12: Lung Tumor, 13: Liver Tumor, 14: Brain Tumor
%ROI=8;
%Num_Iter=1;
%Num_Real=10;

%% Loading Mask for the selected ROI
switch ROI
    case 0 % WB: 0
        load mask_WB.mat
        mask=mask_WB;
    case 1 % Brain GM: 1
        load mask_BrainGM.mat
        mask=mask_BrainGM;
    case 2 % Brain WM: 2 
        load mask_BrainWM.mat
        mask=mask_BrainWM;
    case 3 % Thyroid: 3
        load mask_Thyroid.mat
        mask=mask_Thyroid;
    case 4 % Myocardium: 4
        load mask_Myocardium.mat
        mask=mask_Myocardium;
    case 5 % Spleen: 5
        load mask_Spleen.mat
        mask=mask_Spleen;
    case 6 % Pancreas: 6
        load mask_Pancreas.mat
        mask=mask_Pancreas;
    case 7 % Kidney: 7
        load mask_Kidney.mat
        mask=mask_Kidney;
    case 8 % Liver: 8
        load mask_Liver.mat
        mask=mask_Liver;
    case 9 % Lung: 9
        load mask_Lung.mat
        mask=mask_Lung;
    case 12 % Lung Tumor: 12
        load mask_Lung_Tumor.mat
        mask=mask_Lung_Tumor;
    case 13 % Liver Tumor: 13
        load mask_Liver_Tumor.mat
        mask=mask_Liver_Tumor;
    case 14 % Brain Tumor: 14
        load mask_Brain_Tumor.mat
        mask=mask_Brain_Tumor;
end

%% Kinetic Modeling
ROI_Names=["BrainGM", "BrainWM", "Thyroid", "Myocardium", "Spleen", "Pancreas", "Kidney", "Liver", "Lung", "Muscle", "Bone", "LungTumor", "LiverTumor", "BrainTumor"];
t1=clock;
for N=1:1:Num_Real
    filename= string(['XCAT_Recon_Iter_', num2str(Num_Iter),'_N_',num2str(N),'.mat']);
    load(filename);
    if ROI==0 % WB
        mask_temp=mask;
        for p=1:1:Num_Pass
            %% Original (for OMEGA)
            %Act_XCAT_Recon_temp{p,1}=Act_XCAT_Recon{p,1};
            %Act_XCAT_Recon_Bed_temp{p,1}=Act_XCAT_Recon_temp{p,1}(:,:,1:159);
            %Act_XCAT_Recon_Bed_temp{p,2}=Act_XCAT_Recon_temp{p,1}(:,:,160:318);
            %Act_XCAT_Recon_Bed_temp{p,3}=Act_XCAT_Recon_temp{p,1}(:,:,319:477);
            %% Modified (for dPETSTEP)
            Act_XCAT_Recon_temp{p,1}=Act_XCAT_Recon{p,1};
            Act_XCAT_Recon_Bed_temp{p,1}=Act_XCAT_Recon_temp{p,1}(:,:,1:35);
            Act_XCAT_Recon_Bed_temp{p,2}=Act_XCAT_Recon_temp{p,1}(:,:,36:70);
            Act_XCAT_Recon_Bed_temp{p,3}=Act_XCAT_Recon_temp{p,1}(:,:,71:105);
            Act_XCAT_Recon_Bed_temp{p,4}=Act_XCAT_Recon_temp{p,1}(:,:,106:140);
            Act_XCAT_Recon_Bed_temp{p,5}=Act_XCAT_Recon_temp{p,1}(:,:,141:175);
        end
    %elseif ROI==12 || ROI==13 || ROI==14 % Tumors
        %% X-Interpolation
        %mask_temp=mask;
        %for p=1:1:Num_Pass
        %    Act_XCAT_Recon_temp{p,1}=Act_XCAT_Recon{p,1};
        %    Act_XCAT_Recon_Bed_temp{p,1}=Act_XCAT_Recon_temp{p,1}(:,:,1:35);
        %    Act_XCAT_Recon_Bed_temp{p,2}=Act_XCAT_Recon_temp{p,1}(:,:,36:70);
        %    Act_XCAT_Recon_Bed_temp{p,3}=Act_XCAT_Recon_temp{p,1}(:,:,71:105);
        %    Act_XCAT_Recon_Bed_temp{p,4}=Act_XCAT_Recon_temp{p,1}(:,:,106:140);
        %    Act_XCAT_Recon_Bed_temp{p,5}=Act_XCAT_Recon_temp{p,1}(:,:,141:175);
        %end  
        %% Interpolation
        %mask_temp=imresize3(mask,[82,82,87], 'nearest'); 
        %mask_temp(find(mask_temp~=0))=1;
        %for p=1:1:Num_Pass
        %    Act_XCAT_Recon_temp{p,1}=imresize3(Act_XCAT_Recon{p,1},[82,82,87],'nearest');
        %    Act_XCAT_Recon_Bed_temp{p,1}=Act_XCAT_Recon_temp{p,1}(:,:,1:18);
        %    Act_XCAT_Recon_Bed_temp{p,2}=Act_XCAT_Recon_temp{p,1}(:,:,19:36);
        %    Act_XCAT_Recon_Bed_temp{p,3}=Act_XCAT_Recon_temp{p,1}(:,:,37:54);
        %    Act_XCAT_Recon_Bed_temp{p,4}=Act_XCAT_Recon_temp{p,1}(:,:,55:72);
        %    Act_XCAT_Recon_Bed_temp{p,5}=Act_XCAT_Recon_temp{p,1}(:,:,73:87);
        %end
    else % all ROIs except for the WB (except for Tumors)
        %% Original (Normal)
        %mask_temp=mask;
        %for p=1:1:Num_Pass
        %    Act_XCAT_Recon_temp{p,1}=Act_XCAT_Recon{p,1};
        %    Act_XCAT_Recon_Bed_temp{p,1}=Act_XCAT_Recon_temp{p,1}(:,:,1:35);
        %    Act_XCAT_Recon_Bed_temp{p,2}=Act_XCAT_Recon_temp{p,1}(:,:,36:70);
        %    Act_XCAT_Recon_Bed_temp{p,3}=Act_XCAT_Recon_temp{p,1}(:,:,71:105);
        %    Act_XCAT_Recon_Bed_temp{p,4}=Act_XCAT_Recon_temp{p,1}(:,:,106:140);
        %    Act_XCAT_Recon_Bed_temp{p,5}=Act_XCAT_Recon_temp{p,1}(:,:,141:175);
        %end
        %% To reduce Comp. Time (for OMEGA)
        %mask_temp=imresize3(mask,[110,110,238], 'nearest');
        %mask_temp(find(mask_temp~=0))=1;
        %for p=1:1:Num_Pass
        %    Act_XCAT_Recon_temp{p,1}=imresize3(Act_XCAT_Recon{p,1},[110,110,238]);
        %    Act_XCAT_Recon_Bed_temp{p,1}=Act_XCAT_Recon_temp{p,1}(:,:,1:80);
        %    Act_XCAT_Recon_Bed_temp{p,2}=Act_XCAT_Recon_temp{p,1}(:,:,81:160);
        %    Act_XCAT_Recon_Bed_temp{p,3}=Act_XCAT_Recon_temp{p,1}(:,:,161:238);
        %end 
        %% To reduce Comp. Time (for dPETSTEP)
        mask_temp=imresize3(mask,[83,83,88], 'nearest'); % original
        %mask_temp=imresize3(mask,[83,83,88], 'cubic'); 
        mask_temp(find(mask_temp~=0))=1;
        for p=1:1:Num_Pass
            Act_XCAT_Recon_temp{p,1}=imresize3(Act_XCAT_Recon{p,1},[83,83,88],'nearest');
            Act_XCAT_Recon_Bed_temp{p,1}=Act_XCAT_Recon_temp{p,1}(:,:,1:18);
            Act_XCAT_Recon_Bed_temp{p,2}=Act_XCAT_Recon_temp{p,1}(:,:,19:36);
            Act_XCAT_Recon_Bed_temp{p,3}=Act_XCAT_Recon_temp{p,1}(:,:,37:54);
            Act_XCAT_Recon_Bed_temp{p,4}=Act_XCAT_Recon_temp{p,1}(:,:,55:72);
            Act_XCAT_Recon_Bed_temp{p,5}=Act_XCAT_Recon_temp{p,1}(:,:,73:88);
        end 
    end
    [PGA_Ki_t,PGA_Vd_t,TTCM_K1_t,TTCM_k2_t,TTCM_k3_t,PCDE_K1_t,PCDE_k2_t,PCDE_k3_t,PCDE_Ki_t,PCDE_Vd_t]=XCAT_KM(ROI,Num_Iter,Act_XCAT_Recon_temp,Act_XCAT_Recon_Bed_temp,mask_temp,Decay_Ind,Denoising_Ind);  
    if N==1
        PGA_Ki=PGA_Ki_t;
        PGA_Vd=PGA_Vd_t;
        TTCM_K1=TTCM_K1_t;
        TTCM_k2=TTCM_k2_t;
        TTCM_k3=TTCM_k3_t;
        PCDE_K1=PCDE_K1_t;
        PCDE_k2=PCDE_k2_t;
        PCDE_k3=PCDE_k3_t;
        PCDE_Ki=PCDE_Ki_t;
        PCDE_Vd=PCDE_Vd_t;
    else
        PGA_Ki=cat(2,PGA_Ki,PGA_Ki_t);
        PGA_Vd=cat(2,PGA_Vd,PGA_Vd_t);
        TTCM_K1=cat(2,TTCM_K1,TTCM_K1_t);
        TTCM_k2=cat(2,TTCM_k2,TTCM_k2_t);
        TTCM_k3=cat(2,TTCM_k3,TTCM_k3_t);
        PCDE_K1=cat(2,PCDE_K1,PCDE_K1_t);
        PCDE_k2=cat(2,PCDE_k2,PCDE_k2_t);
        PCDE_k3=cat(2,PCDE_k3,PCDE_k3_t);
        PCDE_Ki=cat(2,PCDE_Ki,PCDE_Ki_t);
        PCDE_Vd=cat(2,PCDE_Vd,PCDE_Vd_t);
    end
    if ROI==0 % WB
        break
    end
end
t2=clock;
E_time_TOT=etime(t2,t1)/Num_Real; % Analysis Time per Noise Realization for a specific ROI (PGA+2TCM+PCDE)
E_time_TOT=E_time_TOT/60 % [min]
save E_time_TOT.mat E_time_TOT

%% Saving the Results
if ROI==0 % WB
    %filename= string(['WB_Iter_', num2str(Num_Iter),'.mat']);
else % Other ROIs
    ROI_Result.PGA_Ki=PGA_Ki;
    ROI_Result.PGA_Vd=PGA_Vd;
    ROI_Result.TTCM_K1=TTCM_K1;
    ROI_Result.TTCM_k2=TTCM_k2;
    ROI_Result.TTCM_k3=TTCM_k3;
    ROI_Result.PCDE_K1=PCDE_K1;
    ROI_Result.PCDE_k2=PCDE_k2;
    ROI_Result.PCDE_k3=PCDE_k3;
    ROI_Result.PCDE_Ki=PCDE_Ki;
    ROI_Result.PCDE_Vd=PCDE_Vd;
    filename= string([char(ROI_Names(ROI)),'_Iter_', num2str(Num_Iter),'.mat']);
    save(filename, 'ROI_Result', '-v7.3');
end


end