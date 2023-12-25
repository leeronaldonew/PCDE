function [params_300_4D]=Acc_PCDE(Gpu_Input_Bed,PI_Times_Bed,true_db_sub,dims)

Num_Vox=size(Gpu_Input_Bed,1); % # of voxels that you want to calculate simultaneously!
Num_Comp=size(true_db_sub,1); % # of parameter comb. that you want to compare simultaneously!
Num_sub_set=size(true_db_sub,3); % # of subsets of True db
Num_Rows=size(Gpu_Input_Bed,3); % the # of Rows which is comprised of 256 Voxels


%% CPU version
sort_sub=zeros(300,2,'single');
sorted_update=zeros(300,2,'single');
sort_sum=zeros(600,2,'single');
sorted=zeros(600,2,'single');
sorted_300=zeros(300,2,'single');
sorted_update=zeros(300,2,'single');
%params_ind=zeros(Num_Vox,300,Num_Rows,'single');
params_ind_r=zeros(Num_Vox,300,'single');

%t1=clock;
for r=1:1:Num_Rows
    tic;
    parfor v=1:1:Num_Vox
        %if Gpu_Input_Bed(v,:,r) == zeros(1,size(PI_Times_Bed,2),'single')
        if Gpu_Input_Bed(v,:,r) == 0    
            params_ind_r(v,:)=zeros(1,300,'single');
        else
             for s=1:1:Num_sub_set
                [sort_val_temp,sort_ind_temp] = sortrows(real(sum((true_db_sub(:,:,s)-Gpu_Input_Bed(v,:,r)).^(2),2)));
                sort_sub=[sort_ind_temp(1:300)+((s-1).*Num_Comp), sort_val_temp(1:300)];
                if s==1     
                    sorted_update=sort_sub;
                else
                    sort_sum=[sorted_update;sort_sub];
                    sorted=sortrows(sort_sum,2);
                    sorted_300=sorted(1:300,:);
                    sorted_update=sorted_300;
                end
            end
            params_ind_r(v,:)=transpose(sorted_update(:,1));
        end  
    end

    if r==1
        params_ind_update=params_ind_r;
    else
        params_ind_update=cat(3,params_ind_update,params_ind_r);
    end
    toc; % time: 1.5 [sec]   
end
%t2=clock;
%elapse=etime(t2,t1)/60/60 % Elapsed time [hr]

%save("Etime.mat",'elapse');

%% Making  4D arrray of params_300_list
%tic;
params_300_4D=zeros(dims(1),dims(2),dims(3),300,'single');
for r=1:1:Num_Rows
    for v=1:1:Num_Vox
        params_300_4D(v,r-(dims(2)*(ceil(r/dims(2))-1)),ceil(r/dims(2)),:)=params_ind_update(v,:,r); % 4D array
    end
end
%toc;