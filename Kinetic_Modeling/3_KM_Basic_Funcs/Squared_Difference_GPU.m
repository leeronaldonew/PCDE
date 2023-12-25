function [Squ_diff]=Squared_Difference_GPU(true_database,Meas_Cts_temp)
coder.gpu.kernelfun();

%true_database=single(ones(100000000,20));
%Meas_Cts_temp=double(ones(1,20));

%tic;
true_database=half(true_database);
Meas_Cts_temp=half(Meas_Cts_temp);
%toc;
Squ_diff=half(zeros(size(true_database,1),size(true_database,2)));
for i=1:1:size(true_database,1)
    for j=1:1:size(true_database,2) 
        Squ_diff(i,j)=(true_database(i,j)-Meas_Cts_temp(1,j))*(true_database(i,j)-Meas_Cts_temp(1,j));
    end
end

%sum_val=sum(diff,2);


%tic;
%[sort_val,sort_ind]=sort(gpuArray(sum_val));
%[sort_val,sort_ind]=mink(sum_val,300);
%toc;

end