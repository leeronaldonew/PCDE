function [params_s_sum_GPU]=GPU_Sel_300(Gpu_Input_Bed_r,true_db_sub_s,s)
coder.gpu.kernelfun();

Num_Vox=size(Gpu_Input_Bed_r,1); % # of voxels that you want to calculate simultaneously!
Num_Comp=size(true_db_sub_s,1);

params_s_sum_GPU=zeros(300,2*Num_Vox, 'half');
sort_sub=zeros(300,2,'half');


for v=1:1:Num_Vox
    [sort_val_temp,sort_ind_temp] = sortrows(real(sum( (true_db_sub_s-Gpu_Input_Bed_r(v,:)).^(2),2)));
    sort_sub=[sort_ind_temp(1:300)+((s-1).*Num_Comp), sort_val_temp(1:300)];
    for i=1:1:300
        for j=1:1:2
            params_s_sum_GPU(i,(v-1)*2+j)=sort_sub(i,j);
        end
    end       
end 



 





end