function [Ind_300]=PCL_300_GPU(DB,Slice_TACs)

%PI_Time=[10:5:90];
%[permutes,true_data]=make_database_NH_FDG_Full(PI_Time); % k1:0.01~1, k2: 0.01~1, k3:0.01~0.5, k4=0


%% Seclting a 300 Parameter Combination List
%Num_Vox=size(Slice_TACs,1);
%Num_Time=size(Slice_Time,2);
%Num_Comb=size(DB,1);

%tic;
%[sort_val,sort_ind]= mink(sum( (DB-Voxel_TAC).^(2),2 ),300);
%toc;
coder.gpu.kernelfun();

Num_Vox=size(Slice_TACs,1);
Ind_300=coder.nullcopy( zeros(300,Num_Vox,'single') );

for v=1:1:Num_Vox
    if Slice_TACs(v,:) == 0
        Ind_300(:,v)=0;
    else
        [B,I] = gpucoder.sort( sum( (DB-Slice_TACs(v,:)).^(2),2 ) ); 
        Ind_300(:,v)=I(1:300);
    end
end


end