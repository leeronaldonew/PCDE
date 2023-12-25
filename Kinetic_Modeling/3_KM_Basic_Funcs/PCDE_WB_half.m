function chosen_params_WB=PCDE_WB_half(Num_Passes,Num_Beds, PI_Times_PCDE, Vol_Multi_WB, kBq, PI_Time)

    for p=1:1:Num_Passes
        Names_Passes(p)="Pass_" +p;
    end

    for b=1:1:Num_Beds
        tic;
        [permutes,true_database]=make_database(transpose(PI_Times_PCDE(:,b)));
        Tot_database{b,1}=true_database;
        toc;
    end
 
    
    %load kBq_half.mat;
    %load PI_Time_half.mat;

    for i=1:1:Num_Beds
        Size_Beds{i,1}=size(Vol_Multi_WB.Pass_1{i, 1}); % based on assumption that sizes of each bed are different each other but the trend remains same for all passes  
    end
    for i=1:1:Num_Beds
        Size_Beds_half{i,1}=ceil(Size_Beds{i,1}./2);
    end

    
    
    for i=51:1:51 % AmBF3_1(NET)==> 50, DCF_2(PSMA)==> 58, HTK_1(PSMA)==>58, DCF_3=> 70, HTK_2=> 57, AmBF3_2=> 51
        for j=1:1:size(kBq,2)
            for k=1:1:size(kBq,3)
                b=Get_b_from_k(k, Size_Beds_half);
                true_database=Tot_database{b,1};
                PI_Time_temp=transpose(PI_Times_PCDE(:,b));
                PI_Time_fine_temp=[min(PI_Time_temp):0.1:max(PI_Time_temp)];
                for p=1:1:Num_Passes
                    Meas_Cts_temp(p)=kBq(i,j,k,p);
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
                    chosen_params_WB(i,j,k,:)=[0,0,0,0];
                else 
                        
                [sort_val,sort_ind]=Comp_Ct_Database_Meas(true_database,Meas_Cts_temp);
                        
                [ind_min]=Similarity_Measure2(permutes, sort_ind, Meas_Cts_temp, PI_Time_temp, PI_Time_fine_temp);
                chosen_params_WB(i,j,k,:)=permutes(ind_min,:);
                end 
                toc;

            end
        end
    end

end