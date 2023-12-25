%% Calc. of AUC
Test=0;

for i=1:1:6
    Integ(i,:)=cumtrapz([10:0.1:90],Ct2(i,:));
end

AUCs=Integ(:,end);

Noisy=[28.10206,20.05989,23.06002,22.74449,20.38858,18.74983,18.30985,19.35043,23.65045];
Integ_Noisy=cumtrapz([10:10:90], Noisy);

AUC_Noisy=Integ_Noisy(end);


%% Measuring similarity between very similar curves
true_k=[0.86,0.98,0.01,0];
simil_1=[0.42,0.48,0.01,0];
simil_2=[0.41,0.47,0.01,0];
simil_3=[0.43,0.49,0.01,0];
simil_4=[0.26,0.27,0.01,0];
simil_5=[0.25,0.26,0.01,0];

% Late PI Time
PI_Time=[10:10:90];

% Input function for FDG
global Local_Estimates
Local_Estimates=[17.86;0.00841;-3423.59;1.23;3348.58;1.13929;17.67;0.06774];

% True & Simil Cts
true_Ct=TTCM_analytic_Multi(true_k,PI_Time);
% 1st row: true, 2nd row: simil_1, 3rd row: simil_2, et al..
TS_Cts=TTCM_analytic_Multi([true_k;simil_1;simil_2;simil_3;simil_4;simil_5],PI_Time);

% Noisy Ct
Noisy_Ct=[28.10206,20.05989,23.06002,22.74449,20.38858,18.74983,18.30985,19.35043,23.65045];

% Denoisy Ct (by FLT)
Denoisy_Ct=[25.9853588690748,23.7834634019204,22.0534566102728,20.7953384941320,20.0091090534979,19.6947682883707,19.8523161987502,20.4817527846365,21.5830780460296];

% True & Simil & Noisy & Denoisy Cts
Cts=[TS_Cts;Noisy_Ct;Denoisy_Ct];

% Exp_fit
for i=1:1:size(Cts,1)
   %Starting_Lin_Exp=[Cts(i,1),0.25];
   %lb_Exp=[0,0];
   %ub_Exp=[1.5*Cts(i,1),0.5];
   %[Estimates_Lin_Exp,SSE,Residual,d,e,f,Jacobian]=lsqcurvefit(@Lin_Exp, Starting_Lin_Exp, PI_Time,Cts(i,:),lb_Exp,ub_Exp); % for Exp
   Starting=[0,Cts(i,1)];
   lb=[0,-10000];
   ub=[10000,10000];
   [Estimates,SSE,Residual,d,e,f,Jacobian]=lsqcurvefit(@Inv_X_S, Starting, PI_Time,Cts(i,:),lb,ub); % for 1/x^2
   if i==1
        %Estimates_update=Estimates_Lin_Exp; % for Exp
        Estimates_update=Estimates; % for 1/x^2
   else
        %Estimates_update=cat(1,Estimates_update, Estimates_Lin_Exp); % for Exp
        Estimates_update=cat(1,Estimates_update, Estimates); % for 1/X^2
   end
end

% Fitted data
%Fitted_Cts=Lin_Exp(Estimates_update,[10:0.1:90]); % for Exp
Fitted_Cts=Inv_X_S(Estimates_update,[10:0.1:90]); % for 1/x^2

% Calc. AUC
for i=1:1:size(Fitted_Cts,1)
    Integ_Fitted_Cts(i,:)=cumtrapz([10:0.1:90],Fitted_Cts(i,:),2);
end
AUC_Fitted_Cts=Integ_Fitted_Cts(:,end);

% Normalized Fitted_Cts
for i=1:1:size(Fitted_Cts,1)
    N_Fitted_Cts(i,:)= Fitted_Cts(i,:)./AUC_Fitted_Cts(i,1);
end

% Exp_fit for Normalized Cts
for i=1:1:size(N_Fitted_Cts,1)
   %Starting_Lin_Exp=[Cts(i,1),0.25];
   %lb_Exp=[0,0];
   %ub_Exp=[1.5*Cts(i,1),0.5];
   %[Estimates_Lin_Exp,SSE,Residual,d,e,f,Jacobian]=lsqcurvefit(@Lin_Exp, Starting_Lin_Exp, PI_Time,Cts(i,:),lb_Exp,ub_Exp); % for Exp
   Starting=[0, N_Fitted_Cts(i,1)];
   lb=[0,-10000];
   ub=[10000,10000];
   [Estimates,SSE,Residual,d,e,f,Jacobian]=lsqcurvefit(@Inv_X_S, Starting, [10:0.1:90],N_Fitted_Cts(i,:),lb,ub); % for 1/x^2
   if i==1
        %Estimates_update=Estimates_Lin_Exp; % for Exp
        Estimates_update=Estimates; % for 1/x^2
   else
        %Estimates_update=cat(1,Estimates_update, Estimates_Lin_Exp); % for Exp
        Estimates_update=cat(1,Estimates_update, Estimates); % for 1/X^2
   end
end

