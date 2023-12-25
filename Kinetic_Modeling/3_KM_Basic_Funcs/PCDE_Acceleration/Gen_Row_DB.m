function [Row_DB_300]=Gen_Row_DB(r,Num_Vox_row,Ind_300,permutes,PI_Time_fine,Local_Estimates)
% r==> row index
% Num_Vox_row ==> the # of voxels in a single row
Ind_300_row=Ind_300(:,Num_Vox_row*(r-1)+1:Num_Vox_row*r);
Ind_300_row=Ind_300_row(:);
Logic_Pos=(Ind_300_row == 0);
Logic_Neg=(Ind_300_row ~= 0);
Ind_300_row=Ind_300_row+Logic_Pos;
PL_300=permutes(Ind_300_row,:);
PL_300=PL_300.*Logic_Neg;


PL_300_seg=PL_300(find(PL_300(:,1)~=0),:);

%temp=TTCM_analytic_Multi_Speedy(PL_300_seg,PI_Time_fine,Local_Estimates); % 0.39 [sec]
temp=TTCM_analytic_Multi_GPU_mex(PL_300_seg,PI_Time_fine,Local_Estimates); 
temp(isnan(temp))=0; % removing NaN

Row_DB_300=zeros(size(PL_300,1),size(PI_Time_fine,2),'single');
Row_DB_300(find(PL_300(:,1)~=0),:)=temp;
%Row_DB_300=TTCM_analytic_Multi(PL_300,PI_Time_fine);
%Row_DB_300(isnan(Row_DB_300))=0; % removing NaN


end