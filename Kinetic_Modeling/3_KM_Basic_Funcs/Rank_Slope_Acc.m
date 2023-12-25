function [sort_val_Acc,sort_ind_Acc,sort_val_Slope,sort_ind_Slope]=Rank_Slope_Acc(Ct_DB,Fitted_Noisy,PI_Time_fine)

Slope_Ct=diff(Ct_DB,1,2) ./ 0.1; % First derivative
Acc_Ct=diff(Ct_DB,2,2) ./ 0.1;  % Second derivative

Slope_Noisy=diff(Fitted_Noisy,1) ./ 0.1; % First derivative
Acc_Noisy=diff(Fitted_Noisy,2) ./ 0.1; % Second derivative


% Comparison & Ranking
Slope_Noisy_repmat=repmat(Slope_Noisy,size(Slope_Ct,1),1);
Acc_Noisy_repmat=repmat(Acc_Noisy,size(Acc_Ct,1),1);

Slope_Diff=sum(abs(Slope_Ct-Slope_Noisy_repmat), 2);
Acc_Diff=sum(abs(Acc_Ct-Acc_Noisy_repmat), 2);

[sort_val_Slope,sort_ind_Slope]=sort(Slope_Diff);
[sort_val_Acc,sort_ind_Acc]=sort(Acc_Diff);


% Ranking using both Slope & Acc
%for i=1:1:size(Slope_Diff,1)
%    Score(i,1)= ((size(Slope_Diff,1)+1)-find(sort_ind_Slope==i)) + ((size(Acc_Diff,1)+1)-find(sort_ind_Acc==i));
%end

%[sort_val_SnA,sort_ind_SnA]=sort(Score,'descend');


%% Comparison in L-Space
%[LSpec_Slope_Ct]=Get_L_Spectrum(Slope_Ct);
%[LSpec_Acc_Ct]=Get_L_Spectrum(Acc_Ct);
%[LSpec_Slope_Noisy]=Get_L_Spectrum(Slope_Noisy);
%[LSpec_Acc_Noisy]=Get_L_Spectrum(Acc_Noisy);

%LSpec_Slope_Noisy_repmat=repmat(LSpec_Slope_Noisy,size(LSpec_Slope_Ct,1),1);
%LSpec_Acc_Noisy_repmat=repmat(LSpec_Acc_Noisy,size(LSpec_Acc_Ct,1),1);

%[sort_val_Slope_FLT,sort_ind_Slope_FLT]=sort(sum(abs(LSpec_Slope_Ct-LSpec_Slope_Noisy_repmat),2));
%[sort_val_Acc_FLT,sort_ind_Acc_FLT]=sort(sum(abs(LSpec_Acc_Ct-LSpec_Acc_Noisy_repmat),2));




end