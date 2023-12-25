function [chosen_params]= Database_driven_parameter_choice(x_gpu, y_gpu,Num_data_points,New_Num_Fit,New_Fit_Index)

[permutes,true_data]=make_database(x_gpu(1:Num_data_points));
Y_data_repmat=single(zeros(size(permutes,1),Num_data_points));
for i=1:1:New_Num_Fit
    tic;
    ind=New_Fit_Index(i);
    start_temp=Num_data_points*(i-1)+1;
    end_temp=Num_data_points*i;
    Y_data_repmat=single(repmat(transpose(y_gpu(start_temp:end_temp)),size(permutes,1),1));
    [min_val,ind_min]=min( sum(abs(true_data-Y_data_repmat),2) );
    %[min_val,ind_min]=select_min_distance_ind(true_data,Y_data_repmat);
    if i==1
        chosen_params=permutes(ind_min,:);
    else
        chosen_params=cat(1, chosen_params, permutes(ind_min,:));
    end
    toc;
end



end