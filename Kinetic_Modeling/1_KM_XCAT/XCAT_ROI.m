%% Generation of ROI
clear

load Act_XCAT.mat
load Act_Brain_Tumor.mat
load Act_Lung_Tumor.mat
load Act_Liver_Tumor.mat

load True_Val.mat % Activity Info.
load True_params.mat % True Kinetic Parameter Info.

%% Making XCAT_True with Tumors
for p=1:1:17
    temp=Act_XCAT{p,1}(:);
    temp(find(Act_Brain_Tumor(:) ~=0))=True_Val(14,p);
    temp(find(Act_Lung_Tumor(:) ~=0))=True_Val(12,p);
    temp(find(Act_Liver_Tumor(:) ~=0))=True_Val(13,p);
    Act_XCAT_Tumors{p,1}=reshape(temp,[165,165,175]); % Activity Volume with Tumors
end
for p=1:1:17
    for b=1:1:5
        Act_XCAT_Tumors_Bed{p,b}=Act_XCAT_Tumors{p,1}(:,:,(1+((b-1)*35)):(35*b));
    end
end
save Act_XCAT_Tumors.mat Act_XCAT_Tumors -v7.3
save Act_XCAT_Tumors_Bed.mat Act_XCAT_Tumors_Bed -v7.3

%% Extracting ROI Masks using True Value

% Brain GM: 1
zeros_temp=zeros(165*165*175,1);
zeros_temp(find(round(Act_XCAT_Tumors{1,1}(:)) == round(True_Val(1,1))))=1;
mask_BrainGM=reshape(zeros_temp,[165,165,175]);
% Brain WM: 2
zeros_temp=zeros(165*165*175,1);
zeros_temp(find(round(Act_XCAT_Tumors{1,1}(:)) == round(True_Val(2,1))))=1;
mask_BrainWM=reshape(zeros_temp,[165,165,175]);
% Thyroid: 3
zeros_temp=zeros(165*165*175,1);
zeros_temp(find(round(Act_XCAT_Tumors{1,1}(:)) == round(True_Val(3,1))))=1;
mask_Thyroid=reshape(zeros_temp,[165,165,175]);
% Myocardium: 4
zeros_temp=zeros(165*165*175,1);
zeros_temp(find(round(Act_XCAT_Tumors{1,1}(:)) == round(True_Val(4,1))))=1;
mask_Myocardium=reshape(zeros_temp,[165,165,175]);
% Spleen: 5
zeros_temp=zeros(165*165*175,1);
zeros_temp(find(round(Act_XCAT_Tumors{1,1}(:)) == round(True_Val(5,1))))=1;
mask_Spleen=reshape(zeros_temp,[165,165,175]);
% Pancreas: 6
zeros_temp=zeros(165*165*175,1);
zeros_temp(find(round(Act_XCAT_Tumors{1,1}(:)) == round(True_Val(6,1))))=1;
mask_Pancreas=reshape(zeros_temp,[165,165,175]);
% Kidney: 7
zeros_temp=zeros(165*165*175,1);
zeros_temp(find(round(Act_XCAT_Tumors{1,1}(:)) == round(True_Val(7,1))))=1;
mask_Kidney=reshape(zeros_temp,[165,165,175]);
% Liver: 8
zeros_temp=zeros(165*165*175,1);
zeros_temp(find(round(Act_XCAT_Tumors{1,1}(:)) == round(True_Val(8,1))))=1;
mask_Liver=reshape(zeros_temp,[165,165,175]);
% Lung: 9
zeros_temp=zeros(165*165*175,1);
zeros_temp(find(round(Act_XCAT_Tumors{1,1}(:)) == round(True_Val(9,1))))=1;
mask_Lung=reshape(zeros_temp,[165,165,175]);
% Muscle: 10
zeros_temp=zeros(165*165*175,1);
zeros_temp(find(round(Act_XCAT_Tumors{1,1}(:)) == round(True_Val(10,1))))=1;
mask_Muscle=reshape(zeros_temp,[165,165,175]);
% Bone: 11
zeros_temp=zeros(165*165*175,1);
zeros_temp(find(round(Act_XCAT_Tumors{1,1}(:)) == round(True_Val(11,1))))=1;
mask_Bone=reshape(zeros_temp,[165,165,175]);
% Lung Tumor: 12
zeros_temp=zeros(165*165*175,1);
zeros_temp(find(round(Act_XCAT_Tumors{1,1}(:)) == round(True_Val(12,1))))=1;
mask_Lung_Tumor=reshape(zeros_temp,[165,165,175]);
% Liver Tumor: 13
zeros_temp=zeros(165*165*175,1);
zeros_temp(find(round(Act_XCAT_Tumors{1,1}(:)) == round(True_Val(13,1))))=1;
mask_Liver_Tumor=reshape(zeros_temp,[165,165,175]);
% Brain Tumor: 14
zeros_temp=zeros(165*165*175,1);
zeros_temp(find(round(Act_XCAT_Tumors{1,1}(:)) == round(True_Val(14,1))))=1;
mask_Brain_Tumor=reshape(zeros_temp,[165,165,175]);

