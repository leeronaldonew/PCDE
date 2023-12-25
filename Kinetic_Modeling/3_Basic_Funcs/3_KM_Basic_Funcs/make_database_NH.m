function [permutes,true_data]=make_database_NH(measured_X_data)
% making database Non-Homogeneously (e.g., k1: 0.5~1, k2:0.5~1, k3: 0.01~0.5, k4:0.01~0.5)


%permutes=single(round(0.01.*combinator(100,4,'p'), 2));
%permutes=single(0.02.*combinator(50,4,'p'));
%permutes=single(0.1.*combinator(10,4,'p'));
%permutes=single(round(0.1.*combinator(10,4,'p'), 2));
%permutes=single(combinator(100,4,'p', 'r'))*single(0.01);

permutes=combinator(100,4,'p', 'r')*0.01;

k1_logic=permutes(:,1) < 0.4; % for k1
k2_logic=permutes(:,2) < 0.5; % for k2
k3_logic=permutes(:,3) > 0.5; % for k3
k4_logic=permutes(:,4) > 0.5; % for k4 
logic=logical(k1_logic+k2_logic+k3_logic+k4_logic);
permutes(logic,:)=[];

%permutes=double(permutes);

%true_data=single(TTCM_analytic_Multi(permutes, measured_X_data));
true_data=TTCM_analytic_Multi(permutes, measured_X_data);

end