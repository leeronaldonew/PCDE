function [x_gpu, y_gpu, initial_params, constraints]=Conv_GPUfit_Input(x_gpu, y_gpu, initial_params, constraints, WB_mask_vector,Num_Passes,Size_WB)

WB_mask_temp=repmat(WB_mask_vector, Num_Passes,1);
y_gpu=y_gpu.*WB_mask_temp; % for y_gpu
WB_mask_temp=repmat(WB_mask_vector, size(initial_params,1),1);
initial_params=initial_params.*WB_mask_temp; % for initial_params

end