% Calc. Slope & Acc
N_Slope=abs(-2.*Estimates_update(:,1).*([10:0.1:90].^(-3))); % Converting original slope (negative) into Positive Slope!!
N_Acc=6.*Estimates_update(:,1).*([10:0.1:90].^(-4));

% Getting of L-Spectrum
nl=10; % Legendre Polynomial's max order
for i=1:1:size(N_Fitted_Cts,1) % for N_Fitted_Cts
    y_py=py.numpy.array(transpose(N_Fitted_Cts(i,:)));
    FLT_results_py= py.LegendrePolynomials.LT(y_py,py.numpy.array(nl));	% FLT 
    FLT_results=double(FLT_results_py);
    if i==1
        FLT_result_update_Cts=FLT_results;
    else
        FLT_result_update_Cts=cat(1, FLT_result_update_Cts,FLT_results);
    end
end
for i=1:1:size(N_Slope,1) % for N_Slope
    y_py=py.numpy.array(transpose(N_Slope(i,:)));
    FLT_results_py= py.LegendrePolynomials.LT(y_py,py.numpy.array(nl));	% FLT 
    FLT_results=double(FLT_results_py);
    if i==1
        FLT_result_update_Slope=FLT_results;
    else
        FLT_result_update_Slope=cat(1, FLT_result_update_Slope,FLT_results);
    end
end
for i=1:1:size(N_Acc,1) % for N_Acc
    y_py=py.numpy.array(transpose(N_Acc(i,:)));
    FLT_results_py= py.LegendrePolynomials.LT(y_py,py.numpy.array(nl));	% FLT 
    FLT_results=double(FLT_results_py);
    if i==1
        FLT_result_update_Acc=FLT_results;
    else
        FLT_result_update_Acc=cat(1, FLT_result_update_Acc,FLT_results);
    end
end

% Comparison & Ranking in L-Space
FLT_Noisy_Cts=[0.0125016989909053,-0.000730310963048876,0.000714123413478836,-0.000564529552989381,0.000400081893574628,-0.000265692760076690,0.000167666830638756,-0.000103407756247366,5.98701530321327e-05,-3.60903790106629e-05];
FLT_Noisy_Slope=[0.0728786477046999,-0.175125814520176,0.209528265468053,-0.196601509874571,0.161652290720789,-0.122124035871583,0.0869308337714251,-0.0591870119226666,0.0389121061609834,-0.0248509608524529];
FLT_Noisy_Acc=[0.0148096573477820,-0.0390896572490638,0.0521834358373278,-0.0545838703985485,0.0497427543332991,-0.0413627455754430,0.0321883293139385,-0.0238114492262766,0.0169181688638873,-0.0116261112928972];


% for Cts
Y_data_repmat=repmat(FLT_Noisy_Cts, size(FLT_result_update_Cts,1),1);
[sort_val_Cts,sort_ind_Cts]=sort( sum(abs(FLT_result_update_Cts-Y_data_repmat) , 2) ); % 

% for Slope
Y_data_repmat=repmat(FLT_Noisy_Slope, size(FLT_result_update_Slope,1),1);
[sort_val_Slope,sort_ind_Slope]=sort( sum(abs(FLT_result_update_Slope-Y_data_repmat) , 2) ); % 

% for Acc
Y_data_repmat=repmat(FLT_Noisy_Acc, size(FLT_result_update_Acc,1),1);
[sort_val_Acc,sort_ind_Acc]=sort( sum(abs(FLT_result_update_Acc-Y_data_repmat) , 2) ); % 
 
% Scoring
score_table=[10,9,8,7,6,5,4,3,2,1];

for i=1:1:size(FLT_result_update_Cts,1)
   Tot_score(i,1)=(1/30)*( score_table(find(sort_ind_Cts==i))+score_table(find(sort_ind_Slope==i))+score_table(find(sort_ind_Acc==i)) ); % perfect score: 1
end




%% For NSD vs NBias curve %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Input :  columns (1st: Mean MSE, 2st: Mean_Pred) at a specific Noise Level
Input=0.0;
% True values
        k_True=[0.86,0.98,0.01,0]; % for index 13
        %k_True=[0.13,0.63,0.19,0]; % for index 3
        k1_True=k_True(1);
        k2_True=k_True(2);
        k3_True=k_True(3);
        k4_True=k_True(4);
        Ki_True= (k_True(1)*k_True(3)) / (k_True(2)+k_True(3));
        Vd_True= (k_True(1)*k_True(2)) / ((k_True(2)+k_True(3))^2);
True=transpose([k_True,Ki_True,Vd_True,k_True,Ki_True,Vd_True,k_True,Ki_True,Vd_True,Ki_True,Vd_True]);

NBias=transpose([0:1:50]);
for i=1:1:size(Input,1)
    NSD_temp= real( (100/Input(i,2)).*( (Input(i,1)-((True(i,1)/100.*NBias).^(2))).^(0.5)) );
    if i==1
        NSD=NSD_temp;
    else
        NSD=cat(2,NSD,NSD_temp);
    end
    
    %NSD{i,1}(NSD{i,1}==0)=[];
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Fitting test for calc. of AUC
global Local_Estimates
Local_Estimates=[17.86;0.00841;-3423.59;1.23;3348.58;1.13929;17.67;0.06774];

