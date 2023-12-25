function ind=Comp_Ct_Database_Meas_gpu(true_database,Meas_Cts_temp)

%tic;
%[sort_val,sort_ind] = sort(sum(abs(gpuArray(true_database)-single(repmat(gpuArray(single(Meas_Cts_temp)), size(true_database,1),1))).^2,2));
%toc;


%[sort_val,sort_ind] = sort(sum(abs(gpuArray(true_database)-single(repmat(gpuArray(single(Meas_Cts_temp)), size(true_database,1),1))),2));


%tic;

%true_database=half(ones(100000000,7));
%Meas_Cts_temp=half(ones(1,7));
%tic;
coder.gpu.kernelfun();
db_temp=half(zeros(10000,size(true_database,2)));
ind=half(zeros(10000,1));
for b=1:1:100000
    db_temp=half(true_database( ((b-1)*1000+1):(b*1000),:));
    [min_val,min_ind]=min( single(sum((db_temp-repmat(Meas_Cts_temp, size(db_temp,1),1)).^2,2)) );
    ind(b,1)=half(min_ind+1000);
end
%toc;







end