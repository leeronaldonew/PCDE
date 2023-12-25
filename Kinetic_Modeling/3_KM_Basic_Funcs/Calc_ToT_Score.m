function [sort_val,sort_ind]=Calc_ToT_Score(sort_vals,sort_inds,permutes, Final_inds,Sel_Power_ind)

% Calc. of Prob. of occurance in the Final list
edges_k1 = [0:0.05:1];
edges_k2 = [0:0.05:1];
edges_k3 = [0:0.05:1];
edges_k4 = [0:0.05:1];
prob_k1 = histcounts(permutes(Final_inds,1),edges_k1,'Normalization', 'probability');
prob_k2 = histcounts(permutes(Final_inds,2),edges_k2,'Normalization', 'probability');
prob_k3 = histcounts(permutes(Final_inds,3),edges_k3,'Normalization', 'probability');
prob_k4 = histcounts(permutes(Final_inds,4),edges_k4,'Normalization', 'probability');
for i=1:1:size(Final_inds,1)
    temp_count_1=histcounts(permutes(Final_inds(i),1),edges_k1);
    temp_count_2=histcounts(permutes(Final_inds(i),2),edges_k2);
    temp_count_3=histcounts(permutes(Final_inds(i),3),edges_k3);
    prob(i,1)=prob_k1(find(temp_count_1==1))*prob_k2(find(temp_count_2==1))*prob_k3(find(temp_count_3==1));
end
N_Weights=prob./sum(prob);

%N_Weights=ones(1,size(Final_inds,1));



colmin=min(sort_vals);
colmax=max(sort_vals);
N_sort_val=rescale(sort_vals,'InputMin',colmin,'InputMax',colmax);
Num_Feat=size(sort_vals,2);

switch Sel_Power_ind
    case 0 % off
        N_S_Power=ones(1,Num_Feat);
    case 1 % on
        % Calc. of Selection Power
        switch Num_Feat
            case 2
                S_Power=[std(N_sort_val(:,1))/mean(N_sort_val(:,1))*100,std(N_sort_val(:,2))/mean(N_sort_val(:,2))*100];
            case 3
                S_Power=[std(N_sort_val(:,1))/mean(N_sort_val(:,1))*100,std(N_sort_val(:,2))/mean(N_sort_val(:,2))*100,std(N_sort_val(:,3))/mean(N_sort_val(:,3))*100];
            case 4
                S_Power=[std(N_sort_val(:,1))/mean(N_sort_val(:,1))*100,std(N_sort_val(:,2))/mean(N_sort_val(:,2))*100,std(N_sort_val(:,3))/mean(N_sort_val(:,3))*100,std(N_sort_val(:,4))/mean(N_sort_val(:,4))*100];
            case 5
                S_Power=[std(N_sort_val(:,1))/mean(N_sort_val(:,1))*100,std(N_sort_val(:,2))/mean(N_sort_val(:,2))*100,std(N_sort_val(:,3))/mean(N_sort_val(:,3))*100,std(N_sort_val(:,4))/mean(N_sort_val(:,4))*100,std(N_sort_val(:,5))/mean(N_sort_val(:,5))*100];
            case 6
                S_Power=[std(N_sort_val(:,1))/mean(N_sort_val(:,1))*100,std(N_sort_val(:,2))/mean(N_sort_val(:,2))*100,std(N_sort_val(:,3))/mean(N_sort_val(:,3))*100,std(N_sort_val(:,4))/mean(N_sort_val(:,4))*100,std(N_sort_val(:,5))/mean(N_sort_val(:,5))*100,std(N_sort_val(:,6))/mean(N_sort_val(:,6))*100];
            case 7
                S_Power=[std(N_sort_val(:,1))/mean(N_sort_val(:,1))*100,std(N_sort_val(:,2))/mean(N_sort_val(:,2))*100,std(N_sort_val(:,3))/mean(N_sort_val(:,3))*100,std(N_sort_val(:,4))/mean(N_sort_val(:,4))*100,std(N_sort_val(:,5))/mean(N_sort_val(:,5))*100,std(N_sort_val(:,6))/mean(N_sort_val(:,6))*100,std(N_sort_val(:,7))/mean(N_sort_val(:,7))*100];
            case 8
                S_Power=[std(N_sort_val(:,1))/mean(N_sort_val(:,1))*100,std(N_sort_val(:,2))/mean(N_sort_val(:,2))*100,std(N_sort_val(:,3))/mean(N_sort_val(:,3))*100,std(N_sort_val(:,4))/mean(N_sort_val(:,4))*100,std(N_sort_val(:,5))/mean(N_sort_val(:,5))*100,std(N_sort_val(:,6))/mean(N_sort_val(:,6))*100,std(N_sort_val(:,7))/mean(N_sort_val(:,7))*100,std(N_sort_val(:,8))/mean(N_sort_val(:,8))*100]; 
        end
        N_S_Power=S_Power./sum(S_Power);