k_True_Neg=[0.86,0.98,0.01,0]; % for Neg. Slope
k_True_Pos=[0.13,0.63,0.19,0]; % for Pos. Slope


True_Neg=TTCM_analytic_Multi(k_True_Neg,[0:0.1:90]);
True_Pos=TTCM_analytic_Multi(k_True_Pos,[0:0.1:90]);

Cts_Neg=TTCM_analytic_Multi(k_True_Neg,[10:10:90]);
Cts_Pos=TTCM_analytic_Multi(k_True_Pos,[10:10:90]);

Starting=[0,0, Cts_Neg(1,1)];
lb=[-10000,-10000,-10000];
ub=[10000,10000,10000];
[Estimates_Neg,SSE,Residual,d,e,f,Jacobian]=lsqcurvefit(@Neg_Poly_2, Starting, [10:10:90],Cts_Neg,lb,ub); 
Fitted_Cts_Neg=Neg_Poly_2(Estimates_Neg,[10:1:90]);

Starting=[0,0, Cts_Pos(1,1)];
lb=[-10000,-10000,-10000];
ub=[10000,10000,10000];
[Estimates_Pos,SSE,Residual,d,e,f,Jacobian]=lsqcurvefit(@Neg_Poly_2, Starting, [10:10:90],Cts_Pos,lb,ub); 
Fitted_Cts_Pos=Neg_Poly_2(Estimates_Pos,[10:1:90]);


Starting=[0,0, max(Cts_Pos)];
lb=[-10000,-10000,-10000];
ub=[10000,10000,10000];
[Estimates_Pos,SSE,Residual,d,e,f,Jacobian]=lsqcurvefit(@Exp_New, Starting, [10:10:90],Cts_Pos,lb,ub); 
Fitted_Cts_Pos=Exp_New(Estimates_Pos,[10:1:90]);

Starting=[-1*max(Cts_Neg),0,0];
lb=[-10000,-10000,-10000];
ub=[10000,10000,10000];
[Estimates_Neg,SSE,Residual,d,e,f,Jacobian]=lsqcurvefit(@Exp_New, Starting, [10:10:90],Cts_Neg,lb,ub); 
Fitted_Cts_Neg=Exp_New(Estimates_Neg,[10:1:90]);



%% Two sample T-Test!! ( X: vector!(row), Y: vector!(row) )
x=0;
y=0;
[h,p]=ttest2(x,y,'Vartype','unequal');

%% Rank_AUC test!!

global Local_Estimates
Local_Estimates=[17.86;0.00841;-3423.59;1.23;3348.58;1.13929;17.67;0.06774];

comb=[0.09,0.51,0.05,0; 0.09,0.59,0.06,0; 0.16,0.80,0.04,0; 0.16,0.95,0.05,0; 0.19,0.96,0.04,0; 0.12,0.81,0.06,0; 0.09,0.43,0.04,0; 0.12,0.70,0.05,0; 0.12,0.59,0.04,0; 0.06,0.37,0.06,0; 0.03,0.13,0.05,0];
PI_Time=[10:10:90];
Noisy=[7.89031167883587,7.28183677786475,9.95590322714005,11.1280169875251,10.9565618991677,10.8423060388160,11.2356101755346,12.4763975380575,15.9044919153727];

[sort_val_AUC,sort_ind_AUC]=Rank_AUC(comb,Noisy,PI_Time);

%% Rank_Slope_Acc test!!
global Local_Estimates
Local_Estimates=[17.86;0.00841;-3423.59;1.23;3348.58;1.13929;17.67;0.06774];

comb=[0.09,0.51,0.05,0; 0.09,0.59,0.06,0; 0.16,0.80,0.04,0; 0.16,0.95,0.05,0; 0.19,0.96,0.04,0; 0.12,0.81,0.06,0; 0.09,0.43,0.04,0; 0.12,0.70,0.05,0; 0.12,0.59,0.04,0; 0.06,0.37,0.06,0; 0.03,0.13,0.05,0];
PI_Time=[10:10:90];
Noisy=[7.89031167883587,7.28183677786475,9.95590322714005,11.1280169875251,10.9565618991677,10.8423060388160,11.2356101755346,12.4763975380575,15.9044919153727];

[sort_val_Slope,sort_ind_Slope, sort_val_Acc,sort_ind_Acc]=Rank_Slope_Acc(comb,Noisy,PI_Time);


%% Rank_MI test!
global Local_Estimates
Local_Estimates=[17.86;0.00841;-3423.59;1.23;3348.58;1.13929;17.67;0.06774];

comb=[0.09,0.51,0.05,0; 0.09,0.59,0.06,0; 0.16,0.80,0.04,0; 0.16,0.95,0.05,0; 0.19,0.96,0.04,0; 0.12,0.81,0.06,0; 0.09,0.43,0.04,0; 0.12,0.70,0.05,0; 0.12,0.59,0.04,0; 0.06,0.37,0.06,0; 0.03,0.13,0.05,0];
PI_Time=[10:10:90];
Noisy=[7.89031167883587,7.28183677786475,9.95590322714005,11.1280169875251,10.9565618991677,10.8423060388160,11.2356101755346,12.4763975380575,15.9044919153727];

