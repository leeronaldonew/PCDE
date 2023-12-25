function [permutes,true_data]=make_database_NH_FDG_Full_Conv(measured_X_data)
% index ===> 1: Exp_4, 2: Feng

% making database Non-Homogeneously (e.g., k1: 0.01~1, k2:0.01~1, k3: 0.01~0.5, k4:0)

permutes=combinator(100,4,'p', 'r')*0.01;

k1_logic=permutes(:,1) < 0.01; % for k1
k2_logic=permutes(:,2) < 0.01; % for k2
k3_logic=permutes(:,3) > 0.5; % for k3
k4_logic=permutes(:,4) > 0.01; % for k4 
logic=logical(k1_logic+k2_logic+k3_logic+k4_logic);
permutes(logic,:)=[];
permutes(:,4)=0; % for FDG, k4=0;

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

%true_data=TTCM_analytic_Multi(permutes, measured_X_data);

%true_test(1,:)=transpose(TTCM_vector([0.09,0.25,0.22,0], transpose([10:5:90])));
%true_test(2,:)=transpose(TTCM_vector([0.03,0.13,0.05,0], transpose([10:5:90])));
%true_data=TTCM_Conv([0.09,0.25,0.22,0;0.03,0.13,0.05,0],[10:5:90]);

for i=1:1:10
    tic;
    permutes_temp=permutes( (50000*(i-1)+1):(i*50000),: );
    true_data_temp=TTCM_Conv(permutes_temp,measured_X_data);
    if i==1
        true_data=true_data_temp;
    else
        true_data=cat(1, true_data,true_data_temp);
    end
    toc;
end

true_data(isnan(true_data))=0; % removing NaN

end