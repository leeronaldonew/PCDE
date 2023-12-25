function [sort_val_Score, sort_ind_Score]=ToT_Score(permutes,sort_ind,sort_ind_AUC,sort_ind_Cts,sort_ind_Slope,sort_ind_Acc)

% calc. of Weights considering frequency in the selected group
edges_k1 = [0:0.01:1];
%edges_k2 = [0 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1.0];
%edges_k2 = [0:0.1:5];
edges_k2 = [0:0.01:1];
edges_k3 = [0:0.01:1];

prob_k1 = histcounts(permutes(sort_ind(sort_ind_AUC(1:10)),1),edges_k1,'Normalization', 'probability');
prob_k2 = histcounts(permutes(sort_ind(sort_ind_AUC(1:10)),2),edges_k2,'Normalization', 'probability');
prob_k3 = histcounts(permutes(sort_ind(sort_ind_AUC(1:10)),3),edges_k3,'Normalization', 'probability');

for i=1:1:size(sort_ind_Cts,1)
    temp_count_1=histcounts(permutes(sort_ind(sort_ind_AUC(i)),1),edges_k1);
    temp_count_2=histcounts(permutes(sort_ind(sort_ind_AUC(i)),2),edges_k2);
    temp_count_3=histcounts(permutes(sort_ind(sort_ind_AUC(i)),3),edges_k3);
    prob(i,1)=prob_k1(find(temp_count_1==1))*prob_k2(find(temp_count_2==1))*prob_k3(find(temp_count_3==1));
end

N_Weights=prob./sum(prob);

Max_score=size(sort_ind_Cts,1);

for i=1:1:size(sort_ind_Cts,1)     
    Tot_Score(i,1)= N_Weights(i,1)*(1/(4*Max_score))*( (Max_score-(i-1))+(Max_score-(find(sort_ind_Cts==i)-1))+(Max_score-(find(sort_ind_Slope==i)-1))+(Max_score-(find(sort_ind_Acc==i)-1)) );
end


[sort_val_Score,sort_ind_Score]=sort(Tot_Score,'descend');


end