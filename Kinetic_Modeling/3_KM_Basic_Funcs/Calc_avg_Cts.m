function [avg_Ct]=Calc_avg_Cts(permutes,True_TACs,Ct_m,sigma_m,Time_ind)

%% K-probability
%Whole_Time=[0:1:90];
%[permutes,True_TACs]=make_database_NH(Whole_Time);
%True_TACs_subset=True_TACs(1:10,:);

%if Up ==1
%    Ct_m=Ct_m+(0.01*sigma_m*Ct_m);
%else
%    Ct_m=Ct_m-(0.01*sigma_m*Ct_m);
%end


permutes=single(permutes);
True_TACs=single(True_TACs);

    % Picking specific Ct(ti)
    Ct=True_TACs(:,Time_ind); % Picking the time [min]
    Ct_int=round(Ct,3);
    Ct_int_truncated=Ct_int(find((Ct_int >= Ct_m*0.9) & (Ct_int <= Ct_m*1.1)));
    permutes_truncated=permutes(find((Ct_int >= Ct_m*0.9) & (Ct_int <= Ct_m*1.1)),:);
    True_TACs_truncated=True_TACs(find((Ct_int >= Ct_m*0.9) & (Ct_int <= Ct_m*1.1)),:);
    Ct_int=Ct_int_truncated;
    permutes=permutes_truncated;
    True_TACs=True_TACs_truncated;
    clear Ct Ct_int_truncated permutes_truncated True_TACs_truncated;

    %uniques=unique(Ct_int);
    %for i=1:1:size(uniques,1)
    %    Prob_Ct(i,1)=nnz(find(Ct_int==uniques(i))) / size(Ct_int,1);
    %end
    %Prob_Ct_unique = normpdf(uniques,Ct_m,Ct_m*sigma_m*0.01);
    %Multi=Prob_Ct.*Prob_Ct_unique;
    %[max_val,ind]=max(Multi);


    if (isempty(Ct_int)) || (isempty(permutes)) || (isempty(True_TACs))
        avg_Ct=Ct_m;
    else
        Ct_unique=unique(Ct_int);
        Num_Ct=size(Ct_int,1);
        Num_Ct_unique=size(Ct_unique,1);

        avail_k1=transpose(unique(permutes(:,1)));
        avail_k2=transpose(unique(permutes(:,2)));
        avail_k3=transpose(unique(permutes(:,3)));
        avail_k4=transpose(unique(permutes(:,4)));

        for i=1:1:Num_Ct_unique
            Probable_k1{i,1}=permutes(find(Ct_unique(i)==Ct_int),1);
            Probable_k2{i,1}=permutes(find(Ct_unique(i)==Ct_int),2);
            Probable_k3{i,1}=permutes(find(Ct_unique(i)==Ct_int),3);
            Probable_k4{i,1}=permutes(find(Ct_unique(i)==Ct_int),4);
        end
        for i=1:1:Num_Ct_unique
            Prob_X=transpose(unique(Probable_k1{i,1}));
            for j=1:1:size(Prob_X,2)
                Prob_Y(j)=single(nnz(find(Probable_k1{i,1}==Prob_X(j)))/size(Probable_k1{i,1},1));
            end
            Prob_k1{i,1}{1,1}=Prob_X;
            Prob_k1{i,1}{1,2}=Prob_Y;
            clear Prob_X Prob_Y
            Prob_X=transpose(unique(Probable_k2{i,1}));
            for j=1:1:size(Prob_X,2)
                Prob_Y(j)=single(nnz(find(Probable_k2{i,1}==Prob_X(j)))/size(Probable_k2{i,1},1));
            end
            Prob_k2{i,1}{1,1}=Prob_X;
            Prob_k2{i,1}{1,2}=Prob_Y;
            clear Prob_X Prob_Y
            Prob_X=transpose(unique(Probable_k3{i,1}));
            for j=1:1:size(Prob_X,2)
                Prob_Y(j)=single(nnz(find(Probable_k3{i,1}==Prob_X(j)))/size(Probable_k3{i,1},1));
            end
            Prob_k3{i,1}{1,1}=Prob_X;
            Prob_k3{i,1}{1,2}=Prob_Y;
            clear Prob_X Prob_Y
            Prob_X=transpose(unique(Probable_k4{i,1}));
            for j=1:1:size(Prob_X,2)
                Prob_Y(j)=single(nnz(find(Probable_k4{i,1}==Prob_X(j)))/size(Probable_k4{i,1},1));
            end
            Prob_k4{i,1}{1,1}=Prob_X;
            Prob_k4{i,1}{1,2}=Prob_Y;
            clear Prob_X Prob_Y
        end
        clear  Probable_k1 Probable_k2 Probable_k3 Probable_k4; 
        %True_C=TTCM_analytic([0.5,0.5,0.01,0.03],10)
        %Ct_measured=True_C+ (True_C*10*0.01*randn(1,1));

        Prob_Ct_unique = normpdf(Ct_unique,Ct_m,Ct_m*sigma_m*0.01);
    

        %True_C=10.5697;
        %Ct_measured=12.5081;

        for i=1:1:Num_Ct_unique
            Prob_k1{i,1}{1,3}=single(Prob_Ct_unique(i).*Prob_k1{i,1}{1,2});
            Prob_k2{i,1}{1,3}=single(Prob_Ct_unique(i).*Prob_k2{i,1}{1,2});
            Prob_k3{i,1}{1,3}=single(Prob_Ct_unique(i).*Prob_k3{i,1}{1,2});
            Prob_k4{i,1}{1,3}=single(Prob_Ct_unique(i).*Prob_k4{i,1}{1,2});
        end
        Weighted_Prob_k1=zeros(1,size(avail_k1,2));
        for k=1:1:size(avail_k1,2)
            temp=zeros(Num_Ct_unique,1);
            for i=1:1:Num_Ct_unique
                temp(i)=sum(Prob_k1{i,1}{1,3}(find(Prob_k1{i,1}{1,1}==avail_k1(k))), 'all');
            end
            Weighted_Prob_k1(1,k)=sum(temp,'all');
        end
        Weighted_Prob_k2=zeros(1,size(avail_k2,2));
        for k=1:1:size(avail_k2,2)
            temp=zeros(Num_Ct_unique,1);
            for i=1:1:Num_Ct_unique
                temp(i)=sum(Prob_k2{i,1}{1,3}(find(Prob_k2{i,1}{1,1}==avail_k2(k))), 'all');
            end
            Weighted_Prob_k2(1,k)=sum(temp,'all');
        end
        Weighted_Prob_k3=zeros(1,size(avail_k3,2));
        for k=1:1:size(avail_k3,2)
            temp=zeros(Num_Ct_unique,1);
            for i=1:1:Num_Ct_unique
                temp(i)=sum(Prob_k3{i,1}{1,3}(find(Prob_k3{i,1}{1,1}==avail_k3(k))), 'all');
            end
            Weighted_Prob_k3(1,k)=sum(temp,'all');
        end
        Weighted_Prob_k4=zeros(1,size(avail_k4,2));
        for k=1:1:size(avail_k4,2)
            temp=zeros(Num_Ct_unique,1);
            for i=1:1:Num_Ct_unique
                temp(i)=sum(Prob_k4{i,1}{1,3}(find(Prob_k4{i,1}{1,1}==avail_k4(k))), 'all');
            end
            Weighted_Prob_k4(1,k)=sum(temp,'all');
        end


        [Max_val,Max_ind]=max(Weighted_Prob_k1);
        Most_Probable_k1=avail_k1(find(Weighted_Prob_k1==Max_val));
        [Max_val,Max_ind]=max(Weighted_Prob_k2);
        Most_Probable_k2=avail_k2(find(Weighted_Prob_k2==Max_val));
        [Max_val,Max_ind]=max(Weighted_Prob_k3);
        Most_Probable_k3=avail_k3(find(Weighted_Prob_k3==Max_val));
        [Max_val,Max_ind]=max(Weighted_Prob_k4);
        Most_Probable_k4=avail_k4(find(Weighted_Prob_k4==Max_val));

    %Num_comb=size(Most_Probable_k1,2)*size(Most_Probable_k2,2)*size(Most_Probable_k3,2)*size(Most_Probable_k4,2);
    %Comb=permn([Most_Probable_k1,Most_Probable_k2,Most_Probable_k3,Most_Probable_k4],4);
    %for i=1:1:size(Most_Probable_k1,2)
    %    k1_logic= (Comb(:,1) ~= Most_Probable_k1(i)) ;
    %    if i==1
    %        k1_logic_cumul=k1_logic;
    %    else
    %        k1_logic_cumul=k1_logic.*k1_logic_cumul;
    %    end
    %end
    %for i=1:1:size(Most_Probable_k2,2)
    %    k2_logic= (Comb(:,2) ~= Most_Probable_k2(i)) ;
    %    if i==1
    %        k2_logic_cumul=k2_logic;
    %    else
    %        k2_logic_cumul=k2_logic.*k2_logic_cumul;
    %    end
    %end
    %for i=1:1:size(Most_Probable_k3,2)
    %    k3_logic= (Comb(:,3) ~= Most_Probable_k3(i)) ;
    %    if i==1
    %        k3_logic_cumul=k3_logic;
    %    else
    %        k3_logic_cumul=k3_logic.*k3_logic_cumul;
    %    end
    %end
    %for i=1:1:size(Most_Probable_k4,2)
    %    k4_logic= (Comb(:,4) ~= Most_Probable_k4(i)) ;
    %    if i==1
    %        k4_logic_cumul=k4_logic;
    %    else
    %        k4_logic_cumul=k4_logic.*k4_logic_cumul;
    %    end
    %end
    %k_logic=logical(k1_logic_cumul+k2_logic_cumul+k3_logic_cumul+k4_logic_cumul);
    %Comb(k_logic,:)=[];
    %Comb=unique(Comb,'rows');
    %avg_Ct=mean(TTCM_analytic_Multi(Comb, Time_ind*10),'all');
    
        if Time_ind ==1
            avg_Ct=mean(TTCM_analytic_Multi(permutes(find(permutes(:,1)==Most_Probable_k1 & permutes(:,3)==Most_Probable_k3),:),Time_ind*10),'all');
        else
            avg_Ct=mean(TTCM_analytic_Multi(permutes(find(permutes(:,4)==Most_Probable_k4 & permutes(:,3)==Most_Probable_k3),:),Time_ind*10),'all');
        end


    end

   

end