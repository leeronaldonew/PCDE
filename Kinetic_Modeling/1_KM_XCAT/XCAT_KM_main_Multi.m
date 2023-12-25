%% XCAT_KM_main_Multi
clear
%% Selection of ROI & Num_Iter(MLEM) to Analyze
% 0: WB (Whole-Body)
% 1: Brain_GM, 2: Brain_WM, 3: Thyroid, 4: Myocardium, 5: Spleen
% 6: Pancreas, 7: Kidney, 8: Liver, 9: Lung
% 12: Lung Tumor, 13: Liver Tumor, 14: Brain Tumor
%% Setting Physical Decay Correction & Denoising with FLT
Decay_Ind=0; % 1: Doing Decay Correction, 0: X Decay Correction
Denoising_Ind=0; % 1: Denoising with FLT, 0: X Denoising



%% 1) KM for Multiple ROIs
%ROIs=[1,2,3,4,5,6,7,8,9,12,13,14];
%Num_ROIs=size(ROIs,2);
%Num_Iter=4;
%Num_Real=10;
%Num_Pass=11; % the # of Passes that you want to use for KM
%t1=clock;
%for Target=1:1:Num_ROIs
%    Target
%    XCAT_KM_main(ROIs(Target),Num_Iter,Num_Real,Num_Pass,Decay_Ind,Denoising_Ind);
%end
%t2=clock;
%E_time_Multi_ROIs=etime(t2,t1);
%E_time_Multi_ROIs=E_time_Multi_ROIs/3600; % [hr]
%save E_time_Multi_ROIs.mat E_time_Multi_ROIs

%% 2) KM for Multiple Num_Iter
%ROI=6;
%Num_Iters=[5];
%Num_Real=4;
%Num_Pass=11; % the # of Passes that you want to use for KM
%Num_Num_Iter=size(Num_Iters,2);
%t1=clock;
%for Iter=1:1:Num_Num_Iter
%    XCAT_KM_main(ROI,Num_Iters(Iter),Num_Real,Num_Pass,Decay_Ind,Denoising_Ind);
%end
%t2=clock;
%E_time_Multi_Iters=etime(t2,t1);
%E_time_Multi_Iters=E_time_Multi_Iters/3600; % [hr]
%save E_time_Multi_Iters.mat E_time_Multi_Iters

%% 2) KM for Multiple ROIs & Num_Iters
ROIs=[1,3,4,5,6,7,8,9,12,13,14];
Num_Iters=[1,2,3,4,5];
Num_Real=10; % total # of Noise Realizations
Num_Pass=7; % the # of Passes that you want to use for KM (40 min data)
t1=clock;
for I=1:1:size(Num_Iters,2)
    Num_Iter=Num_Iters(I);
    for Target=1:1:size(ROIs,2)
        Target
        XCAT_KM_main(ROIs(Target),Num_Iter,Num_Real,Num_Pass,Decay_Ind,Denoising_Ind);
    end
end
t2=clock;
E_time_Multi_ROIs_Iters=etime(t2,t1);
E_time_Multi_ROIs_Iters=E_time_Multi_ROIs_Iters/3600; % [hr]
save E_time_Multi_ROIs_Iters.mat E_time_Multi_ROIs_Iters


%% 0) KM for WB
t1=clock;
ROI=0;
Num_Iters=[5];
Num_Real=1;
Num_Pass=7; % the # of Passes that you want to use for KM
Num_Num_Iter=size(Num_Iters,2);
for Iter=1:1:Num_Num_Iter
    XCAT_KM_main(ROI,Num_Iters(Iter),Num_Real,Num_Pass,Decay_Ind,Denoising_Ind);
end
t2=clock;
E_time_Multi_WB=etime(t2,t1);
E_time_Multi_WB=E_time_Multi_WB/3600; % [hr]
save E_time_Multi_WB.mat E_time_Multi_WB

clear