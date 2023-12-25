function [dtw_update]=dtw_multi(true_database,Ct_Noisy)

for i=1:1:size(true_database,1)
    dtw_result=dtw(true_database(i,:),Ct_Noisy);
    if i==1
        dtw_update=dtw_result;
    else
        dtw_update=cat(1, dtw_update,dtw_result);
    end

end






end