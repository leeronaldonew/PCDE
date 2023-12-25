
function [Results_PGA_Ki,Results_PGA_Vd,Results_TTCM_K1,Results_TTCM_k2,Results_TTCM_k3,Results_PCDE_K1,Results_PCDE_k2,Results_PCDE_k3,Results_PCDE_Ki,Results_PCDE_Vd]=XCAT_KM(ROI,Num_Iter,Act_XCAT_Recon,Act_XCAT_Recon_Bed,mask,Decay_ind_input,Denoising_Ind_input)

%% Importing IDIF (FDG)
global Local_Estimates;
load Local_Estimates.mat

%% Making 4D Arrays(Decay Corrected) of WB_kBq [kBq/ml], PI_Time [min], C_tot_over_C_p, and Integ_C_t_over_C_p  
% Setting for Physical Decay Correct & Denoising by FLT
lamda=0.006; % 18F:6.3185*10^(-3), 177Lu=7.2416*10^(-5)
Decay_ind=Decay_ind_input; % 1: Doing Decay Correction, 0: X Decay Correction

%load XCAT_Recon_Iter_1_N_1.mat
%Num_Passes=11;
%Num_Beds=3;
Num_Passes=size(Act_XCAT_Recon,1);
Num_Beds=size(Act_XCAT_Recon_Bed,2);

for p=1:1:Num_Passes
    Names_Passes(p)="Pass_" +p;
end
for p=1:1:Num_Passes
    Vol_WB.(Names_Passes(p)){1,1}=Act_XCAT_Recon{p,1};
end
time_temp=[121000,121500,122000,122500,123000,123500,124000,124500,125000,125500,130000,130500,131000,131500,132000,132500,133000];
for p=1:1:Num_Passes
    for b=1:1:Num_Beds
        Vol_Multi_WB.(Names_Passes(p)){b,1}=Act_XCAT_Recon_Bed{p,b};
        Vol_Multi_WB.(Names_Passes(p)){b,2}=time_temp(1,p);
    end
end
for p=1:1:Num_Passes
    for b=1:1:Num_Beds
        Times_Multi_WB.(Names_Passes(p))(1,b)=Vol_Multi_WB.(Names_Passes(p)){b,2};
    end
end
Inject_Time='120000.00';
Make_4D_Array(Num_Passes,Num_Beds,Vol_WB,Vol_Multi_WB,Times_Multi_WB, Inject_Time, Decay_ind, lamda);
save Num_Passes.mat Num_Passes;
save Num_Beds.mat Num_Beds;

%% Generation of New kBq & C_tot_over_C_p in order to do the Kinetic Modeling only for the ROI
load kBq.mat
load C_tot_over_C_p.mat
%load mask.mat
for p=1:1:Num_Passes
    kBq_masked(:,:,:,p)=kBq(:,:,:,p).*mask;
    C_tot_over_C_p_masked(:,:,:,p)=C_tot_over_C_p(:,:,:,p).*mask;
end
kBq=kBq_masked;
C_tot_over_C_p= C_tot_over_C_p_masked;
save kBq.mat kBq -v7.3
save C_tot_over_C_p.mat C_tot_over_C_p -v7.3
clearvars -except mask Decay_ind_input Denoising_Ind_input ROI Num_Iter

%% Generation of Parametric Volume (PGA)
t1=clock;
load Num_Passes
load Num_Beds
%Starting_Patlak=[1;100]; % K_i:net influx rate (slope), V_d: volume of dist. (intercept)
%LB_Patlak=[0;-1000]; % Lower Bound of the Kinetic Parameters (i.e., Rate Constants)
%UB_Patlak=[10;1000]; % Upper Bound of the Kinetic Parameters (i.e., Rate Constants)
Starting_Patlak=[0.001;0.01]; % K_i:net influx rate (slope), V_d: volume of dist. (intercept)
LB_Patlak=[0;0]; % Lower Bound of the Kinetic Parameters (i.e., Rate Constants)
UB_Patlak=[1;1]; % Upper Bound of the Kinetic Parameters (i.e., Rate Constants)
Gen_Parametric_Vol_Patlak(Num_Passes, Num_Beds, Starting_Patlak, LB_Patlak, UB_Patlak); 
t2=clock; % 6 [min] (using GPUfit)
e_time=etime(t2,t1)/60 % [min]
save E_time_PGA.mat e_time
clearvars -except mask Decay_ind_input Denoising_Ind_input ROI Num_Iter
%% Generation of Parametric Volume (2TCM)
% Kinetic Modeling with Two Tissue Comp. Model (w/o liniearization)
load Num_Passes
load Num_Beds
t1=clock;
%Starting_TTCM=[0.01;0.01;0.01;0.001]; % K_1;K_2;K_3;K_4 (origin)
Starting_TTCM=[0.01;0.01;0.001;0]; % K_1;K_2;K_3;K_4
LB_TTCM=[0;0;0;0]; % Lower Bound of the Kinetic Parameters (i.e., Rate Constants)
UB_TTCM=[1;1;0.5;0]; % Upper Bound of the Kinetic Parameters (i.e., Rate Constants)
Gen_Parametric_Vol_TTCM(Num_Passes, Num_Beds, Starting_TTCM, LB_TTCM, UB_TTCM); 
t2=clock; % 58 [min] (using GPUfit)
e_time=etime(t2,t1)/60 % [min]
save E_time_2TCM.mat e_time
clearvars -except mask Decay_ind_input Denoising_Ind_input ROI Num_Iter

