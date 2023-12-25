% Calc. of Integ. Ct upto eq. t
options = optimoptions('lsqcurvefit','Display', 'off');
global Local_Estimates
Local_Estimates=[17.86;0.00841;-3423.59;1.23;3348.58;1.13929;17.67;0.06774];
PI_Time=[0:0.05:90];

Num_real=10;
scale_factor=10;

%k_True=[0.09,0.25,0.22,0]; %1
%k_True=[0.03,0.13,0.05,0]; %2
%k_True=[0.13,0.63,0.19,0]; %3
%k_True=[0.97,1,0.07,0]; %  %4
%k_True=[0.82,1,0.19,0]; %  %5
%k_True=[0.01,0.36,0.03,0]; %6
%k_True=[0.41,0.51,0.01,0]; %7
%k_True=[0.88,1,0.04,0]; %  %8
%k_True=[0.36,1,0.08,0]; %  %9
%k_True=[0.70,1,0.18,0]; %  %10
%k_True=[0.03,0.32,0.05,0]; %11
%k_True=[0.15,0.71,0.05,0]; %12
%k_True=[0.86,0.98,0.01,0]; %13
%k_True=[0.11,0.74,0.02,0]; %14

k1=k_True(1);
k2=k_True(2);
k3=k_True(3);
k4=k_True(4);

Ki_True= (k1*k3) / (k2+k3);
Vd_True= (k1*k2) /((k2+k3)^2);

Ct_True=TTCM_analytic_Multi(k_True,PI_Time); % with Exp_4

% Patlak Plot
Func_Exp_4=@(tau) Exp_4(Local_Estimates,tau); % for Exp_4
Cp=Exp_4(Local_Estimates,PI_Time); % for Exp_4

for p=1:1:size(PI_Time,2)
    X_Patlak(p)=integral(Func_Exp_4, 0, PI_Time(p), 'ArrayValued',true)/Cp(p); % for Exp_4
    Y_Patlak(p)=Ct_True(p)/Cp(p);
end

%plot(X_Patlak,Y_Patlak);

p_Patlak=polyfit(X_Patlak, Y_Patlak,1);
Ki=p_Patlak(1);
Vd=p_Patlak(2);

% Two_Phase_Lin (for Patlak plot)
Starting=[0,0,0,0];
LB=[0,-100000,0,-100000];
UB=[100000,100000,100000,100000];
[Estimates_Patlak,SSE,Residual,d,e,f,Jacobian]=lsqcurvefit(@Two_phase_Lin, Starting, X_Patlak, Y_Patlak, LB, UB,options);
Fitted=[transpose(X_Patlak), transpose(Two_phase_Lin(Estimates_Patlak,X_Patlak))];
Teq_in_Patlak_Plot=(Estimates_Patlak(2)-Estimates_Patlak(4)) / (Estimates_Patlak(3)-Estimates_Patlak(1));
Teq=PI_Time(max(find(X_Patlak <= Teq_in_Patlak_Plot)));


% Integ of Ct upto Teq
Time_Integ=PI_Time(find(PI_Time <= Teq));
Max_Ind_Time_Integ=size(Time_Integ,2);

Func_TTCM=@(tau) TTCM_analytic_Multi(k_True,tau);
Func_TTCM_C1=@(tau) TTCM_C1(k_True,tau);

for p=1:1:size(Time_Integ,2)
    Integ_C1_over_Cp(p)=integral(Func_TTCM_C1, 0,Time_Integ(p) , 'ArrayValued',true) / Cp(p);
end
Vd_approx=mean(Integ_C1_over_Cp);


for p=1:1:size(PI_Time,2)
    Integ_C1_over_Cp(p)=integral(Func_TTCM_C1, 0,PI_Time(p) , 'ArrayValued',true) / Cp(p);
end
Vd_approx=mean(Integ_C1_over_Cp(1:60));




%% Similar curve's Vd_approx values
options = optimoptions('lsqcurvefit','Display', 'off');
global Local_Estimates
Local_Estimates=[17.86;0.00841;-3423.59;1.23;3348.58;1.13929;17.67;0.06774];
PI_Time=[0:0.05:90];

