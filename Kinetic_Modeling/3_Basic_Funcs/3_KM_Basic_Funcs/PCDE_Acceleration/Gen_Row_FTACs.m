function [Row_FTACs]=Gen_Row_FTACs(r,Fitted_4D_Slice,PI_Time_fine)
% r ==> row index
Row_FTACs=Exp_New(squeeze(Fitted_4D_Slice(:,r,:)),PI_Time_fine);
end