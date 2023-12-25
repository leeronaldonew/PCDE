function [sort_val,sort_ind]=Calc_ToT_Score_2(sort_val1,sort_ind1,sort_val2,sort_ind2)

% Calc. of Selection Power
N_sort_val=[rescale(sort_val1),rescale(sort_val2)];
S_Power=[std(N_sort_val(:,1))/mean(N_sort_val(:,1))*100,std(N_sort_val(:,2))/mean(N_sort_val(:,2))*100];
N_S_Power=S_Power./sum(S_Power);

% Calc. of Tot score
N_comb=size(sort_ind1,1);
for i=1:1:N_comb
    Score(i,1)= (N_S_Power(1)*((N_comb+1)-find(sort_ind1==i))) + (N_S_Power(2)*((N_comb+1)-find(sort_ind2==i)));
end

[sort_val,sort_ind]=sort(Score,'descend');

end