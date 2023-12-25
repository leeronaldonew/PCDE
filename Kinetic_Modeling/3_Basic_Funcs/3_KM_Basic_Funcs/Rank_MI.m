function [sort_val_MI,sort_ind_MI]=Rank_MI(Ct_DB,Fitted_Noisy,PI_Time_fine)

% Making PDF (database)
Sum_Ct=sum(Ct_DB,2);
Sum_Ct_repmat=repmat(Sum_Ct,1,size(Ct_DB,2));
PDF_Cts= Ct_DB ./ Sum_Ct_repmat;

% Making PDF (Noisy)
Sum_Noisy=sum(Fitted_Noisy);
PDF_Noisy=Fitted_Noisy ./ Sum_Noisy;

% Calc. of Entropy (database)
PW=-1.*PDF_Cts.*log2(PDF_Cts);
PW(isnan(PW))=0; % removing Nan
PW=real(PW);
H_DB=sum(PW,2);

% Calc. of Entropy (Noisy)
PW_Noisy=-1.*PDF_Noisy.*log2(PDF_Noisy);
PW_Noisy(isnan(PW_Noisy))=0; % removing Nan
PW_Noisy=real(PW_Noisy);
H_Noisy=sum(PW_Noisy);
H_Noisy_repmat=repmat(H_Noisy,size(PDF_Cts,1),1);

% Calc. of Joint Entropy
Num_bins=100;
for i=1:1:size(PDF_Cts,1)
    [PDF_Joint,Xedges,Yedges]=histcounts2(PDF_Cts(i,:),PDF_Noisy,Num_bins,'Normalization','probability');
    PDF_Joint_vec=transpose(PDF_Joint(:));
    if i==1
        PDF_Joint_update=PDF_Joint_vec;
    else
        PDF_Joint_update=cat(1,PDF_Joint_update,PDF_Joint_vec);
    end
end
PW_Joint=-1*PDF_Joint_update.*log2(PDF_Joint_update);
PW_Joint(isnan(PW_Joint))=0; % removing Nan
H_Joint=sum(PW_Joint,2);

% Calc. of MI
MI= H_DB + H_Noisy_repmat - H_Joint ;

% Ranking!
[sort_val_MI, sort_ind_MI]=sort(MI,'descend');

end