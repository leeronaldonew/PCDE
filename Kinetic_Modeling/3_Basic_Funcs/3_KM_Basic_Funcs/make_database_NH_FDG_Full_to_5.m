function [permutes_tot,true_data]=make_database_NH_FDG_Full_to_5(measured_X_data)
% index ===> 1: Exp_4, 2: Feng

% making database Non-Homogeneously (e.g., k1: 0.01~1, k2:0.01~5, k3: 0.01~0.5, k4:0)

permutes=combinator(100,3,'p', 'r')*0.01;
permutes2=permutes+repmat([0,1,0],size(permutes,1),1);
permutes3=permutes2+repmat([0,1,0],size(permutes,1),1);
permutes4=permutes3+repmat([0,1,0],size(permutes,1),1);
permutes5=permutes4+repmat([0,1,0],size(permutes,1),1);
permutes_tot=[permutes;permutes2;permutes3;permutes4;permutes5];
permutes_tot(:,4)=0; % for FDG, k4=0;

k1_logic=permutes_tot(:,1) < 0.01; % for k1
k2_logic=permutes_tot(:,2) < 0.01; % for k2
k3_logic=permutes_tot(:,3) > 0.5; % for k3
logic=logical(k1_logic+k2_logic+k3_logic);
permutes_tot(logic,:)=[];

true_data=TTCM_analytic_Multi(permutes_tot, measured_X_data);

true_data(isnan(true_data))=0; % removing NaN

end