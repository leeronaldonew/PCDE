function [Num_Passes, Num_Beds, PI_Times_PCDE, Vol_Multi_WB,WB_Vol]=Import_Dynamic_DCM_Multiple_XCAT() 
% Importing tool for the Dynamic DCM files (i.e., Dynamic data for Multiple Beds with Multiple Passes)
% Max. # of Beds importable: 10
% Max. # of Passes importable: infinite...

paths=uigetdir2(); % Importing Multiple Folders using the code downloaded from MathWorks File Exchange (i.e., not my code!)

for i=1:1:size(paths,2)
    files_temp{i,1}=dir(fullfile(paths{1,i},'*.DCM'));
    files_temp_cell{i,1}=struct2cell(files_temp{i,1});   
    for j=1:1:size(files_temp_cell{i,1},2)
        files{i,1}{1,j}=files_temp_cell{i,1}{1,j};
    end
end
Num_Passes=size(paths,2);
Num_Beds=6; % assuming it when using XCAT Phantom Images

for i=1:1:Num_Passes
    temp{1,i}=dicominfo(paths{1,i}+"\"+string(files{i,1})); % DCM Header
    temp{2,i}=flip(squeeze(dicomread(paths{1,i}+"\"+string(files{i,1}))),3); % DCM Volume
    temp{3,i}=temp{1,i}.AcquisitionTime; % getting Acquisition Time for sorting with time
    temp{4,i}=0; % getting Slice Location (Z-position)
    temp{5,i}=temp{1,i}.RescaleSlope;
    temp{6,i}=temp{1,i}.RescaleIntercept;
end


Start_Time=sscanf(temp{1, 1}.RadiopharmaceuticalInformationSequence.Item_1.RadiopharmaceuticalStartTime,'%2d%2d%f');
Start_Time_min=sum([60*60;60;1].*Start_Time)/60; % [min]

for i=1:1:Num_Passes
    Time_temp=sscanf(temp{3,i},'%2d%2d%f');
    Time_temp_min=sum([60*60;60;1].*Time_temp)/60; % [min]
    Times(1,i)=Time_temp_min; % PI Time [min]
end
[sort_Time, sort_ind]=sort(Times);

Index_Passes=[1:1:Num_Passes];
Names_Passes=["Pass_1", "Pass_2","Pass_3","Pass_4","Pass_5","Pass_6","Pass_7","Pass_8","Pass_9","Pass_10","Pass_11","Pass_12","Pass_13","Pass_14","Pass_15", "Pass_16","Pass_17","Pass_18","Pass_19","Pass_20"];
%Times_Passes=[10:5:105]; % upto 20 Passes, PI Time [min]

for p=1:1:Num_Passes
    Tot_Slices_WB=size(temp{2,sort_ind(p)},3);
    Num_Slices_per_Bed=floor(Tot_Slices_WB/Num_Beds); % Assuming 6 Beds!
    for b=1:1:Num_Beds % Assuming 6 Beds!     
        if b==Num_Beds
            Vol_Multi_WB.(Names_Passes(p)){b,1}=((temp{1, sort_ind(p)}.RescaleSlope.*double(temp{2,sort_ind(p)}(:,:,(Num_Slices_per_Bed*(b-1)+1):Tot_Slices_WB))) + temp{1,sort_ind(p)}.RescaleIntercept); %[Bq/ml]
            Vol_Multi_WB.(Names_Passes(p)){b,2}=temp{3,sort_ind(p)};
        else
            Vol_Multi_WB.(Names_Passes(p)){b,1}=((temp{1,sort_ind(p)}.RescaleSlope*double(temp{2,sort_ind(p)}(:,:,(Num_Slices_per_Bed*(b-1)+1):(Num_Slices_per_Bed*b)))) + temp{1,sort_ind(p)}.RescaleIntercept); % [Bq/ml]
            Vol_Multi_WB.(Names_Passes(p)){b,2}=temp{3,sort_ind(p)};
        end
    end
end

for p=1:1:Num_Passes
    for b=1:1:Num_Beds
        WB_Vol_temp_temp=Vol_Multi_WB.(Names_Passes(p)){b,1};
        if b==1
            WB_Vol_temp=WB_Vol_temp_temp;
        else     
            WB_Vol_temp=cat(3,WB_Vol_temp,WB_Vol_temp_temp);
        end
    end
    WB_Vol.(Names_Passes(p)){1,1}=WB_Vol_temp;
end


% PI_Times_PCDE
for p=1:1:Num_Passes
    for b=1:1:Num_Beds
        PI_Times_PCDE(p,b)=Times(sort_ind(p));
    end
end





end