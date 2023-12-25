function [FLT_result_update_Cts]=Get_L_Spectrum(Ct)

nl=10; % Legendre Polynomial's max order
for i=1:1:size(Ct,1)
    y_py=py.numpy.array(transpose(Ct(i,:)));
    FLT_results_py= py.LegendrePolynomials.LT(y_py,py.numpy.array(nl));	% FLT 
    FLT_results=double(FLT_results_py);
    if i==1
        FLT_result_update_Cts=FLT_results;
    else
        FLT_result_update_Cts=cat(1, FLT_result_update_Cts,FLT_results);
    end
end


end