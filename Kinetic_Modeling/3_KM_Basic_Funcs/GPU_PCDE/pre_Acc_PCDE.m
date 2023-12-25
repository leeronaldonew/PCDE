function [Bed_Vol_4D, Bed_PI_Time_Vol_4D, PI_Times_Bed]=pre_Acc_PCDE(Vol_Multi_WB,PI_Times_PCDE, Num_Passes, Num_Beds, Bed_ind, Denoising_Ind)

for p=1:1:Num_Passes
    Names_Passes(p)="Pass_" +p;
end

for p=1:1:Num_Passes
    Bed_Vol_4D(:,:,:,p)=single(Vol_Multi_WB.(Names_Passes(p)){Bed_ind,1});
end

PI_Times_Bed=transpose(PI_Times_PCDE(:,Bed_ind));


%% Denoising if Denoising_Ind==1
switch Denoising_Ind
    case 0 % X Denoising!
            % Nothing to do
    case 1 % Denoising with FLT
        Bed_Vol_4D_Deno=zeros(size(Bed_Vol_4D), 'single');
        for k=1:1:size(Bed_Vol_4D,3)
            for j=1:1:size(Bed_Vol_4D,2)
                for i=1:1:size(Bed_Vol_4D,1)
                    tic;
                    Meas_Cts_temp=transpose(squeeze(Bed_Vol_4D(i,j,k,:)));
                    if Meas_Cts_temp==0
                        Bed_Vol_4D_Deno(i,j,k,:)=Meas_Cts_temp;
                    else
                        %% Denoising with FLT
                        nl=10; % Legendre Polynomial's max order
                        kmax=3; % cut-off order for denoising
                        Num_p=size(PI_Times_Bed,2); % # of data points
                        y_py=py.numpy.array(transpose(Meas_Cts_temp));
                        FLT_results_py= py.LegendrePolynomials.LT(y_py,py.numpy.array(nl));	% FLT 
                        FLT_results=double(FLT_results_py);
                        FLT_results_truncated=FLT_results(1,1:kmax);
                        FLT_results_truncated_py=py.numpy.array(FLT_results_truncated);
                        iFLT_results_py=py.LegendrePolynomials.iLT(FLT_results_truncated_py,py.numpy.array(Num_p)); % iFLT
                        iFLT_results=transpose(double(iFLT_results_py));
                        Meas_Cts_temp=transpose(iFLT_results);
                        Meas_Cts_temp(Meas_Cts_temp < 0)=0; % to remove negative values
                        Bed_Vol_4D_Deno(i,j,k,:)=Meas_Cts_temp;
                    end
                    toc;
                end
            end
        end
        Bed_Vol_4D=Bed_Vol_4D_Deno;
    end


%% Malking Bed_PI_Time_Vol_4D
dims=size(Bed_Vol_4D);

Bed_PI_Time_Vol_4D=single(zeros(dims(1),dims(2),dims(3),Num_Passes)); 
Bed_PI_Time_Vol_4D_temp=single(zeros(dims(1),dims(2),dims(3))); 

for p=1:1:Num_Passes
    Bed_PI_Time_Vol_4D_temp(:,:,:)=single(PI_Times_Bed(p));
    if p==1
        Bed_PI_Time_Vol_4D=Bed_PI_Time_Vol_4D_temp;
    else
        Bed_PI_Time_Vol_4D=cat(4, Bed_PI_Time_Vol_4D, Bed_PI_Time_Vol_4D_temp);
    end
end


end