function [Num_Passes,Num_Beds,Vol_WB,Vol,Raw_Data,T,Num_T]=Import_Dynamic_DCM_Multiple() 
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
Index_Passes=[1:1:Num_Passes];
Names_Passes=["Pass_"+Index_Passes(1,i),"Vol_Pass", "Raw_Pass", "Times_Pass", "Num_Times_Pass"];

for i=1:1:Num_Passes
    %[files, path, index]=uigetfile('*.dcm', 'MultiSelect', 'on');
    Num_files{i,1}=size(files{i,1},2); % the # of loaded DCM images (i.e., PET images)
    % Loading DCM files
    for j=1:1:Num_files{i,1}
        temp.("Pass_"+Index_Passes(1,i)){1,j}=dicominfo(paths{1,i}+"\"+string(files{i,1}{1,j}));
        temp.("Pass_"+Index_Passes(1,i)){2,j}=dicomread(paths{1,i}+"\"+string(files{i,1}{1,j}));
        temp.("Pass_"+Index_Passes(1,i)){3,j}=temp.("Pass_"+Index_Passes(1,i)){1,j}.AcquisitionTime; % getting Acquisition Time for sorting with time
        temp.("Pass_"+Index_Passes(1,i)){4,j}=temp.("Pass_"+Index_Passes(1,i)){1,j}.SliceLocation; % getting Slice Location (Z-position)
        temp.("Pass_"+Index_Passes(1,i)){5,j}=temp.("Pass_"+Index_Passes(1,i)){1,j}.RescaleSlope;
        temp.("Pass_"+Index_Passes(1,i)){6,j}=temp.("Pass_"+Index_Passes(1,i)){1,j}.RescaleIntercept;
    end
    % Grouping/Sorting the DCM images with Time
    for j=1:1:Num_files{i,1}
        temp_times.("Pass_"+Index_Passes(1,i))(1,j)=str2num(temp.("Pass_"+Index_Passes(1,i)){3,j});
    end
    Times.("Pass_"+Index_Passes(1,i))=unique(temp_times.("Pass_"+Index_Passes(1,i))); % Acquisition Times
    Num_Times.("Pass_"+Index_Passes(1,i))=size(Times.("Pass_"+Index_Passes(1,i)),2); % the # of Acquisition Times

    for j=1:1:Num_Times.("Pass_"+Index_Passes(1,i))
        for k=1:1:Num_files{i,1}
            if Times.("Pass_"+Index_Passes(1,i))(1,j) == str2num(temp.("Pass_"+Index_Passes(1,i)){3,k})
                temp_sort_time.("Pass_"+Index_Passes(1,i))(j,k)=k;
            end
        end
    end

    % Sorting the DCM images with Slice Location
    for j=1:1:Num_Times.("Pass_"+Index_Passes(1,i))
        temp_index_SL.("Pass_"+Index_Passes(1,i)){j,1}=nonzeros(temp_sort_time.("Pass_"+Index_Passes(1,i))(j,:));
    end
    for j=1:1:Num_Times.("Pass_"+Index_Passes(1,i))
        for k=1:1:size(temp_index_SL.("Pass_"+Index_Passes(1,i)){j,1},1)
            temp_index_SL.("Pass_"+Index_Passes(1,i)){j,1}(k,2)=temp.("Pass_"+Index_Passes(1,i)){4,temp_index_SL.("Pass_"+Index_Passes(1,i)){j,1}(k,1)};
        end 
    end
    for j=1:1:Num_Times.("Pass_"+Index_Passes(1,i))
        clear temp_ranked_SL temp_ranked_index;
        [temp_ranked_SL, temp_ranked_index]=sort(temp_index_SL.("Pass_"+Index_Passes(1,i)){j,1}(:,2), 'ascend'); 
        for k=1:1:size(temp_index_SL.("Pass_"+Index_Passes(1,i)){j,1}, 1)
            temp_index_SL.("Pass_"+Index_Passes(1,i)){j,1}(k,3)=temp_index_SL.("Pass_"+Index_Passes(1,i)){j,1}(temp_ranked_index(k,1), 1);
            temp_index_SL.("Pass_"+Index_Passes(1,i)){j,1}(k,4)=temp_ranked_SL(k,1);
        end  
    end
    % Getting Volume images for each time
    Vol_PET.("Pass_"+Index_Passes(1,i))=cell(Num_Times.("Pass_"+Index_Passes(1,i)),1);
    for j=1:1:Num_Times.("Pass_"+Index_Passes(1,i))
        Vol_PET.("Pass_"+Index_Passes(1,i)){j,2}=Times.("Pass_"+Index_Passes(1,i))(1,j);
    end
    for j=1:1:Num_Times.("Pass_"+Index_Passes(1,i))
        for k=1:1:size(temp_index_SL.("Pass_"+Index_Passes(1,i)){j,1},1) % the # of slices for a single time
            Vol_PET.("Pass_"+Index_Passes(1,i)){j,1}(:,:,k)= ( (temp.("Pass_"+Index_Passes(1,i)){5,temp_index_SL.("Pass_"+Index_Passes(1,i)){j,1}(k,3)}) * double(temp.("Pass_"+Index_Passes(1,i)){2, temp_index_SL.("Pass_"+Index_Passes(1,i)){j,1}(k,3)}) ) + (temp.("Pass_"+Index_Passes(1,i)){6, temp_index_SL.("Pass_"+Index_Passes(1,i)){j,1}(k,3)}) ; % Real value [Bq/ml] = (Rescale_Slope*Voxel_value)+Rescale_Intercept; 
        end
    end

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Generating WB Volume Data for testing!
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i=1:1:Num_Passes
    Names_Passes(i)="Pass_"+Index_Passes(1,i);
end
for i=1:1:Num_Passes
    for j=1:1:Num_Times.(Names_Passes(i))
        sum_temp.(Names_Passes(i))(1,j)=size(Vol_PET.(Names_Passes(i)){j,1}, 3);
    end
    Tot_Num_Slice.(Names_Passes(i))=sum(sum_temp.(Names_Passes(i)));
    Cumul_Num_Slice.(Names_Passes(i))=cumsum(sum_temp.(Names_Passes(i)));
end
for i=1:1:Num_Passes
    for j=1:1:size(Vol_PET.(Names_Passes(i)), 1)
        if j==1
            for k=1:1:size(Vol_PET.(Names_Passes(i)){1,1},3)
                Vol_WB.(Names_Passes(i)){1,1}(:,:,k)=Vol_PET.(Names_Passes(i)){1,1}(:,:,k);
            end
        else
            for k=Cumul_Num_Slice.(Names_Passes(i))(1,j-1)+1:1:Cumul_Num_Slice.(Names_Passes(i))(1,j)
               Vol_WB.(Names_Passes(i)){1,1}(:,:,k)=Vol_PET.(Names_Passes(i)){j,1}(:,:,k-Cumul_Num_Slice.(Names_Passes(i))(1,j-1));
            end
        end
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Testing
%volumeViewer(Vol_WB.Pass_1{1,1});
%volumeViewer(Vol_WB.Pass_2{1,1});

% Sorting the Pass # with Time
for i=1:1:Num_Passes
    Names_Passes(i)="Pass_"+Index_Passes(1,i);
end
for p=1:1:Num_Passes
    Pass_earliest_time(p,1)=Times.(Names_Passes(p))(1,1);
end
[Sorted_Pass_earliest_time, Index_Pass_earliest_time]=sort(Pass_earliest_time, 'ascend');
for p=1:1:Num_Passes
    Vol_WB_New.(Names_Passes(p))=Vol_WB.( Names_Passes(Index_Pass_earliest_time(p)) );
    Vol_PET_New.(Names_Passes(p))=Vol_PET.( Names_Passes(Index_Pass_earliest_time(p)) );
    temp_New.(Names_Passes(p))=temp.( Names_Passes(Index_Pass_earliest_time(p)) );
    Times_New.(Names_Passes(p))=Times.( Names_Passes(Index_Pass_earliest_time(p)) );
    Num_Times_New.(Names_Passes(p))=Num_Times.( Names_Passes(Index_Pass_earliest_time(p)) );
end

% for Returning!
Num_Beds=size(Vol_PET.Pass_1,1); % for returning
Vol_WB=Vol_WB_New; % for returning
Vol=Vol_PET_New; % for returning
Raw_Data=temp_New; % for returning
T=Times_New; % for returning
Num_T=Num_Times_New; % for returning

% Saving
%save Num_Passes.mat Num_Passes;
%save Num_Beds.mat Num_Beds;
%save Vol_WB.mat Vol_WB;
%save Vol_Multi_WB.mat Vol;
%save Raw_Data_Multi_WB.mat Raw_Data;
%save Times_Multi_WB.mat T;
%save Num_Times_Multi_WB.mat Num_T;

% saving Vol_WB for future usage
%save("Vol_WB.mat",'Vol_WB');


end