function [FLT_database]=make_FLT_database(true_database)

nl=15; % max # of coefficients for the order of Legendre Polynomial
for i=1:1:size(true_database,1)
    y_py=py.numpy.array(transpose(true_database(i,:)));
    FLT_results_py= py.LegendrePolynomials.LT(y_py,py.numpy.array(nl));	% FLT 
    FLT_results=double(FLT_results_py);
    if i==1
        FLT_database=FLT_results;
    else
        FLT_database=cat(1, FLT_database,FLT_results);
    end
end



end