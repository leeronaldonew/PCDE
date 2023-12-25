function [sort_val,sort_ind]=Rank_AUC_Overlapped(Ct_DB,Fitted_Noisy,PI_Time_fine)
% Ranking by Overlapped Area


% Calc. AUC (using just true data points)
for i=1:1:size(Ct_DB,1)
    AUC_Cts(i,:)=trapz(PI_Time_fine,Ct_DB(i,:),2); % just using true data points
end

% Calc. AUC for Noisy data
AUC_Noisy=trapz(PI_Time_fine,Fitted_Noisy,2);
AUC_Noisy_repmat=repmat(AUC_Noisy,size(Ct_DB,1),1);

% Overlapped data points
for i=1:1:size(Ct_DB,1)
    Overlap_data(i,:)=min([Ct_DB(i,:);Fitted_Noisy],[],1);
end

% Calc. of Overlapped Area
AUC_Overlap=trapz(PI_Time_fine,Overlap_data,2);

% Calc. of Normalized Overlapped Area
N_AUC_Overlap=(2.*AUC_Overlap)./ (AUC_Cts+AUC_Noisy_repmat);

% Ranking
[sort_val,sort_ind]=sort(N_AUC_Overlap,'descend');




end