Simil1=[0.79,0.91,0.01,0];
Simil2=[0.43,0.49,0.01,0];
Simil3=[0.25,0.30,0.01,0];

Ct_Simil=TTCM_analytic_Multi([Simil1;Simil2;Simil3],PI_Time);

% Patlak Plot
Func_Exp_4=@(tau) Exp_4(Local_Estimates,tau); % for Exp_4
Cp=Exp_4(Local_Estimates,PI_Time); % for Exp_4

for i=1:1:3
    for p=1:1:size(PI_Time,2)
        X_Patlak(i,p)=integral(Func_Exp_4, 0, PI_Time(p), 'ArrayValued',true)/Cp(p); % for Exp_4
        Y_Patlak(i,p)=Ct_Simil(i,p)/Cp(p);
    end
end
for i=1:1:3
    p_Patlak(i,:)=polyfit(X_Patlak(i,:),Y_Patlak(i,:),1);
end




%% Plotting True & Estimated TACs (using mean pred values)
global Local_Estimates
Local_Estimates=[17.86;0.00841;-3423.59;1.23;3348.58;1.13929;17.67;0.06774];

True3=[0.13,0.63,0.19,0]; % Brain cerebellum
True4=[0.97,1,0.07,0]; % Thyroid
True5=[0.82,1,0.19,0]; % Myocardium
True14=[0.11,0.74,0.02,0]; % Lung
True13=[0.86,0.98,0.01,0]; % Liver
True8=[0.88,1,0.04,0]; % Spleen
True9=[0.36,1,0.08,0]; % Pancreas
True10=[0.7,1,0.18,0]; % Kidney

BKG1=[0.03,0.32,0.05,0]; % Muscle
BKG2=[0.15,0.71,0.05,0]; % Bone
BKGs=[BKG1;BKG2];

Trues=[True3;True4;True5;True14;True13;True8;True9;True10];

Pred3_N5=[0.13,0.67,0.22,0]; Pred3_N10=[0.14,0.64,0.25,0]; % Brain cerebellum
Pred4_N5=[0.77,0.78,0.07,0]; Pred4_N10=[0.68,0.70,0.08,0]; % Thyroid
Pred5_N5=[0.62,0.71,0.21,0]; Pred5_N10=[0.55,0.58,0.22,0]; % Myocardium
Pred14_N5=[0.10,0.80,0.03,0]; Pred14_N10=[0.10,0.77,0.03,0]; % Lung
Pred13_N5=[0.81,0.92,0.01,0]; Pred13_N10=[0.75,0.86,0.01,0]; % Liver
Pred8_N5=[0.74,0.85,0.04,0]; Pred8_N10=[0.72,0.82,0.04,0]; % Spleen
Pred9_N5=[0.28,0.77,0.08,0]; Pred9_N10=[0.27,0.75,0.09,0]; % Pancreas
Pred10_N5=[0.53,0.72,0.20,0]; Pred10_N10=[0.49,0.62,0.21,0]; % Kidney

Preds_N5=[Pred3_N5;Pred4_N5;Pred5_N5;Pred14_N5;Pred13_N5;Pred8_N5;Pred9_N5;Pred10_N5];
Preds_N10=[Pred3_N10;Pred4_N10;Pred5_N10;Pred14_N10;Pred13_N10;Pred8_N10;Pred9_N10;Pred10_N10];


PI_Time=[0:0.1:120];
Ct_Trues=transpose(TTCM_analytic_Multi(Trues,PI_Time));
Ct_Preds_N5=transpose(TTCM_analytic_Multi(Preds_N5,PI_Time));
Ct_Preds_N10=transpose(TTCM_analytic_Multi(Preds_N10,PI_Time));
Ct_BKGs=transpose(TTCM_analytic_Multi(BKGs,PI_Time));

%% Converting Ct[kBq/ml] into SUV
Inject_D=10; % unit: [mCi]
Weight=80000; % unit: [g]

% F-18 decay constant
half_life=109.771; % unit: [min]
lamda= log(2) / half_life; % unit: [1/min]
Corrected_Inject_D=transpose(Inject_D.*exp(-1.*lamda.*PI_Time)); % unit: [mCi]

