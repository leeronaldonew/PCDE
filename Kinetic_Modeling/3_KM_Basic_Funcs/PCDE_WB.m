function chosen_params_WB=PCDE_WB(Vol_Multi_WB_PCDE, Num_Passes,Num_Beds, PI_Times_PCDE, Denoising_Ind)

% Denoising_Ind=0 ==> X Denoising!
% Denoising_Ind=1 ==> Denoising with FLT

%load('Vol_Multi_WB_PCDE.mat'); % Unit: [kBq/ml] for Real Patient Data, [Varied] for XCAT Phantom Data

    for p=1:1:Num_Passes
        Names_Passes(p)="Pass_" +p;
    end

    for b=1:1:Num_Beds
        PI_Time_temp=transpose(PI_Times_PCDE(:,b));
        PI_Time_fine_temp=[min(PI_Time_temp):0.1:max(PI_Time_temp)];
        [permutes,true_database]=make_database_NH_FDG_Full(PI_Time_temp); % for Irreversible 2TCM with k4=0
        %[permutes,true_database]=make_database_Irreversible_k4_001(PI_Time_temp); % for Irreversible 2TCM with k4=0.001
        %[permutes,true_database]=make_database(PI_Time_temp); % making database
        %for i=90:1:155 % DCF_2(irreversible): 115
        %for i=1:1:256 % for all slices
        for i=1:1:size(Vol_Multi_WB_PCDE.Pass_1{b,1},1)
         %for i=136:1:136 % for XCAT test!
            for j=1:1:size(Vol_Multi_WB_PCDE.Pass_1{b,1},2)
                for k=1:1:size(Vol_Multi_WB_PCDE.Pass_1{b,1},3)
                    tic;
                    for p=1:1:Num_Passes
                        Meas_Cts_temp(p)=Vol_Multi_WB_PCDE.(Names_Passes(p)){b,1}(i,j,k); % [kBq/ml]
                    end

                    switch Denoising_Ind
                        case 0 % X Denoising!
                            % Nothing to do
                        case 1 % Denoising with FLT
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
                    end
                    %% PCDE %%
                    
                    if Meas_Cts_temp ==0
                        chosen_params(i,j,k,:)=[0,0,0,0];
                    else
                        %Y_data_repmat=repmat(Meas_Cts_temp, size(permutes,1),1);
                        %[sort_val,sort_ind]=sort( sum(abs(true_database-Y_data_repmat).^2 , 2) ); % 
                        %tic;
                        %% Original Code
                        [sort_val, sort_ind]=Comp_Ct_Database_Meas(true_database,Meas_Cts_temp);
                        switch Denoising_Ind
                            case 0 % X Denoising case
                                chosen_params(i,j,k,:)=permutes(sort_ind(1),:);
                            case 1 % Denoising with FLT case
                                %% Original code
                                [ind_min]=Similarity_Measure2(permutes, sort_ind, Meas_Cts_temp, PI_Time_temp, PI_Time_fine_temp); % original code
                                chosen_params(i,j,k,:)=permutes(ind_min,:);
                        end              
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