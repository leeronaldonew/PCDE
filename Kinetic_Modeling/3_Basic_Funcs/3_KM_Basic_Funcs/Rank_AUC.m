function [sort_val,sort_ind]=Rank_AUC(Ct_DB,Fitted_Noisy,PI_Time_fine)

%% Calc. AUC
%for i=1:1:size(Ct_DB,1)
%    AUC_Cts(i,:)=trapz(PI_Time_fine,Ct_DB(i,:),2); 
%end

AUC_Cts=sum(Ct_DB,2);


%% Calc. AUC for Noisy data
%AUC_Noisy=trapz(PI_Time_fine,Fitted_Noisy,2);
%AUC_Noisy=repmat(AUC_Noisy,size(Ct_DB,1),1);

AUC_Noisy=sum(Fitted_Noisy);


[sort_val,sort_ind]=sort(sum(abs(AUC_Cts-AUC_Noisy),2));

end