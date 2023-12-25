function [Optim_K1,Optim_K2,Optim_K3,Optim_K4]=Calc_ToT_Score_Rapid(Vals,Inds,permutes,Top_10)

%%  Calc. Relative Weights based on Prob. of occurance in the Final list
if Top_10==0 % empty slice
    Optim_K1=zeros(size(Inds,2),1,'single');
    Optim_K2=zeros(size(Inds,2),1,'single');
    Optim_K3=zeros(size(Inds,2),1,'single');
    Optim_K4=zeros(size(Inds,2),1,'single');
else
    edges_k = [0:0.05:1]; % original
    %edges_k = [0:0.01:1]; % modified
    Num_Vox=size(Top_10,2);
    prob_k1=zeros(size(edges_k,2)-1,Num_Vox,'single');
    prob_k2=zeros(size(edges_k,2)-1,Num_Vox,'single');
    prob_k3=zeros(size(edges_k,2)-1,Num_Vox,'single');
    prob_k4=zeros(size(edges_k,2)-1,Num_Vox,'single');
    parfor v=1:1:Num_Vox
        if Top_10(:,v)==0
            prob_k1(:,v)=0;
            prob_k2(:,v)=0;
            prob_k3(:,v)=0;
            prob_k4(:,v)=0;
        else
            prob_k1(:,v) = histcounts(permutes(Top_10(:,v),1),edges_k,'Normalization', 'probability')';
            prob_k2(:,v) = histcounts(permutes(Top_10(:,v),2),edges_k,'Normalization', 'probability')';
            prob_k3(:,v) = histcounts(permutes(Top_10(:,v),3),edges_k,'Normalization', 'probability')';
            prob_k4(:,v) = histcounts(permutes(Top_10(:,v),4),edges_k,'Normalization', 'probability')';
        end
    end
    Prob=zeros(size(Top_10,1),Num_Vox,'single');
    for v=1:1:Num_Vox
        if Top_10(:,v)==0
            Prob(:,v)=0;
        else
            for i=1:1:size(Top_10(:,v),1)
                temp_count_1=histcounts(permutes(Top_10(i,v),1),edges_k)';
                temp_count_2=histcounts(permutes(Top_10(i,v),2),edges_k)';
                temp_count_3=histcounts(permutes(Top_10(i,v),3),edges_k)';
                temp_count_4=histcounts(permutes(Top_10(i,v),4),edges_k)';
                Prob(i,v)= prob_k1(find(temp_count_1==1),v)*prob_k2(find(temp_count_2==1),v)*prob_k3(find(temp_count_3==1),v)*prob_k4(find(temp_count_4==1),v);
            end
        end
    end
    N_Weights=Prob./sum(Prob,1); % Calc. Rel Weights
    N_Weights(isnan(N_Weights))=0; % removing NaN

    clear prob_k1 prob_k2 prob_k3 prob_k4

    %% Calc. of Selection Power for each Feature
    N_Vals=zeros(size(Vals,1),size(Vals,2),size(Vals,3),'single');
    Num_Feat=size(Vals,3);
    for f=1:1:Num_Feat
        temp_colmin=min(Vals(:,:,f));
        temp_colmax=max(Vals(:,:,f));
        N_Vals(:,:,f)=rescale(Vals(:,:,f),'InputMin',temp_colmin,'InputMax',temp_colmax);
    end
    COV=zeros(size(Vals,3),size(Vals,2),'single');
    for f=1:1:Num_Feat
        COV(f,:)=std(N_Vals(:,:,f),0,1)./mean(Vals(:,:,f),1);
    end
    N_SPower=COV./sum(COV,1);
    N_SPower(isnan(N_SPower))=0; % removing NaN

    %% Calc. of Tot score (Perfect score for each Feature = 10)
    N_comb=size(Inds,1);
    Score=zeros(size(Inds,1),size(Inds,2),'single');
    for i=1:1:N_comb
        Score(i,:)=  N_Weights(i,:).*( (((N_comb+1)-Inds(i,:,1)).*N_SPower(1,:)) + (((N_comb+1)-Inds(i,:,2)).*N_SPower(2,:)) + (((N_comb+1)-Inds(i,:,3)).*N_SPower(3,:)) + (((N_comb+1)-Inds(i,:,4)).*N_SPower(4,:)) + (((N_comb+1)-Inds(i,:,5)).*N_SPower(5,:)) + (((N_comb+1)-Inds(i,:,6)).*N_SPower(6,:)) + (((N_comb+1)-Inds(i,:,7)).*N_SPower(7,:)) + (((N_comb+1)-Inds(i,:,8)).*N_SPower(8,:)) );
    end
    Score_seg=Score(:,find(Score(1,:)~=0));
    Optim_Ind=zeros(1,size(Inds,2),'single');
    [V_seg, I_seg]=maxk(Score_seg,1,1);
    Top_10_seg=Top_10(:,find(Score(1,:)~=0));
    for i=1:1:size(I_seg,2)
        temp(1,i)=Top_10_seg(I_seg(1,i),i);
    end
    Optim_Ind(1,find(Score(1,:)~=0))=temp;
    Optim_Ind_seg=Optim_Ind(find(Optim_Ind~=0));
    Optim_K1=zeros(size(Inds,2),1,'single');
    Optim_K2=zeros(size(Inds,2),1,'single');
    Optim_K3=zeros(size(Inds,2),1,'single');
    Optim_K4=zeros(size(Inds,2),1,'single');
    temp_K1=permutes(Optim_Ind_seg',1);
    temp_K2=permutes(Optim_Ind_seg',2);
    temp_K3=permutes(Optim_Ind_seg',3);
    temp_K4=permutes(Optim_Ind_seg',4);
    Optim_K1(find(Optim_Ind~=0),1)=temp_K1;
    Optim_K2(find(Optim_Ind~=0),1)=temp_K2;
    Optim_K3(find(Optim_Ind~=0),1)=temp_K3;
    Optim_K4(find(Optim_Ind~=0),1)=temp_K4;
end


end