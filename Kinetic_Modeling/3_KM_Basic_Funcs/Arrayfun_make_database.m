function [database]=Arrayfun_make_database(True_params,measured_X_data,permutes)


for i=1:1:size(permutes, 1)
    tic;
    if i==1
        database=single(TTCM_analytic(permutes(i,:),measured_X_data));
    else
        database=cat(1, database,single(TTCM_analytic(permutes(i,:),measured_X_data)));
    end  
    i
    toc;
end



end