[sort_val_MI,sort_ind_MI]=Rank_MI(comb,Noisy,PI_Time);

%% Overall
comb=permutes(sort_ind(1:300),:);
score_table=transpose([300:-1:1]);

% calc. of Weights considering the prob. of occurance in the Top 300
edges_k1 = [0:0.1:1];
edges_k2 = [0:0.1:1];
edges_k3 = [0:0.1:1];
prob_k1 = histcounts(comb(:,1),edges_k1,'Normalization', 'probability');
prob_k2 = histcounts(comb(:,2),edges_k2,'Normalization', 'probability');
prob_k3 = histcounts(comb(:,3),edges_k3,'Normalization', 'probability');

for i=1:1:size(comb,1)
    temp_count_1=histcounts(comb(i,1),edges_k1);
    temp_count_2=histcounts(comb(i,2),edges_k2);
    temp_count_3=histcounts(comb(i,3),edges_k3);
    prob(i,1)=prob_k1(find(temp_count_1==1))*prob_k2(find(temp_count_2==1))*prob_k3(find(temp_count_3==1));
end

N_Weight=prob/sum(prob);

for i=1:1:size(comb,1)
    W_Tot_score(i,1)=  prob_scaled(i) * (1/1200)* ( (301-find(sort_ind_AUC==i)) + (301-find(sort_ind_Slope==i)) + (301-find(sort_ind_Acc==i)) + (301-find(sort_ind_Acc==i)) );
end

[sort_val_W_tot, sort_ind_W_tot]=sort(W_Tot_score,'descend');
ind_min=sort_ind(sort_ind_W_tot(1));

[sort_ind(sort_ind_AUC), sort_ind(sort_ind_Slope), sort_ind(sort_ind_Acc), sort_ind(sort_ind_MI)];





%% Plotting very similar curves
options = optimoptions('lsqcurvefit','Display', 'off');
global Local_Estimates
Local_Estimates=[17.86;0.00841;-3423.59;1.23;3348.58;1.13929;17.67;0.06774];
PI_Time=[10:10:90];
% Normal Liver (ind=13)
k_True=[0.86, 0.98, 0.01, 0];
Simil_1=[0.79,0.91,0.01,0];
Simil_2=[0.76,0.88,0.01,0];
Simil_3=[0.73,0.82,0.01,0];
Simil_4=[0.43,0.49,0.01,0];
Simil_5=[0.42,0.48,0.01,0];
Simil_6=[0.41,0.47,0.01,0];
Simil_7=[0.29,0.34,0.01,0];
Simil_8=[0.26,0.27,0.01,0];
Simil_9=[0.25,0.30,0.01,0];
Simil_10=[0.25,0.26,0.01,0];

k_multi=[k_True;Simil_1;Simil_2;Simil_3;Simil_4;Simil_5;Simil_6;Simil_7;Simil_8;Simil_9;Simil_10];

Cts=TTCM_analytic_Multi(k_multi,[0:0.1:90]);
x=transpose([0:0.1:90]);
y=transpose(Cts);

Noisy=[25.4944780239852,26.7800426769128,25.7233793863201,19.7081613063905,21.1060050199338,20.7509429981190,18.4154404892047,19.1775029723608,17.2342746253947];
x_Noisy=transpose([10:10:90]);
y_Noisy=transpose(Noisy);
% Exp_fit for Noisy data
    if Noisy(1,1) > Noisy(1,end) % Neg. Slope
        Starting=[-1*max(Noisy(1,:)),0,0];
        lb=[-10000,-10000,-10000];
        ub=[10000,10000,10000];
    else % Pos. Slope
        Starting=[0,0, max(Noisy(1,:))];
        lb=[-10000,-10000,-10000];
        ub=[10000,10000,10000];
    end
    [Estimates,SSE,Residual,d,e,f,Jacobian]=lsqcurvefit(@Exp_New, Starting, PI_Time,Noisy(1,:),lb,ub,options); % for C-A*exp(-B*t)
    Fitted_Noisy=Exp_New(Estimates,[10:0.1:90]); % for C-A*exp(-B*t)

x_Fitted=transpose([10:0.1:90]);
y_Fitted=transpose(Fitted_Noisy);


%% C_tot slope graph with time %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
options = optimoptions('lsqcurvefit','Display', 'off');
global Local_Estimates
Local_Estimates=[17.86;0.00841;-3423.59;1.23;3348.58;1.13929;17.67;0.06774];

