function [min_val, ind]=select_min_distance_ind(X,Y)
    [min_val,ind]=min( sum(abs(X-Y),2) );
    
end
