function [Vol,Raw_Data,T,Num_T]=Import_Dynamic_DCM_Single() 
% Importing tool for the Dynamic DCM files (i.e., Dynamic data for a Single Bed)


% for Testing dicomreadVolume
%path=uigetdir;
%[V,spatial,dim] = dicomreadVolume(path);
%Vol=squeeze(V);
path=uigetdir();
files_temp=dir(fullfile(path,'*.DCM'));
files_temp_cell=struct2cell(files_temp);
for i=1:1:size(files_temp_cell,2)
    files{1,i}=files_temp_cell{1,i};
end


%[files, path, index]=uigetfile('*.dcm', 'MultiSelect', 'on');
Num_files=size(files,2); % the # of loaded DCM images (i.e., PET images)
% Loading DCM files
for i=1:1:Num_files
temp{1,i}=dicominfo(path+"\"+string(files{1,i}));
temp{2,i}=dicomread(path+"\"+string(files{1,i}));
temp{3,i}=temp{1,i}.AcquisitionTime; % getting Acquisition Time for sorting with time
temp{4,i}=temp{1,i}.SliceLocation; % getting Slice Location (Z-position)
temp{5,i}=temp{1,i}.RescaleSlope;
temp{6,i}=temp{1,i}.RescaleIntercept;
end
% Grouping/Sorting the DCM images with Time
for i=1:1:Num_files
temp_times(1,i)=str2num(temp{3,i});
end
Times=unique(temp_times); % Acquisition Times
Num_Times=size(Times,2); % the # of Acquisition Times

for i=1:1:Num_Times
    for j=1:1:Num_files
        if Times(1,i) == str2num(temp{3,j})
           temp_sort_time(i,j)=j;
        end
    end
end
% Sorting the DCM images with Slice Location
for i=1:1:Num_Times
    temp_index_SL{i,1}=nonzeros(temp_sort_time(i,:));
end
for i=1:1:Num_Times
    for j=1:1:size(temp_index_SL{i,1},1)
        temp_index_SL{i,1}(j,2)=temp{4,temp_index_SL{i,1}(j,1)};
    end 
end
for i=1:1:Num_Times
    clear temp_ranked_SL temp_ranked_index;
    [temp_ranked_SL, temp_ranked_index]=sort(temp_index_SL{i,1}(:,2), 'ascend'); 
    for j=1:1:size(temp_index_SL{i,1}, 1)
        temp_index_SL{i,1}(j,3)=temp_index_SL{i,1}(temp_ranked_index(j,1), 1);
        temp_index_SL{i,1}(j,4)=temp_ranked_SL(j,1);
    end  
end
% Getting Volume images for each time
Vol_PET=cell(Num_Times,1);
for i=1:1:Num_Times
    Vol_PET{i,2}=Times(1,i);
end
for i=1:1:Num_Times
    for j=1:1:size(temp_index_SL{i,1},1) % the # of slices for a single time
        Vol_PET{i,1}(:,:,j)= ( (temp{5,temp_index_SL{i,1}(j,3)}) * double(temp{2, temp_index_SL{i,1}(j,3)}) ) + (temp{6, temp_index_SL{i,1}(j,3)}) ; % Real value [Bq/ml] = (Rescale_Slope*Voxel_value)+Rescale_Intercept; 
    end
end
  
%sliceViewer(Vol_PET{1,1}); % for testing
%volumeViewer(Vol_PET{1,1},Vol_PET{2,1});
%volumeViewer(Vol_PET{1,1});
%volumeViewer(Vol_PET{2,1});
%volumeViewer(Vol_PET{3,1});
%volumeViewer(Vol_PET{4,1});
%volumeViewer(Vol_PET{5,1});
%volumeViewer(Vol_PET{6,1});

% for Making a volume for whole time
%for i=1:1:Num_Times
%    Num_Slices_for_each_time(1,i)= size(Vol_PET{i,1}, 3);
%end
%Cumul_Sum_Num_Slices_for_each_time=cumsum(Num_Slices_for_each_time);
%for t=1:1:Num_Times
%    for i=1:1:size(Vol_PET{t,1},3)
%        if t==1
%            Vol_PET_only(:,:,i)=Vol_PET{t,1}(:,:,i); 
%        else
%            i_star=i+Cumul_Sum_Num_Slices_for_each_time(1,t-1);
%            Vol_PET_only(:,:,i_star)=Vol_PET{t,1}(:,:,i);
%        end
%    end
%end
%volumeViewer(Vol_PET_only);
%volumeViewer(Vol_PET{10,1});


Vol=Vol_PET; % returning
Raw_Data=temp; % returning
T=Times; % returning
Num_T=Num_Times; % returning

end