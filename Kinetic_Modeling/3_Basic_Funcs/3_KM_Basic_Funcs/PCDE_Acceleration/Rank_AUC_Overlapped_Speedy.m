function [Val_ROA,Ind_ROA]=Rank_AUC_Overlapped_Speedy(DB_10,Slice_FTACs,Time_intv)

%for r=1:1:256
%    PI_Time_fine=single([10:0.1:90]);
%    Ind_300_row=Ind_300(:,256*(r-1)+1:256*r);
%    Ind_300_vec=Ind_300_row(:);
%    Logic_Pos=(Ind_300_vec == 0);
%    Logic_Neg=(Ind_300_vec ~= 0);
%    Ind_300_vec=Ind_300_vec+Logic_Pos;
%    PL_300=single(permutes(Ind_300_vec,:));
%    PL_300_row=PL_300.*Logic_Neg;
%    Ct=TTCM_analytic_Multi(PL_300_row,PI_Time_fine);
%    Ct(isnan(Ct))=0; % removing NaN
%    Row_DB_300=Ct;
%    Row_FTACs=Exp_New(squeeze(Fitted_4D(:,r,220,:)),PI_Time_fine);  
%    [I]=Rank_AUC_GPU(Row_DB_300,Row_FTACs,Time_intv);
%    if r==1
%        Ind_10=I;
%    else
%        Ind_10=cat(2,Ind_10,I);
%    end
%end
%for v=1:1:256*256
%    if Ind_10(:,v)==0
%        Real_Ind_10(:,v)=zeros(10,1,'single');
%    else
%        Real_Ind_10(:,v)=Ind_300(Ind_10(:,v),v);
%    end   
%end
%Ind_10=Real_Ind_10;
%Ind_10_vec=Ind_10(:);
%temp1=(Ind_10_vec ==0);
%temp2=(Ind_10_vec ~=0);
%Ind_10_vec=Ind_10_vec+temp1;
%PL_10=permutes(Ind_10_vec,:);
%PL_10=PL_10.*temp2;
%DB_10=TTCM_analytic_Multi(PL_10,PI_Time_fine);
%DB_10(isnan(DB_10))=0;

%for r=1:1:256
%    row_FTACs=Exp_New(squeeze(Fitted_4D(:,r,220,:)),PI_Time_fine);  
%    if r==1
%        Slice_FTACs=row_FTACs;
%    else
%        Slice_FTACs=cat(1,Slice_FTACs,row_FTACs);
%    end
%end
coder.gpu.kernelfun();

DB_AUCs=Time_intv.*sum(DB_10,2);
Fitted_AUCs=Time_intv.*sum(Slice_FTACs,2);
Num_Vox=size(Fitted_AUCs,1);

% Ratio of Overlapped Area (ROA)
Ind_ROA=zeros(10,Num_Vox,'single');
Val_ROA=zeros(10,Num_Vox,'single');
ROA=zeros(10,1,'single');

for v=1:1:Num_Vox
    if Fitted_AUCs(v,1)==0
        Ind_ROA(:,v)=0;
        Val_ROA(:,v)=0;
    else
        ROA= (2.*Time_intv.*sum(min(DB_10(10*(v-1)+1:10*v,:),Slice_FTACs(v,:)), 2)) ./ (DB_AUCs(10*(v-1)+1:10*v,1)+Fitted_AUCs(v,1));
        [Val,I] = gpucoder.sort(ROA);
        Ind_ROA(:,v)=I;
        Val_ROA(:,v)=Val;
    end
end


end