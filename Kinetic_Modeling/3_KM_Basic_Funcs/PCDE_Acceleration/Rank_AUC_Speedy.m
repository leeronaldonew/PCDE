function [Val_10,Ind_10]=Rank_AUC_Speedy(Row_DB_300,Row_FTACs,Time_intv)

%PI_Time_fine=single([10:0.1:90]);
%row=100;
%Ind_300_row=Ind_300(:,256*(row-1)+1:256*row);
%Ind_300_vec=Ind_300_row(:);
%Logic_Pos=(Ind_300_vec == 0);
%Logic_Neg=(Ind_300_vec ~= 0);
%Ind_300_vec=Ind_300_vec+Logic_Pos;
%PL_300=single(permutes(Ind_300_vec,:));
%PL_300_row=PL_300.*Logic_Neg;
%Ct=TTCM_analytic_Multi(PL_300_row,PI_Time_fine);
%Ct(isnan(Ct))=0; % removing NaN
%Row_DB_300=Ct;
%Row_FTACs=Exp_New(squeeze(Fitted_4D(:,100,220,:)),PI_Time_fine);

%Row_DB_300_10T=repmat(Row_DB_300,10,1);
%Row_FTACs_10T=repmat(Row_FTACs,19,1);
coder.gpu.kernelfun();

DB_AUCs=Time_intv.*sum(Row_DB_300,2);
Fitted_AUCs=Time_intv.*sum(Row_FTACs,2);
Num_Vox=size(Row_FTACs,1);
Ind_10=zeros(10,Num_Vox,'single');
Val_10=zeros(10,Num_Vox,'single');

for v=1:1:Num_Vox
    if Fitted_AUCs(v,1)==0
        Ind_10(:,v)=0;
        Val_10(:,v)=0;
    else
        %[B,I] = gpucoder.sort(abs( DB_AUCs(300*(v-1)+1:300*v,1)-Fitted_AUCs(v,1)) );
        %Ind_10(:,v)=I(1:10);
        [B,I] = mink(  abs(DB_AUCs(300*(v-1)+1:300*v,1)-Fitted_AUCs(v,1)) ,10,1);
        Ind_10(:,v)=I;
        Val_10(:,v)=B;
    end
end