% WB: 0
zeros_temp=zeros(165*165*175,1);
mask_WB= mask_BrainWM+mask_Thyroid+mask_Myocardium+mask_Spleen+mask_Pancreas+mask_Kidney+mask_Liver+mask_Lung+mask_Muscle+mask_Bone+mask_Brain_Tumor+mask_Lung_Tumor+mask_Liver_Tumor;

save mask_WB.mat mask_WB
save mask_BrainGM.mat mask_BrainGM
save mask_BrainWM.mat mask_BrainWM
save mask_Thyroid.mat mask_Thyroid
save mask_Myocardium.mat mask_Myocardium
save mask_Spleen.mat mask_Spleen
save mask_Pancreas.mat mask_Pancreas
save mask_Kidney.mat mask_Kidney
save mask_Liver.mat mask_Liver
save mask_Lung.mat mask_Lung
save mask_Lung_Tumor.mat mask_Lung_Tumor
save mask_Liver_Tumor.mat mask_Liver_Tumor
save mask_Brain_Tumor.mat mask_Brain_Tumor
save mask_Muscle.mat mask_Muscle
save mask_Bone.mat mask_Bone

%% Gen. True Volumes (i.e., True_4D, Ki,Vd,K1,k2,k3)
% True_4D (Activity Volume)
for p=1:1:size(Act_XCAT_Tumors,1)
    True_4D(:,:,:,p)=Act_XCAT_Tumors{p,1};
