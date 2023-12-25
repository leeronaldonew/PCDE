function []=Vol_to_DCM(Vol, Raw_Data_Multi_WB, inp)

%prompt = {'Enter Series Description & Modality', 'Enter the "Unit" of this Parametric Volume (e.g., K1:[ml/min/g] or [1/min]), k2:[1/min], k3:[1/min], k4:[1/min], Ki:[ml/min/g] or [1/min], Vd:[ml/g] or [unitless])'};
%dlgtitle = 'Input';
%dims = [1 180];
%definput = inp;
%answer = inputdlg(prompt,dlgtitle,dims,definput);


uid = dicomuid;

%selpath = uigetdir(path, "Select a Folder to Save");

selpath="C:\Users\LEE\Documents\MATLAB\1_QURIT_Project\fLTlib_v1_2\1_Pure_Python\fLTlib\DICOM";

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

% for Saving
uint16_Vol=uint16( ( 66535/max(Vol(:)) )*Vol); % scaling into uint 16 image
f_waitbar = waitbar(0,'Please wait...', 'Name','Exporting the Volume into DICOM format');
for k=1:1:size(Vol,3)
    waitbar(k/Vol_size(3), f_waitbar, "Current Slice Index: " + num2str(k) + " / " + num2str(Vol_size(3)));
    Raw_Data_Multi_WB.Pass_1{1, SL_index(k)}.RescaleSlope= (max(Vol(:))/66535);
    Raw_Data_Multi_WB.Pass_1{1, SL_index(k)}.RescaleIntercept=0;
    Raw_Data_Multi_WB.Pass_1{1, SL_index(k)}.SeriesDescription=inp{1,1}; % Series Description
    
    Raw_Data_Multi_WB.Pass_1{1, SL_index(k)}.Modality=inp{1,1}; % Modality
    Raw_Data_Multi_WB.Pass_1{1, SL_index(k)}.SeriesInstanceUID=uid; % Unique Series Number

    Raw_Data_Multi_WB.Pass_1{1, SL_index(k)}.Units=inp{1,2}; % Unit of Parametric Volume

    dicomwrite(uint16_Vol(:,:,k), selpath + "/" + inp{1,1} + "_" + file_names_str{1,k} + ".dcm", Raw_Data_Multi_WB.Pass_1{1, SL_index(k)} , 'CreateMode', 'Copy');
end
close(f_waitbar);





end