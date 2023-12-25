function chosen_params_WB=PCDE_WB_ACC_Version(Vol_Multi_WB_PCDE, Num_Passes,Num_Beds, PI_Times_PCDE, Denoising_Ind)

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

        %% Getting Bed_Vol_4D (denoised or not, [kBq/ml]), params_300_4D, Exp_params_4D to reduce comp. time
        t1=clock;
        [Bed_Vol_4D, params_300_4D, Exp_params_4D]=Accelerated_PCDE(permutes,Vol_Multi_WB_PCDE,PI_Times_PCDE, Num_Passes, Num_Beds, Denoising_Ind);
        t2=clock;
        elapse_4D_Vols_Bed=etime(t2,t1)/60/60 % Elapsed Time [hr]
        save("elapse_4D_Vols_Bed.mat",'elapse_4D_Vols_Bed');

        % Added code for calc. on a single coronal slice


        for i=1:1:size(Vol_Multi_WB_PCDE.Pass_1{b,1},1)
         %for i=136:1:136 % for XCAT test!
            for j=1:1:size(Vol_Multi_WB_PCDE.Pass_1{b,1},2)
                for k=1:1:size(Vol_Multi_WB_PCDE.Pass_1{b,1},3)
                    tic;
                    Meas_Cts_temp= transpose(squeeze(Bed_Vol_4D(i,j,k,:))); % [kBq/ml]
                    %% PCDE %%
                    
                    if Meas_Cts_temp ==0
                        chosen_params(i,j,k,:)=[0,0,0,0];
                    else
                        %% Accelerated Version
                        sort_ind=squeeze(params_300_4D(i,j,k,:));           
                        if sort_ind == 0
                            chosen_params(i,j,k,:)=[0,0,0,0];
                        else
                            switch Denoising_Ind
                                case 0 % X Denoising case
                                    chosen_params(i,j,k,:)=permutes(sort_ind(1),:);
                                case 1 
                                    Fitted_Noisy=Exp_New(transpose(squeeze(Exp_params_4D(i,j,k,:))),PI_Time_fine_temp);
                                    [ind_min]=Similarity_Measure3(permutes, sort_ind, Meas_Cts_temp, PI_Time_temp, PI_Time_fine_temp,Fitted_Noisy); % with GPUfit
                                    chosen_params(i,j,k,:)=permutes(ind_min,:);
                            end
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