syms k1 k2 k3 k4 alpha_TTCM beta_TTCM A1 A2 A3 A4 B1 B2 B3 B4 x C_tot k12 k13 k23
k12=k1/k2;
k13=k1/k3;
k23=k2/k3;
alpha_TTCM=  ( (k2+k3+k4) + (((k2+k3+k4)^2)-(4*k2*k4))^(0.5) ) / 2;
beta_TTCM=   ( (k2+k3+k4) - (((k2+k3+k4)^2)-(4*k2*k4))^(0.5) ) / 2;
C_tot= ( ((k1*(alpha_TTCM-k4)-k1*k3)/(alpha_TTCM-beta_TTCM)) * (((A1/(alpha_TTCM-B1))*(exp(-1*B1*x)-exp(-1*alpha_TTCM*x))) + ((A2/(alpha_TTCM-B2))*(exp(-1*B2*x)-exp(-1*alpha_TTCM*x))) + ((A3/(alpha_TTCM-B3))*(exp(-1*B3*x)-exp(-1*alpha_TTCM*x))) + ((A4/(alpha_TTCM-B4))*(exp(-1*B4*x)-exp(-1*alpha_TTCM*x)))) ) + ( ((k1*k3-(k1*(beta_TTCM-k4)))/(alpha_TTCM-beta_TTCM)) * (((A1/(beta_TTCM-B1))*(exp(-1*B1*x)-exp(-1*beta_TTCM*x))) + ((A2/(beta_TTCM-B2))*(exp(-1*B2*x)-exp(-1*beta_TTCM*x))) + ((A3/(beta_TTCM-B3))*(exp(-1*B3*x)-exp(-1*beta_TTCM*x))) + ((A4/(beta_TTCM-B4))*(exp(-1*B4*x)-exp(-1*beta_TTCM*x)))) ) ;

par_diff_k1= matlabFunction(diff(C_tot, k1));
par_diff_k2= matlabFunction(diff(C_tot, k2));
par_diff_k3= matlabFunction(diff(C_tot, k3));
par_diff_k4= matlabFunction(diff(C_tot, k4));
par_diff_k12= matlabFunction(diff(C_tot, k1/k2));

A1=Local_Estimates(1);
B1=Local_Estimates(2);
A2=Local_Estimates(3);
B2=Local_Estimates(4);
A3=Local_Estimates(5);
B3=Local_Estimates(6);
A4=Local_Estimates(7);
B4=Local_Estimates(8);

fplot(@(k12) par_diff_k12(k12));

k1=0.5;
k2=0.5;
k3=0.5;
k4=0.5;
par_diff_k1_val=par_diff_k1(A1,A2,A3,A4,B1,B2,B3,B4,k2,k3,k4,transpose([0:1:100]));
par_diff_k2_val=par_diff_k2(A1,A2,A3,A4,B1,B2,B3,B4,k1,k2,k3,k4,transpose([0:1:100]));
par_diff_k3_val=par_diff_k3(A1,A2,A3,A4,B1,B2,B3,B4,k1,k2,k3,k4,transpose([0:1:100]));
par_diff_k4_val=par_diff_k4(A1,A2,A3,A4,B1,B2,B3,B4,k1,k2,k3,k4,transpose([0:1:100]));

par_diff_k12_val=par_diff_k12(A1,A2,A3,A4,B1,B2,B3,B4,k1,k2,k3,k4,transpose([0:1:100]));


%% Patlak-aided micro kinetic modeling
options = optimoptions('lsqcurvefit','Display', 'off');
global Local_Estimates
Local_Estimates=[17.86;0.00841;-3423.59;1.23;3348.58;1.13929;17.67;0.06774]; % Params for FDG with Exp_4 generated from Feng's graph for FDG
PI_Time=[10:10:90];


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
        k_True=[0.86,0.98,0.01,0]; %13
        %k_True=[0.11,0.74,0.02,0]; %14



k1_True=k_True(1);
k2_True=k_True(2);
k3_True=k_True(3);
k4_True=k_True(4);
Ki_True= (k_True(1)*k_True(3)) / (k_True(2)+k_True(3));
Vd_True= (k_True(1)*k_True(2)) / ((k_True(2)+k_True(3))^2);

% Generating database
Num_real=10;
scale_factor=10;
[permutes,true_database]=make_database_NH_FDG_Full(PI_Time);
Ct_True=TTCM_analytic_Multi(k_True,PI_Time); % with Exp_4
Ct_True=repmat(Ct_True,Num_real,1);
Ct_Noisy=Ct_True + (Ct_True.*scale_factor*0.01.*randn(Num_real,size(PI_Time,2))); % original noise model
Ct_Noisy(Ct_Noisy < 0)=0; % to remove negative values

% K_i & V_d true (assumption: fractional blood volume in a voxel, Vb==0)
Func_Exp_4=@(tau) Exp_4(Local_Estimates,tau); % for Exp_4
Cp=Exp_4(Local_Estimates,PI_Time); % for Exp_4


for i=1:1:Num_real
    for p=1:1:size(PI_Time,2)
        X_Patlak(i,p)=integral(Func_Exp_4, 0, PI_Time(p), 'ArrayValued',true)/Cp(p); % for Exp_4
        Y_Patlak(i,p)=Ct_Noisy(i,p)/Cp(p);
    end
end