Ct_Trues_SUV=Ct_Trues./(Corrected_Inject_D.*37000./Weight); % unit: [g/ml] or [unitless]
Ct_Preds_N5_SUV=Ct_Preds_N5./(Corrected_Inject_D.*37000./Weight); % unit: [g/ml] or [unitless]
Ct_Preds_N10_SUV=Ct_Preds_N10./(Corrected_Inject_D.*37000./Weight); % unit: [g/ml] or [unitless]
Ct_BKGs_SUV=Ct_BKGs./(Corrected_Inject_D.*37000./Weight); % unit: [g/ml] or [unitless]


%% Calc. of Contrast & CER(Contrast Enhancement Ratio) Profile
% Contrast with "Muscle" 
Contrast_Muscle_N5=abs(Ct_Preds_N5_SUV-Ct_BKGs_SUV(:,1));
Contrast_Muscle_N10=abs(Ct_Preds_N10_SUV-Ct_BKGs_SUV(:,1));
CER_Muscle_N5=Contrast_Muscle_N5./ Contrast_Muscle_N5(601,:);
CER_Muscle_N10=Contrast_Muscle_N10./ Contrast_Muscle_N10(601,:);
% Contrast with "Bone"
Contrast_Bone_N5=abs(Ct_Preds_N5_SUV-Ct_BKGs_SUV(:,2));
Contrast_Bone_N10=abs(Ct_Preds_N10_SUV-Ct_BKGs_SUV(:,2));
CER_Bone_N5=Contrast_Bone_N5./ Contrast_Bone_N5(601,:);
CER_Bone_N10=Contrast_Bone_N10./ Contrast_Bone_N10(601,:);

%% Selecting Optimal time for the best contrast, given Time Window

% for BKG.: Muscle
 [temp_val,temp_ind]=max(Contrast_Muscle_N5,[],1);
 for i=1:1:size(Ct_Preds_N5_SUV,2)
    SUV_Optimal_Muscle_N5(i,1)=Ct_Preds_N5_SUV(temp_ind(i),i);
    SUV_Optimal_Time_Muscle_N5(i,1)=PI_Time(1,temp_ind(i));
 end
 [temp_val,temp_ind]=max(Contrast_Muscle_N10,[],1);
 for i=1:1:size(Ct_Preds_N10_SUV,2)
    SUV_Optimal_Muscle_N10(i,1)=Ct_Preds_N10_SUV(temp_ind(i),i);
    SUV_Optimal_Time_Muscle_N10(i,1)=PI_Time(1,temp_ind(i));
 end
% for BKG.: Bone
 [temp_val,temp_ind]=max(Contrast_Bone_N5,[],1);
 for i=1:1:size(Ct_Preds_N5_SUV,2)
    SUV_Optimal_Bone_N5(i,1)=Ct_Preds_N5_SUV(temp_ind(i),i);
    SUV_Optimal_Time_Bone_N5(i,1)=PI_Time(1,temp_ind(i));
 end
 [temp_val,temp_ind]=max(Contrast_Bone_N10,[],1);
 for i=1:1:size(Ct_Preds_N10_SUV,2)
    SUV_Optimal_Bone_N10(i,1)=Ct_Preds_N10_SUV(temp_ind(i),i);
    SUV_Optimal_Time_Bone_N10(i,1)=PI_Time(1,temp_ind(i));
 end
% SUV at the Specified Time
Spec_Time=2.3;

SUV_Spec_Time_N5_Muscle=[transpose(Ct_Preds_N5_SUV(find(PI_Time == Spec_Time),:)); Ct_BKGs_SUV(find(PI_Time == Spec_Time),1)];
SUV_Spec_Time_N10_Muscle=[transpose(Ct_Preds_N10_SUV(find(PI_Time == Spec_Time),:)); Ct_BKGs_SUV(find(PI_Time == Spec_Time),1)];

