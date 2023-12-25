function [Gpu_Input_Bed,true_db_sub]=Gen_Input_GPU_PCDE(Bed_Vol_4D,PI_Times_Bed)

dims=size(Bed_Vol_4D);

Num_Vox=dims(1); % the # of voxels that you want to calculate simultaneously!
Num_Sub=dims(2)*dims(3);


% ind=(k-1)*dims(2)+j
for k=1:1:dims(3)
    for j=1:1:dims(2)
        Gpu_Input_Bed(:,:,((k-1)*dims(2))+j)=squeeze(Bed_Vol_4D(1:Num_Vox,j,k,:));
    end
end

[permutes,true_database]=make_database_NH_FDG_Full(PI_Times_Bed); 
permutes=single(permutes);
true_database=single(true_database);

Num_Comp=1000; % the # of parameter comb. that you want to compare with measured data simultaneously
db_ind_max=ceil(size(true_database,1)/Num_Comp);

for db_ind=1:1:db_ind_max
    if db_ind == db_ind_max
        true_db_sub(:,:,db_ind)=true_database(((db_ind-1)*Num_Comp)+1:end,:);
    else
        true_db_sub(:,:,db_ind)=true_database(((db_ind-1)*Num_Comp)+1:db_ind*Num_Comp,:);
    end
end



end