% Decay_Correction_Code

lamda=0.006 % for 18F
Injection_Time= '121000'; % DCFPyL_4: 121000, FDG_1: 075000

% DCFPyL (patient #4)
PI_Times_1=0;  % Liver
PI_Times_2=0; % L_Kidney
PI_Times_3=0; % R_Kidney
PI_Times_4=0; % Salivary_Gland
PI_Times_5=0; % Tumor

% FDG (patient #1)
PI_Times_1=0;  % Liver
PI_Times_2=0; % L_Kidney
PI_Times_3=0; % R_Kidney
PI_Times_4=0; % Salivary_Gland


Org_1=0;
Org_2=0;
Org_3=0;
Org_4=0;
Org_5=0;

Org_1=0.001.*Org_1.*exp(lamda.*PI_Times_1); % [kBq/ml]
Org_2=0.001.*Org_2.*exp(lamda.*PI_Times_2);
Org_3=0.001.*Org_3.*exp(lamda.*PI_Times_3);
Org_4=0.001.*Org_4.*exp(lamda.*PI_Times_4);
Org_5=0.001.*Org_5.*exp(lamda.*PI_Times_5);



