function Optim_Ks=PCDE_WB_Speedy(PI_Time,kBq,Vol_Multi_WB_PCDE, Num_Passes,Num_Beds, PI_Times_PCDE, Local_Estimates,Denoising_Ind)

% PI_Time: PI_Time 4D
% kBq: kBq 4D

for p=1:1:Num_Passes
    Names_Passes(p)="Pass_" +p;
end

for b=1:1:Num_Beds
    Names_Beds(b)="Bed_" +b;
end

Dims_WB=size(kBq);

%% Denoising of WB
[DN_DB_3D,DN_kBq]=Denoising_FLT(kBq, Denoising_Ind); % It takes roughly 20 [min]
clear kBq

%% 1. GPU Fitting %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This Fitted Parameter will be used for the Calc. of Physical & Statistical Features!
t1=clock;
[Fitted_4D]=GPUfit_Exp(PI_Time,DN_kBq); % C-A*exp(-B*t) // Param1=A, Param2=B, Param3=C
t2=clock;
etime(t2,t1)/60 % Elapsed Time [min] ==> It takes roughly 6 [min]
clear PI_Time DN_kBq

%% Dimensions & Time info. for each Bed
Time_intv=0.1; % [min]
PI_Times_PCDE=single(PI_Times_PCDE);
for b=1:1:size(Vol_Multi_WB_PCDE.Pass_1,1)
    temp(b,1)=size([min(PI_Times_PCDE(:,b)):Time_intv:max(PI_Times_PCDE(:,b))],2);
end
Num=min(temp);
for b=1:1:size(Vol_Multi_WB_PCDE.Pass_1,1)
    PI_Time_Meas(b,:)=transpose(PI_Times_PCDE(:,b));
    temp2=[min(PI_Times_PCDE(:,b)):Time_intv:max(PI_Times_PCDE(:,b))];
    PI_Time_fine(b,:)=temp2(1:Num);
    Dims_Bed(b,:)=single(size(Vol_Multi_WB_PCDE.Pass_1{b,1}));  
    Num_origin=size(PI_Time_fine(1,:),2);
end
clear Vol_Multi_WB_PCDE
%Num_Beds=size(Dims_Bed,1);



%% PCDE
temp_k=[0;cumsum(Dims_Bed(:,3))];
f_waitbar = waitbar(0,'Please wait...', 'Name','Performing PCDE');
for b=1:1:Num_Beds
    [permutes,DB]=make_database_NH_FDG_Full(PI_Time_Meas(b,:)); % for Irreversible 2TCM with k4=0
    Num_Vox_row=Dims_Bed(b,1);
    for k=temp_k(b)+1:1:temp_k(b+1) % Assumption: Foot-First Scanning (FFS)  
        waitbar( k/max(temp_k), f_waitbar, "Bed: " + num2str(b) + " / " + num2str(Num_Beds) + ", " + "Slice: " + num2str(k) + " / " + num2str(temp_k(b+1)) );
        t1=clock;
         
        if DN_DB_3D(:,:,k)==0
            Optim_K1=zeros(Dims_WB(1)*Dims_WB(2),1,'single');
            Optim_K2=zeros(Dims_WB(1)*Dims_WB(2),1,'single');
            Optim_K3=zeros(Dims_WB(1)*Dims_WB(2),1,'single');
            Optim_K4=zeros(Dims_WB(1)*Dims_WB(2),1,'single');
        else
            tic;
            [Ind_300]=PCL_300_GPU_mex(DB,DN_DB_3D(:,:,k)); % 33 [sec]
            toc;
            tic;
            %[Val_10,Ind_10]=Rank_AUC_Speedy_Slice(k,Num_Vox_row,Fitted_4D,permutes,PI_Time_fine(b,:),Time_intv,Ind_300,Local_Estimates); % 63 [sec]
            [Val_10,Ind_10]=Rank_AUC_GPU_Slice(k,Num_Vox_row,Fitted_4D,permutes,PI_Time_fine(b,:),Time_intv,Ind_300,single(Local_Estimates)); % 23 [sec]
            toc;
            tic;
            [Top_10]=Conv_Rel_to_Abs_Ind(Ind_300,Ind_10); % 0.07 [sec]
            toc;
            tic;
            [DB_10]=Gen_Slice_DB_10(Top_10,permutes,PI_Time_fine(b,:),Local_Estimates); % 1.4 [sec]
            toc;
            tic;
            [Slice_FTACs]=Gen_Slice_FTACs(k,Fitted_4D,PI_Time_fine(b,:)); % 0.06 [sec]
            toc;
            tic;
            [Val_ROA,Ind_ROA]=Rank_AUC_Overlapped_Speedy(DB_10,Slice_FTACs,Time_intv); % 0.8 [sec]
            toc;
            tic;
            [Val_Ct,Ind_Ct]=Rank_Ct_Speedy(DB_10,Slice_FTACs,Time_intv); % 0.8 [sec]
            toc;
            tic;
            [Val_Sl,Ind_Sl,Val_Acc,Ind_Acc]=Rank_Slope_Acc_Speedy(DB_10,Slice_FTACs,Time_intv); % 3.4 [sec]
            toc;
            tic;
            [Val_Con_Ct,Ind_Con_Ct,Val_Con_Sl,Ind_Con_Sl]=Rank_Connect_Speedy(DB_10,Slice_FTACs,Time_intv); % 0.4 [sec]
            toc;
            tic;
            [Val_MI,Ind_MI]=Rank_MI_Speedy(DB_10,Slice_FTACs,Time_intv); % 20 [sec]
            toc;
            % Calc. of Total Score & Finding Optimal Ks
            tic;
            [Initial_List]=Gen_Initial_List(Ind_10); % 0.06 [sec]
            [Vals,Inds]=Gen_Total_Ind_Val(Initial_List,Ind_ROA,Ind_Ct,Ind_Sl,Ind_Acc,Ind_Con_Ct,Ind_Con_Sl,Ind_MI,Val_10,Val_ROA,Val_Ct,Val_Sl,Val_Acc,Val_Con_Ct,Val_Con_Sl,Val_MI);
            toc;
            tic;
            [Optim_K1,Optim_K2,Optim_K3,Optim_K4]=Calc_ToT_Score_Rapid(Vals,Inds,permutes,Top_10); % 4.6 [sec]
            toc;
        end

        tic;
        if k==1
            K1=Optim_K1;
            K2=Optim_K2;
            K3=Optim_K3;
            K4=Optim_K4;
        else
            K1=cat(1,K1,Optim_K1);
            K2=cat(1,K2,Optim_K2);
            K3=cat(1,K3,Optim_K3);
            K4=cat(1,K4,Optim_K4);
        end
        toc;   
        k
        t2=clock;
        etime(t2,t1)/60 % [min] It takes roughly 2 [min] per Slice
    end  
end
close(f_waitbar);

Optim_Ks=zeros(Dims_WB(1),Dims_WB(2),Dims_WB(3),4,'single');
Optim_Ks(:,:,:,1)=reshape(K1,Dims_WB(1),Dims_WB(2),Dims_WB(3));
Optim_Ks(:,:,:,2)=reshape(K2,Dims_WB(1),Dims_WB(2),Dims_WB(3));
Optim_Ks(:,:,:,3)=reshape(K3,Dims_WB(1),Dims_WB(2),Dims_WB(3));
Optim_Ks(:,:,:,4)=reshape(K4,Dims_WB(1),Dims_WB(2),Dims_WB(3));
























   



end