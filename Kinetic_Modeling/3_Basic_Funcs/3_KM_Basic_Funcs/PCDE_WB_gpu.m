function chosen_params_WB=PCDE_WB_gpu(Num_Beds,Num_Passes, PI_Times_PCDE, Vol_Multi_WB)

    for p=1:1:Num_Passes
        Names_Passes(p)="Pass_" +p;
    end

    for b=1:1:Num_Beds
        [permutes,true_database]=make_database(transpose(PI_Times_PCDE(:,b)));
        Tot_database{b,1}=true_database;
    end

    load kBq_half.mat;
    load PI_Time_half.mat;

    for i=1:1:Num_Beds
        Size_Beds{i,1}=size(Vol_Multi_WB.Pass_1{i, 1}); % based on assumption that sizes of each bed are different each other but the trend remains same for all passes  
    end
    
    b=Get_b_from_k(k, Size_Beds);

    [sort_val,sort_ind]=sort(PI_Time(1,1,:,3));








    for b=1:1:Num_Beds
        PI_Time_temp=transpose(PI_Times_PCDE(:,b));
        PI_Time_fine_temp=[min(PI_Time_temp):0.1:max(PI_Time_temp)];
        %[permutes,true_database]=make_database_NH_FDG_Full(PI_Time_temp); % making database
        [permutes,true_database]=make_database(PI_Time_temp); % making database
        for i=128:1:128
            for j=1:1:size(Vol_Multi_WB.Pass_1{b,1},2)
                for k=1:1:size(Vol_Multi_WB.Pass_1{b,1},3)
                    for p=1:1:Num_Passes
                        Meas_Cts_temp(p)=0.001.*Vol_Multi_WB.(Names_Passes(p)){b,1}(i,j,k); % [kBq/ml]
                    end
                    %% Denoising with FLT
                    nl=10; % Legendre Polynomial's max order
                    kmax=3; % cut-off order for denoising
                    Num_p=size(PI_Time_temp,2); % # of data points
                    y_py=py.numpy.array(transpose(Meas_Cts_temp));
                    FLT_results_py= py.LegendrePolynomials.LT(y_py,py.numpy.array(nl));	% FLT 
                    FLT_results=double(FLT_results_py);
                    FLT_results_truncated=FLT_results(1,1:kmax);
                    FLT_results_truncated_py=py.numpy.array(FLT_results_truncated);
                    iFLT_results_py=py.LegendrePolynomials.iLT(FLT_results_truncated_py,py.numpy.array(Num_p)); % iFLT
                    iFLT_results=transpose(double(iFLT_results_py));
                    Meas_Cts_temp=transpose(iFLT_results);
                    Meas_Cts_temp(Meas_Cts_temp < 0)=0; % to remove negative values


                    %% PCDE %%
                    tic;
                    if Meas_Cts_temp ==0
                        chosen_params(i,j,k,:)=[0,0,0,0];
                    else 
                        
                        [sort_val,sort_ind]=Comp_Ct_Database_Meas_gpu(true_database,Meas_Cts_temp);
                        
                        [ind_min]=Similarity_Measure2(permutes, sort_ind, Meas_Cts_temp, PI_Time_temp, PI_Time_fine_temp);
                        chosen_params(i,j,k,:)=permutes(ind_min,:);
                    end 
                    toc;
                end
            end
        end

        if b==1
            chosen_params_WB=chosen_params;
        else
            chosen_params_WB=cat(3, chosen_params_WB,chosen_params);
        end
    end
end