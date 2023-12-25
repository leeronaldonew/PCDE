function [Slice_FTACs]=Gen_Slice_FTACs(k,Fitted_4D,PI_Time_fine)

temp=[reshape(Fitted_4D(:,:,k,1),size(Fitted_4D(:,:,k,1),1)*size(Fitted_4D(:,:,k,1),2),1),reshape(Fitted_4D(:,:,k,2),size(Fitted_4D(:,:,k,2),1)*size(Fitted_4D(:,:,k,2),2),1),reshape(Fitted_4D(:,:,k,3),size(Fitted_4D(:,:,k,3),1)*size(Fitted_4D(:,:,k,3),2),1)];
    
temp_FTACs=Exp_New(temp(find( temp(:,1) ~=0 | temp(:,2) ~=0 | temp(:,3) ~=0),:),PI_Time_fine);

Slice_FTACs=zeros(size(Fitted_4D,1)*size(Fitted_4D,2),size(PI_Time_fine,2),'single');
Slice_FTACs(find( temp(:,1) ~=0 | temp(:,2) ~=0 | temp(:,3) ~=0),:)=temp_FTACs;


end