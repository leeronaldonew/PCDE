function [Val_10,Ind_10]=Rank_AUC_GPU_Slice(k,Num_Vox_row,Fitted_4D,permutes,PI_Time_fine,Time_intv,Ind_300,Local_Estimates)
%%%% Rank_AUC_GPU per Slice %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%coder.gpu.kenelfun();


%Ind_10=zeros(10,size(Fitted_4D,2),Num_Vox_row,'single');
%Val_10=zeros(10,size(Fitted_4D,2),Num_Vox_row,'single');
Fitted_4D_Slice=squeeze(Fitted_4D(:,:,k,:));
Row_DB_300_zeros=zeros(300*Num_Vox_row,size(PI_Time_fine,2),'single');
I_zeros=zeros(10,Num_Vox_row,'single');
V_zeros=zeros(10,Num_Vox_row,'single');
for r=1:1:size(Fitted_4D,2)  
    %tic;
    [Row_FTACs]=Gen_Row_FTACs(r,Fitted_4D_Slice,PI_Time_fine); % 0.005 [sec]
    %toc;
    if Row_FTACs ==0
        Row_DB_300=Row_DB_300_zeros;
        I=I_zeros;
        V=V_zeros;
    else
        %tic;
        [Row_DB_300]=Gen_Row_DB(r,Num_Vox_row,Ind_300,permutes,PI_Time_fine,Local_Estimates); % 0.42 [sec]
        %toc;
        %tic;
        [V,I]=Rank_AUC_Speedy(Row_DB_300,Row_FTACs,Time_intv); % 0.02 [sec]
        %toc;
    end
    if r==1
        Ind_10=I;
        Val_10=V;
    else
        Ind_10=cat(2,Ind_10,I);
        Val_10=cat(2,Val_10,V);
    end
    %Ind_10(:,:,r)=I;
    %Val_10(:,:,r)=V;
end
%Ind_10=reshape(Ind_10,10,size(Fitted_4D,2)*Num_Vox_row);
%Val_10=reshape(Val_10,10,size(Fitted_4D,2)*Num_Vox_row);


end