function [I]=PCL_300(DB,Voxel_TAC)

%PI_Time=[10:5:90];
%[permutes,true_data]=make_database_NH_FDG_Full(PI_Time); % k1:0.01~1, k2: 0.01~1, k3:0.01~0.5, k4=0


%% Seclting a 300 Parameter Combination List
%Num_Vox=size(Slice_TACs,1);
%Num_Time=size(Slice_Time,2);
%Num_Comb=size(DB,1);

%tic;
%[sort_val,sort_ind]= mink(sum( (DB-Voxel_TAC).^(2),2 ),300);
%toc;

[B,I] = gpucoder.sort( sum( (DB-Voxel_TAC).^(2),2 ) );


end