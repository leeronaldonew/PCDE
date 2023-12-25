function [Bed_Vol_4D, PI_Times_Bed]=pre_GPU_PCDE(Vol_Multi_WB,PI_Times_PCDE, Num_Passes, Num_Beds, Bed_ind, Denoising_Ind)

for p=1:1:Num_Passes
    Names_Passes(p)="Pass_" +p;
end

for p=1:1:Num_Passes
    Bed_Vol_4D(:,:,:,p)=single(Vol_Multi_WB.(Names_Passes(p)){Bed_ind,1});
end

PI_Times_Bed=transpose(PI_Times_PCDE(:,Bed_ind));


%% Denoising with FLT
switch Denoising_Ind
    case 0 % X Denoising!
        % Nothing to do
    case   1 % Denoising with FLT
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












end