SUV_Spec_Time_N5_Bone=[transpose(Ct_Preds_N5_SUV(find(PI_Time == Spec_Time),:)); Ct_BKGs_SUV(find(PI_Time == Spec_Time),2)];
SUV_Spec_Time_N10_Bone=[transpose(Ct_Preds_N10_SUV(find(PI_Time == Spec_Time),:)); Ct_BKGs_SUV(find(PI_Time == Spec_Time),2)];


%% Loading XCAT DICOM files
V1 = flip(niftiread("C:\Users\LEE\Downloads\XCAT_DICOM\SUV_60m.nii"),3);
V2 = flip(niftiread("C:\Users\LEE\Downloads\XCAT_DICOM\SUV_120m.nii"),3);

slice1=flip(transpose(squeeze(V1(:,128,:))));
slice2=flip(transpose(squeeze(V2(:,128,:))));


figure1 = figure;
colormap(hot);

subplot(2,2,1);
image(slice1,'CDataMapping','direct');

subplot(2,2,2);
image(slice2,'CDataMapping','direct');



%% Filtering out using Ki (from Patlak)
options = optimoptions('lsqcurvefit','Display', 'off');
global Local_Estimates
Local_Estimates=[17.86;0.00841;-3423.59;1.23;3348.58;1.13929;17.67;0.06774];
PI_Time=[0:0.05:90];

Num_real=10;
scale_factor=10;

%k_True=[0.09,0.25,0.22,0]; %1
%k_True=[0.03,0.13,0.05,0]; %2
%k_True=[0.13,0.63,0.19,0]; %3
%k_True=[0.97,1,0.07,0]; %  %4
k_True=[0.82,1,0.19,0]; %  %5
%k_True=[0.01,0.36,0.03,0]; %6
%k_True=[0.41,0.51,0.01,0]; %7
%k_True=[0.88,1,0.04,0]; %  %8
%k_True=[0.36,1,0.08,0]; %  %9
%k_True=[0.70,1,0.18,0]; %  %10
%k_True=[0.03,0.32,0.05,0]; %11
%k_True=[0.15,0.71,0.05,0]; %12
%k_True=[0.86,0.98,0.01,0]; %13
%k_True=[0.11,0.74,0.02,0]; %14
k1=k_True(1);
k2=k_True(2);
k3=k_True(3);
k4=k_True(4);
Ki_True= (k1*k3) / (k2+k3);
Vd_True= (k1*k2) /((k2+k3)^2);

Ct_True=TTCM_analytic_Multi(k_True,PI_Time); % with Exp_4
Ct_True=repmat(Ct_True,Num_real,1);
Ct_Noisy=Ct_True + (Ct_True.*scale_factor*0.01.*randn(Num_real,size(PI_Time,2)));
% Patlak Plot
Func_Exp_4=@(tau) Exp_4(Local_Estimates,tau); % for Exp_4
Cp=Exp_4(Local_Estimates,PI_Time); % for Exp_4
for i=1:1:Num_real
    for p=1:1:size(PI_Time,2)
        X_Patlak(i,p)=integral(Func_Exp_4, 0, PI_Time(p), 'ArrayValued',true)/Cp(p); % for Exp_4
        Y_Patlak(i,p)=Ct_Noisy(i,p)/Cp(p);
    end
end
%plot(X_Patlak,Y_Patlak);
for i=1:1:Num_real
    p_Patlak=polyfit(X_Patlak(i,:), Y_Patlak(i,:),1);
    params_Patlak(i,:)=p_Patlak;
end

% Generating database
[permutes,true_database]=make_database_NH_FDG_Full(PI_Time);

for i=1:1:Num_real
    Y_data_repmat=repmat(Ct_Noisy(i,:), size(permutes,1),1);
    [sort_val,sort_ind]=sort( sum(abs(true_database-Y_data_repmat) , 2) ); % 
    temp_comp=permutes(sort_ind(1:10),:);
    temp_Ki_DB=temp_comp(:,1).*temp_comp(:,3)./(temp_comp(:,2)+temp_comp(:,3));
    temp_Ki_Noisy=repmat(params_Patlak(i,1),10,1);
    [min_val,min_ind]=min(abs(temp_Ki_Noisy-temp_Ki_DB));
    optim_params(i,:)=permutes(sort_ind(min_ind),:);
end