end
True_4D=single(True_4D);
% Ki (5th column)
ind=5;
True_Ki=mask_BrainWM.*True_params(2,ind)+mask_Thyroid.*True_params(3,ind)+mask_Myocardium.*True_params(4,ind)+mask_Spleen.*True_params(5,ind)+mask_Pancreas.*True_params(6,ind)+mask_Kidney.*True_params(7,ind)+mask_Liver.*True_params(8,ind)+mask_Lung.*True_params(9,ind)+mask_Muscle.*True_params(10,ind)+mask_Bone.*True_params(11,ind)+mask_Lung_Tumor.*True_params(12,ind)+mask_Liver_Tumor.*True_params(13,ind)+mask_Brain_Tumor.*True_params(14,ind);
% Vd (6th column)
ind=6;
True_Vd=mask_BrainWM.*True_params(2,ind)+mask_Thyroid.*True_params(3,ind)+mask_Myocardium.*True_params(4,ind)+mask_Spleen.*True_params(5,ind)+mask_Pancreas.*True_params(6,ind)+mask_Kidney.*True_params(7,ind)+mask_Liver.*True_params(8,ind)+mask_Lung.*True_params(9,ind)+mask_Muscle.*True_params(10,ind)+mask_Bone.*True_params(11,ind)+mask_Lung_Tumor.*True_params(12,ind)+mask_Liver_Tumor.*True_params(13,ind)+mask_Brain_Tumor.*True_params(14,ind);
% K1 (1st column)
ind=1;
True_K1=mask_BrainWM.*True_params(2,ind)+mask_Thyroid.*True_params(3,ind)+mask_Myocardium.*True_params(4,ind)+mask_Spleen.*True_params(5,ind)+mask_Pancreas.*True_params(6,ind)+mask_Kidney.*True_params(7,ind)+mask_Liver.*True_params(8,ind)+mask_Lung.*True_params(9,ind)+mask_Muscle.*True_params(10,ind)+mask_Bone.*True_params(11,ind)+mask_Lung_Tumor.*True_params(12,ind)+mask_Liver_Tumor.*True_params(13,ind)+mask_Brain_Tumor.*True_params(14,ind);
% k2 (2nd column)
ind=2;
True_k2=mask_BrainWM.*True_params(2,ind)+mask_Thyroid.*True_params(3,ind)+mask_Myocardium.*True_params(4,ind)+mask_Spleen.*True_params(5,ind)+mask_Pancreas.*True_params(6,ind)+mask_Kidney.*True_params(7,ind)+mask_Liver.*True_params(8,ind)+mask_Lung.*True_params(9,ind)+mask_Muscle.*True_params(10,ind)+mask_Bone.*True_params(11,ind)+mask_Lung_Tumor.*True_params(12,ind)+mask_Liver_Tumor.*True_params(13,ind)+mask_Brain_Tumor.*True_params(14,ind);
% k3 (3rd column)
ind=3;
True_k3=mask_BrainWM.*True_params(2,ind)+mask_Thyroid.*True_params(3,ind)+mask_Myocardium.*True_params(4,ind)+mask_Spleen.*True_params(5,ind)+mask_Pancreas.*True_params(6,ind)+mask_Kidney.*True_params(7,ind)+mask_Liver.*True_params(8,ind)+mask_Lung.*True_params(9,ind)+mask_Muscle.*True_params(10,ind)+mask_Bone.*True_params(11,ind)+mask_Lung_Tumor.*True_params(12,ind)+mask_Liver_Tumor.*True_params(13,ind)+mask_Brain_Tumor.*True_params(14,ind);

save True_4D.mat True_4D
save True_Ki.mat True_Ki
save True_Vd.mat True_Vd
save True_K1.mat True_K1
save True_k2.mat True_k2
save True_k3.mat True_k3

clear





%% Converting MATLAB Array into DICOM
%load meta_PET.mat
%Vol=Act_XCAT{1,1};
%uint16_Vol=uint16( ( 66535/max(Vol(:)) )*Vol); % scaling into uint 16 image
%uid = dicomuid;

%for k=1:1:size(Vol,3)
%    meta.PatientID='XCAT_True';
%    meta.PatientName.FamilyName='XCAT_True';
%    meta.RescaleSlope= (max(Vol(:))/66535);
%    meta.RescaleIntercept=0;
%    meta.SeriesInstanceUID=uid;
%    meta.Modality='XCAT_True';
%    meta.SeriesDescription='XCAT_True';
%    meta.RescaleSlope= (max(Vol(:))/66535);
%    meta.RescaleIntercept=0;
%    meta.SliceThickness=1.6;
%    meta.PixelSpacing=[2;2];
%    meta.Width=220;
%    meta.Height=220;
%    meta.Rows=220;
%    meta.Columns=220;
%    meta.SliceLocation= 1.6*k;
%    meta.ImageIndex=k;
%    meta.NumberOfSlices=477;
%    meta.ImagePositionPatient=[-348.632812500000;-348.632812500000;meta.SliceLocation];
%    dicomwrite(uint16_Vol(:,:,k), "./XCAT_True_DCM/XCAT_True_" + num2str(k) + ".dcm",  meta, 'CreateMode', 'copy');
%end