end

% Calc. of Tot score
N_comb=size(sort_inds,1);
switch Num_Feat
    case 2
        for i=1:1:N_comb
            Score(i,1)= N_Weights(i)*((N_S_Power(1)*((N_comb+1)-find(sort_inds(:,1)==i))) + (N_S_Power(2)*((N_comb+1)-find(sort_inds(:,2)==i))));
        end
    case 3
        for i=1:1:N_comb
            Score(i,1)= N_Weights(i)*((N_S_Power(1)*((N_comb+1)-find(sort_inds(:,1)==i))) + (N_S_Power(2)*((N_comb+1)-find(sort_inds(:,2)==i))) + (N_S_Power(3)*((N_comb+1)-find(sort_inds(:,3)==i))));
        end
    case 4
        for i=1:1:N_comb
            Score(i,1)= N_Weights(i)*((N_S_Power(1)*((N_comb+1)-find(sort_inds(:,1)==i))) + (N_S_Power(2)*((N_comb+1)-find(sort_inds(:,2)==i))) + (N_S_Power(3)*((N_comb+1)-find(sort_inds(:,3)==i))) + (N_S_Power(4)*((N_comb+1)-find(sort_inds(:,4)==i))));
        end
    case 5
        for i=1:1:N_comb
            Score(i,1)= N_Weights(i)*((N_S_Power(1)*((N_comb+1)-find(sort_inds(:,1)==i))) + (N_S_Power(2)*((N_comb+1)-find(sort_inds(:,2)==i))) + (N_S_Power(3)*((N_comb+1)-find(sort_inds(:,3)==i))) + (N_S_Power(4)*((N_comb+1)-find(sort_inds(:,4)==i))) + (N_S_Power(5)*((N_comb+1)-find(sort_inds(:,5)==i))));
        end
    case 6
        for i=1:1:N_comb
            Score(i,1)= N_Weights(i)*((N_S_Power(1)*((N_comb+1)-find(sort_inds(:,1)==i))) + (N_S_Power(2)*((N_comb+1)-find(sort_inds(:,2)==i))) + (N_S_Power(3)*((N_comb+1)-find(sort_inds(:,3)==i))) + (N_S_Power(4)*((N_comb+1)-find(sort_inds(:,4)==i))) + (N_S_Power(5)*((N_comb+1)-find(sort_inds(:,5)==i))) + (N_S_Power(6)*((N_comb+1)-find(sort_inds(:,6)==i))));
        end
    case 7
        for i=1:1:N_comb
            Score(i,1)= N_Weights(i)*((N_S_Power(1)*((N_comb+1)-find(sort_inds(:,1)==i))) + (N_S_Power(2)*((N_comb+1)-find(sort_inds(:,2)==i))) + (N_S_Power(3)*((N_comb+1)-find(sort_inds(:,3)==i))) + (N_S_Power(4)*((N_comb+1)-find(sort_inds(:,4)==i))) + (N_S_Power(5)*((N_comb+1)-find(sort_inds(:,5)==i))) + (N_S_Power(6)*((N_comb+1)-find(sort_inds(:,6)==i))) + (N_S_Power(7)*((N_comb+1)-find(sort_inds(:,7)==i))));
        end
    case 8
        for i=1:1:N_comb
            Score(i,1)= N_Weights(i)*((N_S_Power(1)*((N_comb+1)-find(sort_inds(:,1)==i))) + (N_S_Power(2)*((N_comb+1)-find(sort_inds(:,2)==i))) + (N_S_Power(3)*((N_comb+1)-find(sort_inds(:,3)==i))) + (N_S_Power(4)*((N_comb+1)-find(sort_inds(:,4)==i))) + (N_S_Power(5)*((N_comb+1)-find(sort_inds(:,5)==i))) + (N_S_Power(6)*((N_comb+1)-find(sort_inds(:,6)==i))) + (N_S_Power(7)*((N_comb+1)-find(sort_inds(:,7)==i))) + (N_S_Power(8)*((N_comb+1)-find(sort_inds(:,8)==i))));
        end    
end

[sort_val,sort_ind]=sort(Score,'descend');






end