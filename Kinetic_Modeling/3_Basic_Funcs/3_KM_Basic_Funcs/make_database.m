function [permutes,true_data]=make_database(measured_X_data)

%permutes=single(round(0.01.*combinator(100,4,'p'), 2));
%permutes=single(0.02.*combinator(50,4,'p'));
%permutes=single(0.1.*combinator(10,4,'p'));
%permutes=single(round(0.1.*combinator(10,4,'p'), 2));
permutes=single(combinator(100,4,'p', 'r').*0.01);


%permutes=double(permutes);

true_data=single(TTCM_analytic_Multi(permutes, measured_X_data));


end