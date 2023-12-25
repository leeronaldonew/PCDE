function [permutes,true_data]=make_database_Irreversible_k4_001(measured_X_data)
% index ===> 1: Exp_4, 2: Feng

% making database Non-Homogeneously (e.g., k1: 0.01~1, k2:0.01~1, k3: 0.01~0.5, k4:0)

permutes=combinator(100,4,'p', 'r')*0.01;

k1_logic=permutes(:,1) < 0.01; % for k1
k2_logic=permutes(:,2) < 0.01; % for k2
k3_logic=permutes(:,3) > 0.5; % for k3
k4_logic=permutes(:,4) > 0.01; % for k4 
logic=logical(k1_logic+k2_logic+k3_logic+k4_logic);
permutes(logic,:)=[];
permutes(:,4)=0.001; % for FDG, k4=0;

%permutes=[permutes;[0,0,0,0]]; % adding for just BKG.

%permutes=double(permutes);

%true_data=single(TTCM_analytic_Multi(permutes, measured_X_data));
%switch index
%    case 1 % for Exp_4
%        true_data=TTCM_analytic_Multi(permutes, measured_X_data);
%    case 2 % for Feng
%        for i=1:1:size(permutes,1)
%            true_data(i,:)=transpose(TTCM_vector(transpose(permutes(i,:)), transpose(measured_X_data)));
%        end
%end

true_data=TTCM_analytic_Multi(permutes, measured_X_data);


true_data(isnan(true_data))=0; % removing NaN

end