Starting_Patlak=[0;1];
LB_Patlak=[-10;0];
UB_Patlak=[10;10];
for i=1:1:Num_real
    x_temp=X_Patlak(i,:);
    y_temp=Y_Patlak(i,:);
    [Estimates,SSE,Residual,d,e,f,Jacobian]=lsqcurvefit(@Linear_Fit, Starting_Patlak, x_temp,y_temp, LB_Patlak, UB_Patlak,options);
    [ci, se]=nlparci(Estimates, Residual, 'jacobian', Jacobian);
    parameters_Patlak{i,1}=Estimates;
    RE_Patlak{i,1}=abs((se./Estimates))*100;
    %MSE_Patlak{i,1}=SSE/size(y_temp,1);
    %MSE_Patlak_Scaled{i,1}=sum(((Residual.*Cp).^(2)),'all')/size(y_temp,1);
    Ki_Patlak{i,1}=Estimates(2); % for Ki
    Vd_Patlak{i,1}=Estimates(1); % for Vd
end

% Calc. of a & b (k2=a*k1, k3=b*k1)
k1=transpose([0.01:0.01:1]);
for i=1:1:size(parameters_Patlak,1)
    Ki=parameters_Patlak{i,1}(2,1);
    Vd=parameters_Patlak{i,1}(1,1);
    a=((k1-Ki).^2)./(Vd.*(k1.^2));
    b=(Ki.*(k1-Ki))./(Vd.*(k1.^2));
    k1_ab_results{i,1}=[k1,a,b];
    %k1_ab_results{i,1}(find(k1_ab_results{i,1}(:,1).*a >1 | k1_ab_results{i,1}(:,1).*b > 0.5),:)=[];
    P_factor=k1.*(a./(a+b));
    Q_factor=k1.*(b./(a+b));
    R_factor=k1.*(a+b);
    PQR_factor{i,1}=[P_factor, Q_factor, R_factor];
end

% Calc. of a & b for DB
k1_ab_DB=[permutes(:,1),permutes(:,2)./permutes(:,1),permutes(:,3)./permutes(:,1)];
k1_DB=permutes(:,1); a_DB=permutes(:,2)./permutes(:,1); b_DB=permutes(:,3)./permutes(:,1);
PQR_factor_DB=[k1_DB.*(a_DB./(a_DB+b_DB)), k1_DB.*(b_DB./(a_DB+b_DB)), k1_DB.*(a_DB+b_DB)];

% Comparison of k1,a,b between DB v.s. Measured (Rough)
%for j=1:1:size(Ct_Noisy,1)
%    for i=1:1:size(PQR_factor{j,1},1)
%        DB_temp=PQR_factor_DB((5000*(i-1)+1):(5000*i),:);
%        Measured_temp=repmat(PQR_factor{j,1}(i,:),5000,1);
%        [min_val,min_ind]=min((sum((DB_temp-Measured_temp).^(2),2)).^(0.5));
%        k1_temp=i*0.01;
%        a_temp=(DB_temp(min_ind,3)/k1_temp)/(1+(DB_temp(min_ind,2)/DB_temp(min_ind,1)));
%        b_temp=(DB_temp(min_ind,2)/DB_temp(min_ind,1))*a_temp;
%        if i==1
%            Comp_results=DB_temp(min_ind,:);
%            Comp_results_k1_ab=[k1_temp,a_temp,b_temp];
%        else
%            Comp_results=cat(1,Comp_results, DB_temp(min_ind,:));
%            Comp_results_k1_ab=cat(1,Comp_results_k1_ab,[k1_temp,a_temp,b_temp]);
%        end
%    end
%    Comp{j,1}=Comp_results;
%    Comp_k1_ab{j,1}=Comp_results_k1_ab;
%end

% Calc. of Uncertainty of a,b,P,Q,R (by Error Propagation Theorem)
%for i=1:1:size(parameters_Patlak,1)
%    Ki=parameters_Patlak{i,1}(2,1);
%    Vd=parameters_Patlak{i,1}(1,1);
%    sig_Ki=RE_Patlak{i,1}(2,1)*parameters_Patlak{i,1}(2,1)/100;
%    sig_Vd=RE_Patlak{i,1}(1,1)*parameters_Patlak{i,1}(1,1)/100;
%    k1=transpose([0.01:0.01:1]);
%    sig_a=( (((4.*((k1-Ki).^2))./((k1.^4).*(Vd.^2))).*(sig_Ki.^2))+((((k1-Ki).^4)./((k1.^4).*(Vd.^2))).*(sig_Vd.^2)) ).^(0.5);
%    sig_b= ( ((((k1-2.*Ki).^2)./((k1.^4).*(Vd.^2))).*(sig_Ki.^2)) + (((Ki.^2).*((k1-Ki).^2))./((k1.^4).*(Vd.^4))).*(sig_Vd.^2) ).^(0.5);
%    
%    a=((k1-Ki).^2)./(Vd.*(k1.^2));
%    b=(Ki.*(k1-Ki))./(Vd.*(k1.^2));
%    sig_P= ( (k1.^2).*(((1./(a+b))-(a./((a+b).^2))).^2).*(sig_a.^2) + ((((k1.^2).*(a.^2))./((a+b).^4)).*(sig_b.^2)) ).^(0.5);
%    sig_Q= ( ((((k1.^2).*(b.^2))./((a+b).^4)).*(sig_a.^2)) + ((k1.^2).*(((1./(a+b))-(b./((a+b).^2))).^2).*(sig_b.^2)) ).^(0.5);
%    sig_R= ( ((k1.^2).*(sig_a.^2)) + ((k1.^2).*(sig_b.^2)) ).^(0.5); 
%    Rel_W{i,1}=[1./(sig_P.^2), 1./(sig_Q.^2), 1./(sig_R.^2)]; % Rel. weights based on each sigma level
%end


