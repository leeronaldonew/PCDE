function chosen_params=select_min_distance_ind_for_loop(New_Num_Fit,X,Y)
%function chosen_params=select_min_distance_ind_for_loop(x_gpu,y_gpu,New_Num_Fit,New_Fit_Index,permutes,true_data)


for i=1:1:New_Num_Fit
    %ind=New_Fit_Index(i);
    %start_temp=Num_data_points*(i-1)+1;
    %end_temp=Num_data_points*i;
    %Y_data_repmat=single(repmat(transpose(y_gpu(start_temp:end_temp)),size(permutes,1),1));
    %[min_val,ind_min]=min( sum(abs(true_data-Y_data_repmat),2) );
    %[min_val,ind_min]=select_min_distance_ind(true_data,Y_data_repmat);

    [min_val,ind_min]=min( sum(abs(X-Y),2) );
    chosen_params_temp=single(zeros(i,4));
    
    if i==1
        %chosen_params=permutes(ind_min,:);
        chosen_params=single([i,i,i,i]);
    else
        %chosen_params=cat(1, chosen_params, permutes(ind_min,:))
        chosen_params_temp=cat(1, chosen_params, single([i,i,i,i]) );
        %chosen_params=[chosen_params;single([i,i,i,i])];
        chosen_params=chosen_params_temp;
    end

    

    
end



    
end