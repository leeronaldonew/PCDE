function chosen_params_WB=PCDE_WB_GPU(PI_Time,kBq,Vol_Multi_WB_PCDE, Num_Passes,Num_Beds, PI_Times_PCDE, Denoising_Ind)

% PI_Time: PI_Time 4D
% kBq: kBq 4D

for p=1:1:Num_Passes
    Names_Passes(p)="Pass_" +p;
end

%% Denoising of WB
[DN_DB_3D,DN_kBq]=Denoising_FLT(kBq, Denoising_Ind); % It takes roughly 20 [min]

%% 1. GPU Fitting %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This Fitted Parameter will be used for the Calc. of Physical & Statistical Features!
t1=clock;
[Fitted_4D]=GPUfit_Exp(PI_Time,DN_kBq); % C-A*exp(-B*t) // Param1=A, Param2=B, Param3=C
t2=clock;
etime(t2,t1)/60 % Elapsed Time [min] ==> It takes roughly 6 [min]







for b=1:1:Num_Beds
    PI_Time_temp=transpose(PI_Times_PCDE(:,b));
    PI_Time_fine_temp=[min(PI_Time_temp):0.1:max(PI_Time_temp)];
    [permutes,true_database]=make_database_NH_FDG_Full(PI_Time_temp); % for Irreversible 2TCM with k4=0
    for k=1:1:size(Vol_Multi_WB_PCDE.Pass_1{b,1},3)
        Slice_TACs=zeros(size(Vol_Multi_WB_PCDE.Pass_1{b,1},1)*size(Vol_Multi_WB_PCDE.Pass_1{b,1},2),size(PI_Time_temp,2), 'single');
        for i=1:1:size(Vol_Multi_WB_PCDE.Pass_1{b,1},1)
            for j=1:1:size(Vol_Multi_WB_PCDE.Pass_1{b,1},2)

            end
        end
    end
end








    for b=1:1:Num_Beds
        PI_Time_temp=transpose(PI_Times_PCDE(:,b));
        PI_Time_fine_temp=[min(PI_Time_temp):0.1:max(PI_Time_temp)];
        [permutes,true_database]=make_database_NH_FDG_Full(PI_Time_temp); % for Irreversible 2TCM with k4=0
        for k=1:1:size(Vol_Multi_WB_PCDE.Pass_1{b,1},3)
            Slice_TACs=zeros(size(Vol_Multi_WB_PCDE.Pass_1{b,1},1)*size(Vol_Multi_WB_PCDE.Pass_1{b,1},2),size(PI_Time_temp,2), 'single');
            for i=1:1:size(Vol_Multi_WB_PCDE.Pass_1{b,1},1)
                for j=1:1:size(Vol_Multi_WB_PCDE.Pass_1{b,1},2)
                    for p=1:1:Num_Passes
                        Meas_Cts_temp(p)=Vol_Multi_WB_PCDE.(Names_Passes(p)){b,1}(i,j,k); % [kBq/ml]
                    end
                    %% Denoising %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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
                    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                    %% Denoised TAC
                    v=i+(size(Vol_Multi_WB_PCDE.Pass_1{b,1},2))*(j-1);
                    Slice_TACs(v,:)=Meas_Cts_temp;
                end
            end
            [sort_ind]=PCL_300_GPU_mex(DB,Slice_TACs);
            [ind_min]=Similarity_Measure_GPU(permutes, sort_ind, Meas_Cts_temp, PI_Time_temp, PI_Time_fine_temp);

        end
    end



















   



end