%% Generation of Parametric Volume (PCDE)
Denoising_Ind=Denoising_Ind_input; % 1: Denoising with FLT, 0: X Denoising
load Local_Estimates;
load PI_Times_Multi_WB.mat;
load Vol_Multi_WB_PCDE.mat;
load kBq;
load PI_Time;
load Num_Passes;
load Num_Beds;
PI_Times_PCDE=cell2mat(struct2cell(PI_Times_Multi_WB));
t1=clock;
Optim_Ks=PCDE_WB_Speedy(PI_Time,kBq,Vol_Multi_WB_PCDE, Num_Passes,Num_Beds, PI_Times_PCDE, Local_Estimates,Denoising_Ind);
t2=clock;
Elapsed_Time=etime(t2,t1)/60 % [min]
save E_time_PCDE.mat Elapsed_Time
save Optim_Ks.mat Optim_Ks
clearvars -except mask Decay_ind_input Denoising_Ind_input ROI Num_Iter

%% Loading Parametric Volumes
% for Patlak
load K_i;
load V_d;
% for 2TCM
load k1;
load k2;
load k3;
% for PCDE
load Optim_Ks;
k1_PCDE=squeeze(Optim_Ks(:,:,:,1));
k2_PCDE=squeeze(Optim_Ks(:,:,:,2));
k3_PCDE=squeeze(Optim_Ks(:,:,:,3));
Ki_PCDE=(k1_PCDE.*k3_PCDE)./ (k2_PCDE+k3_PCDE);
Vd_PCDE=(k1_PCDE.*k2_PCDE) ./ ((k2_PCDE+k3_PCDE).^(2));
Ki_PCDE(isnan(Ki_PCDE))=0;
Vd_PCDE(isnan(Vd_PCDE))=0;

%% Summary of the Results
if ROI==0 % WB
    % PGA
    Results_PGA_Ki(:,1)=0;
    Results_PGA_Vd(:,1)=0;
    ROI_Result.PGA_Ki=K_i;
    ROI_Result.PGA_Vd=V_d;
    % 2TCM
    Results_TTCM_K1(:,1)=0;
    Results_TTCM_k2(:,1)=0;
    Results_TTCM_k3(:,1)=0;
    ROI_Result.TTCM_K1=k1;
    ROI_Result.TTCM_k2=k2;
    ROI_Result.TTCM_k3=k3;
    % PCDE
    Results_PCDE_K1(:,1)=0;
    Results_PCDE_k2(:,1)=0;
    Results_PCDE_k3(:,1)=0;
    Results_PCDE_Ki(:,1)=0;
    Results_PCDE_Vd(:,1)=0;
    ROI_Result.PCDE_K1=k1_PCDE;
    ROI_Result.PCDE_k2=k2_PCDE;
    ROI_Result.PCDE_k3=k3_PCDE;
    ROI_Result.PCDE_Ki=Ki_PCDE;
    ROI_Result.PCDE_Vd=Vd_PCDE;
    % saving Parametric Volumes for WB
    filename= string(['WB_Iter_', num2str(Num_Iter),'.mat']);
    save(filename, 'ROI_Result', '-v7.3');
else % Other ROIs
    % PGA
    Results_PGA_Ki(:,1)=K_i(find(mask~=0));
    Results_PGA_Vd(:,1)=V_d(find(mask~=0));
    % 2TCM
    Results_TTCM_K1(:,1)=k1(find(mask~=0));
    Results_TTCM_k2(:,1)=k2(find(mask~=0));
    Results_TTCM_k3(:,1)=k3(find(mask~=0));
    % PCDE
    Results_PCDE_K1(:,1)=k1_PCDE(find(mask~=0));
    Results_PCDE_k2(:,1)=k2_PCDE(find(mask~=0));
    Results_PCDE_k3(:,1)=k3_PCDE(find(mask~=0));
    Results_PCDE_Ki(:,1)=Ki_PCDE(find(mask~=0));
    Results_PCDE_Vd(:,1)=Vd_PCDE(find(mask~=0));
end



end