function [Slice_DB_10]=Gen_Slice_DB_10(Ind_10,permutes,PI_Time_fine,Local_Estimates)


Ind_10=Ind_10(:);
Logic_Pos=(Ind_10 == 0);
Logic_Neg=(Ind_10 ~= 0);
Ind_10=Ind_10+Logic_Pos;
PL_10=permutes(Ind_10,:);
PL_10=PL_10.*Logic_Neg;

PL_10_seg=PL_10(find(PL_10(:,1)~=0),:);

temp=TTCM_analytic_Multi_Speedy(PL_10_seg,PI_Time_fine,Local_Estimates);

Slice_DB_10=zeros(size(PL_10,1),size(PI_Time_fine,2),'single');
Slice_DB_10(find(PL_10(:,1)~=0),:)=temp;


end