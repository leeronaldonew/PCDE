function []=Vol_to_DCM_Patlak(Vol,Vol2,Vol3,Vol4, Raw_Data_Multi_WB)
% Saving a 3D Volume in DCM files to be used for further analysis with other softwares
% Vol: K_i
% Vol2: V_d
% Vol3: K_i_RE[%]
% Vol4: V_d_RE[%]

SL=zeros(1,size(Vol,3));
for k=1:1:size(Vol,3)
    SL(k)=Raw_Data_Multi_WB.Pass_1{4, k};
end
[SL, SL_index]=sort(SL,'ascend');

file_names_num=[1:1:size(Vol,3)];
file_names_str=cell(1,size(Vol,3));
for k=1:1:size(Vol,3)
    file_names_str{1,k}=num2str(file_names_num(k));
end

Vol_size=size(Vol);
% for K_i
uint16_Vol=uint16( ( 66535/max(Vol(:)) )*Vol); % scaling into unit 16 image
f_waitbar = waitbar(0,'Please wait...', 'Name','Exporting K_i Volume into DICOM format');
for k=1:1:size(Vol,3)
    waitbar(k/Vol_size(3), f_waitbar, "Current Slice Index: " + num2str(k) + " / " + num2str(Vol_size(3)));
    Raw_Data_Multi_WB.Pass_1{1, SL_index(k)}.RescaleSlope= (max(Vol(:))/66535);
    Raw_Data_Multi_WB.Pass_1{1, SL_index(k)}.RescaleIntercept=0;
    Raw_Data_Multi_WB.Pass_1{1, SL_index(k)}.SeriesDescription='Parametric_Image_K_i';
    dicomwrite(uint16_Vol(:,:,k), "C:\Users\LEE\Documents\MATLAB\1_QURIT_Project\Kinetic_Modeling\Patlak_Results\K_i\" + file_names_str{1,k} + "_K_i.dcm", Raw_Data_Multi_WB.Pass_1{1, SL_index(k)} , 'CreateMode', 'Copy');
end

% for V_d
uint16_Vol2=uint16( ( 66535/max(Vol2(:)) )*Vol2);
f_waitbar = waitbar(0,'Please wait...', 'Name','Exporting V_d Volume into DICOM format');
for k=1:1:size(Vol2,3)
    waitbar(k/Vol_size(3), f_waitbar, "Current Slice Index: " + num2str(k) + " / " + num2str(Vol_size(3)));
    Raw_Data_Multi_WB.Pass_1{1, SL_index(k)}.RescaleSlope= (max(Vol2(:))/66535);
    Raw_Data_Multi_WB.Pass_1{1, SL_index(k)}.RescaleIntercept=0;
    Raw_Data_Multi_WB.Pass_1{1, SL_index(k)}.SeriesDescription='Parametric_Image_V_d';
    dicomwrite(uint16_Vol2(:,:,k), "C:\Users\LEE\Documents\MATLAB\1_QURIT_Project\Kinetic_Modeling\Patlak_Results\V_d\" + file_names_str{1,k} + "_V_d.dcm", Raw_Data_Multi_WB.Pass_1{1, SL_index(k)} , 'CreateMode', 'Copy');
end

% for K_i_RE
uint16_Vol3=uint16( ( 66535/max(Vol3(:)) )*Vol3); % scaling into unit 16 image
f_waitbar = waitbar(0,'Please wait...', 'Name','Exporting K_i_RE Volume into DICOM format');
for k=1:1:size(Vol3,3)
    waitbar(k/Vol_size(3), f_waitbar, "Current Slice Index: " + num2str(k) + " / " + num2str(Vol_size(3)));
    Raw_Data_Multi_WB.Pass_1{1, SL_index(k)}.RescaleSlope= (max(Vol3(:))/66535);
    Raw_Data_Multi_WB.Pass_1{1, SL_index(k)}.RescaleIntercept=0;
    Raw_Data_Multi_WB.Pass_1{1, SL_index(k)}.SeriesDescription='Parametric_Image_K_i_RE[%]';
    dicomwrite(uint16_Vol3(:,:,k), "C:\Users\LEE\Documents\MATLAB\1_QURIT_Project\Kinetic_Modeling\Patlak_Results\K_i\" + file_names_str{1,k} + "_K_i_RE.dcm", Raw_Data_Multi_WB.Pass_1{1, SL_index(k)} , 'CreateMode', 'Copy');
end

% for V_d_RE
uint16_Vol4=uint16( ( 66535/max(Vol4(:)) )*Vol4); % scaling into unit 16 image
f_waitbar = waitbar(0,'Please wait...', 'Name','Exporting V_d_RE Volume into DICOM format');
for k=1:1:size(Vol4,3)
    waitbar(k/Vol_size(3), f_waitbar, "Current Slice Index: " + num2str(k) + " / " + num2str(Vol_size(3)));
    Raw_Data_Multi_WB.Pass_1{1, SL_index(k)}.RescaleSlope= (max(Vol4(:))/66535);
    Raw_Data_Multi_WB.Pass_1{1, SL_index(k)}.RescaleIntercept=0;
    Raw_Data_Multi_WB.Pass_1{1, SL_index(k)}.SeriesDescription='Parametric_Image_V_d_RE[%]';
    dicomwrite(uint16_Vol4(:,:,k), "C:\Users\LEE\Documents\MATLAB\1_QURIT_Project\Kinetic_Modeling\Patlak_Results\V_d\" + file_names_str{1,k} + "_V_d_RE.dcm", Raw_Data_Multi_WB.Pass_1{1, SL_index(k)} , 'CreateMode', 'Copy');
end




end