% Comparison of k1,a,b between DB v.s. Measured (Fine) (by comparison of P,Q,R)
%for j=1:1:size(Ct_Noisy,1)
%    %[sort_val,sort_ind]=sort(( Rel_W{j,1}(:,1).*abs((Comp{j,1}(:,1)-PQR_factor{j,1}(:,1))./(Comp{j,1}(:,1))).*100 )+ ( Rel_W{j,1}(:,2).*abs((Comp{j,1}(:,2)-PQR_factor{j,1}(:,2))./(Comp{j,1}(:,2))).*100 ) + ( Rel_W{j,1}(:,3).*abs((Comp{j,1}(:,3)-PQR_factor{j,1}(:,3))./(Comp{j,1}(:,3))).*100 ));
%    [sort_val,sort_ind]=sort( ( Rel_W{j,1}(:,1).*(abs((Comp{j,1}(:,1)-PQR_factor{j,1}(:,1))).^2) )+ ( Rel_W{j,1}(:,2).*((abs((Comp{j,1}(:,2)-PQR_factor{j,1}(:,2)))).^2) ) + ( Rel_W{j,1}(:,3).*(abs((Comp{j,1}(:,3)-PQR_factor{j,1}(:,3))).^2) ) );
%    %[sort_val,sort_ind]=sort( ( Rel_W{j,1}(:,1).*( (abs((Comp{j,1}(:,1)-PQR_factor{j,1}(:,1)))./Comp{j,1}(:,1)).^2 ) )+ ( Rel_W{j,1}(:,2).*( (abs((Comp{j,1}(:,2)-PQR_factor{j,1}(:,2)))./Comp{j,1}(:,2)).^2 ) ) + ( Rel_W{j,1}(:,3).*( (abs((Comp{j,1}(:,3)-PQR_factor{j,1}(:,3)))./Comp{j,1}(:,3)).^2 )  ) );    
%    if j==1
%        chosen_params=[Comp_k1_ab{j,1}(sort_ind(1),1), Comp_k1_ab{j,1}(sort_ind(1),1)*Comp_k1_ab{j,1}(sort_ind(1),2), Comp_k1_ab{j,1}(sort_ind(1),1)*Comp_k1_ab{j,1}(sort_ind(1),3),0] ;
%    else
%        chosen_params=cat(1, chosen_params, [Comp_k1_ab{j,1}(sort_ind(1),1), Comp_k1_ab{j,1}(sort_ind(1),1)*Comp_k1_ab{j,1}(sort_ind(1),2), Comp_k1_ab{j,1}(sort_ind(1),1)*Comp_k1_ab{j,1}(sort_ind(1),3),0]);
%    end
%end



% Comparison of k1,a,b between DB v.s. Measured (Rough)
for j=1:1:size(Ct_Noisy,1)
    for i=1:1:size(k1_ab_results{j,1},1)
        DB_temp=k1_ab_DB((5000*(i-1)+1):(5000*i),:);
        Measured_temp=repmat(k1_ab_results{j,1}(i,:),5000,1);
        [min_val,min_ind]=min((sum((DB_temp-Measured_temp).^(2),2)).^(0.5));
        if i==1
            Comp_results=DB_temp(min_ind,:);
        else
            Comp_results=cat(1,Comp_results, DB_temp(min_ind,:));
        end
    end
    Comp{j,1}=Comp_results;
end


% Comparison of k1,a,b between DB v.s. Measured (Fine) (by comparison of a,b)
for j=1:1:size(Ct_Noisy,1)
    [sort_val,sort_ind]=sort(( abs((Comp{j,1}(:,1)-k1_ab_results{j,1}(:,1))./(Comp{j,1}(:,1))).*100 )+ ( abs((Comp{j,1}(:,2)-k1_ab_results{j,1}(:,2))./(Comp{j,1}(:,2))).*100 ) + ( abs((Comp{j,1}(:,3)-k1_ab_results{j,1}(:,3))./(Comp{j,1}(:,3))).*100 ));
    %[sort_val,sort_ind]=sort( ( Rel_W{j,1}(:,1).*(abs((Comp{j,1}(:,1)-PQR_factor{j,1}(:,1))).^2) )+ ( Rel_W{j,1}(:,2).*((abs((Comp{j,1}(:,2)-PQR_factor{j,1}(:,2)))).^2) ) + ( Rel_W{j,1}(:,3).*(abs((Comp{j,1}(:,3)-PQR_factor{j,1}(:,3))).^2) ) );
    if j==1
        chosen_params=[Comp{j,1}(sort_ind(1),1),Comp{j,1}(sort_ind(1),1)*Comp{j,1}(sort_ind(1),2), Comp{j,1}(sort_ind(1),1)*Comp{j,1}(sort_ind(1),3),0 ] ;
    else
        chosen_params=cat(1, chosen_params, [Comp{j,1}(sort_ind(1),1),Comp{j,1}(sort_ind(1),1)*Comp{j,1}(sort_ind(1),2), Comp{j,1}(sort_ind(1),1)*Comp{j,1}(sort_ind(1),3),0 ]);
    end
