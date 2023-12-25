%% For NBias v.s. NSD curve %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Input :  columns (1st: Mean MSE, 2st: Mean_Pred) at a specific Noise Level
Input=0.0;
% True values

        %k_True=[0.09,0.25,0.22,0]; %1
        %k_True=[0.03,0.13,0.05,0]; %2
        %k_True=[0.13,0.63,0.19,0]; %3
        %k_True=[0.97,1,0.07,0]; %  %4
        %k_True=[0.82,1,0.19,0]; %  %5
        %k_True=[0.01,0.36,0.03,0]; %6
        %k_True=[0.41,0.51,0.01,0]; %7
        %k_True=[0.88,1,0.04,0]; %  %8
        %k_True=[0.36,1,0.08,0]; %  %9
        %k_True=[0.70,1,0.18,0]; %  %10
        %k_True=[0.03,0.32,0.05,0]; %11
        %k_True=[0.15,0.71,0.05,0]; %12
        %k_True=[0.86,0.98,0.01,0]; %13
        %k_True=[0.11,0.74,0.02,0]; %14

        k1_True=k_True(1);
        k2_True=k_True(2);
        k3_True=k_True(3);
        k4_True=k_True(4);
        Ki_True= (k_True(1)*k_True(3)) / (k_True(2)+k_True(3));
        Vd_True= (k_True(1)*k_True(2)) / ((k_True(2)+k_True(3))^2);
True=transpose([k_True,Ki_True,Vd_True,k_True,Ki_True,Vd_True,k_True,Ki_True,Vd_True,Ki_True,Vd_True]);

NBias=transpose([0:1:50]);
for i=1:1:size(Input,1)
    NSD_temp= real( (100/Input(i,2)).*( (Input(i,1)-((True(i,1)/100.*NBias).^(2))).^(0.5)) );
    if i==1
        NSD=NSD_temp;
    else
        NSD=cat(2,NSD,NSD_temp);
    end
    
    %NSD{i,1}(NSD{i,1}==0)=[];
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%