end


for i=1:1:Num_real
    k1_PCDE_NEW{i,1}=chosen_params(i,1); % for k1
    k2_PCDE_NEW{i,1}=chosen_params(i,2); % for k2
    k3_PCDE_NEW{i,1}=chosen_params(i,3); % for k3
    k4_PCDE_NEW{i,1}=chosen_params(i,4); % for k4
    Ki_PCDE_NEW{i,1}=(chosen_params(i,1)*chosen_params(i,3)) / (chosen_params(i,2)+chosen_params(i,3)); % for Ki
    Vd_PCDE_NEW{i,1}=(chosen_params(i,1)*chosen_params(i,2)) / ((chosen_params(i,2)+chosen_params(i,3))^2); % for Vd
end

% Bias [%]
% for Ki
Bias_Ki_PCDE_NEW=abs(mean(cell2mat(Ki_PCDE_NEW),'all')-Ki_True);
NBias_Ki_PCDE_NEW=abs(mean(cell2mat(Ki_PCDE_NEW),'all')-Ki_True)/Ki_True*100;
% for Vd
Bias_Vd_PCDE_NEW=abs(mean(cell2mat(Vd_PCDE_NEW),'all')-Vd_True);
NBias_Vd_PCDE_NEW=abs(mean(cell2mat(Vd_PCDE_NEW),'all')-Vd_True)/Vd_True*100;
% for k1
Bias_k1_PCDE_NEW=abs(mean(cell2mat(k1_PCDE_NEW),'all')-k1_True);
NBias_k1_PCDE_NEW=abs(mean(cell2mat(k1_PCDE_NEW),'all')-k1_True)/k1_True*100;
% for k2
Bias_k2_PCDE_NEW=abs(mean(cell2mat(k2_PCDE_NEW),'all')-k2_True);
NBias_k2_PCDE_NEW=abs(mean(cell2mat(k2_PCDE_NEW),'all')-k2_True)/k2_True*100;
% for k3
Bias_k3_PCDE_NEW=abs(mean(cell2mat(k3_PCDE_NEW),'all')-k3_True);
NBias_k3_PCDE_NEW=abs(mean(cell2mat(k3_PCDE_NEW),'all')-k3_True)/k3_True*100;
% for k4
Bias_k4_PCDE_NEW=abs(mean(cell2mat(k4_PCDE_NEW),'all')-k4_True);
NBias_k4_PCDE_NEW=abs(mean(cell2mat(k4_PCDE_NEW),'all')-k4_True)/k4_True*100;






%% Finding optimal K1 using Fitting
% for Measured Ct
for i=1:1:size(Ct_Noisy,1)
    Ct_measured{i,1}=TTCM_k1_ab_Multi(k1_ab_results{i,1},[0:0.1:90]);
end


k1_ab_DB=[permutes(:,1),permutes(:,2)./permutes(:,1),permutes(:,3)./permutes(:,1)];


Ct_DB=TTCM_k1_ab_Multi(k1_ab_DB,[0:0.1:90]);

for i=1:1:size(Ct_Noisy,1)
    for j=1:1:size(Ct_measured{i,1},1)
        rep_temp=repmat(Ct_measured{i,1}(j,:), size(Ct_DB,1),1);
        [min_val,min_ind]=min(sum((rep_temp-Ct_DB).^2,2));
        if j==1
            min_results=[min_val, min_ind];
        else
            min_results=cat(1,min_results,[min_val, min_ind]);
        end
    end
    comp_results{i,1}=min_results;
end




% Fitted
for i=1:1:size(Ct_Noisy,1)
    if Noisy(1,1) > Noisy(1,end) % Neg. Slope
        Starting=[-1*max(Noisy(1,:)),0,0];
        lb=[-10000,-10000,-10000];
        ub=[10000,10000,10000];
    else % Pos. Slope
        Starting=[0,0, max(Noisy(1,:))];
        lb=[-10000,-10000,-10000];
        ub=[10000,10000,10000];
    end
    [Estimates,SSE,Residual,d,e,f,Jacobian]=lsqcurvefit(@Exp_New, Starting, PI_Time,Noisy(1,:),lb,ub,options); % for C-A*exp(-B*t)
    Fitted_Noisy=Exp_New(Estimates,[10:0.1:90]); % for C-A*exp(-B*t)
end

for i=1:1:size(Ct_measured,1)
    [sort_val,sort_ind]=sort(sum((rep_Ct_DB-Ct_measured{i,1}).^(2),2));
    optim_k(i,:)=[sort_ind(1)*0.01, ab_results{i,1}(sort_ind(1),1)*(sort_ind(1)*0.01), ab_results{i,1}(sort_ind(1),2)*(sort_ind(1)*0.01),0];
end




