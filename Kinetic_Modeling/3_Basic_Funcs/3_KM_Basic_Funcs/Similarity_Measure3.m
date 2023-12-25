function [ind_min]=Similarity_Measure3(permutes, sort_ind, Noisy, PI_Time, PI_Time_fine, Fitted_Noisy)

% Determining Positive or Negative Slope
%if Noisy(1,1) > Noisy(1,end) % Neg. Slope
    %order=4; % original
%else % Pos. Slope
    %order=4;  %original  
%end


%order=4; % Original code
order=5; % with GPUfit


switch order
    case 1 % Original Similarity (with finer Prob.)

        [sort_val_AUC,sort_ind_AUC]=Selector_AUC(permutes(sort_ind(1:300),:),Noisy,PI_Time);

        % Getting L-Spectrum
        [FLT_database_Cts,FLT_database_Slope,FLT_database_Acc]=L_Spectrum_Database(permutes(sort_ind(sort_ind_AUC(1:10)),:),PI_Time);
        [FLT_noisy_Cts,FLT_noisy_Slope,FLT_noisy_Acc]=L_Spectrum_Noisy(Noisy,PI_Time);
    
        % Comparison in L-Space
        [sort_val_Cts,sort_ind_Cts]=Comp_L_Space(FLT_database_Cts,FLT_noisy_Cts);
        [sort_val_Slope,sort_ind_Slope]=Comp_L_Space(FLT_database_Slope,FLT_noisy_Slope);
        [sort_val_Acc,sort_ind_Acc]=Comp_L_Space(FLT_database_Acc,FLT_noisy_Acc);

        % Scoring (perfect score: 1 = (1/40)*(10+10+10+10))// AUC & Ct & Slope & Acc
        [sort_val_Score, sort_ind_Score]= ToT_Score(permutes,sort_ind,sort_ind_AUC, sort_ind_Cts, sort_ind_Slope, sort_ind_Acc);

        ind_min=sort_ind(sort_ind_AUC(sort_ind_Score(1)));

    case 2 % Testing!! 

        [sort_val_AUC,sort_ind_AUC]=Selector_AUC(permutes(sort_ind(1:300),:),Noisy,PI_Time);

        % Getting L-Spectrum
        [FLT_database_Cts,FLT_database_Slope,FLT_database_Acc]=L_Spectrum_Database(permutes(sort_ind(sort_ind_AUC(1:10)),:),PI_Time);
        [FLT_noisy_Cts,FLT_noisy_Slope,FLT_noisy_Acc]=L_Spectrum_Noisy(Noisy,PI_Time);
    
        % Comparison in L-Space
        [sort_val_Cts,sort_ind_Cts]=Comp_L_Space(FLT_database_Cts,FLT_noisy_Cts);
        [sort_val_Slope,sort_ind_Slope]=Comp_L_Space(FLT_database_Slope,FLT_noisy_Slope);
        [sort_val_Acc,sort_ind_Acc]=Comp_L_Space(FLT_database_Acc,FLT_noisy_Acc);

        % Scoring (perfect score: 1 = (1/40)*(10+10+10+10))// AUC & Ct & Slope & Acc
        %[sort_val_Score, sort_ind_Score]= ToT_Score_MI(permutes,Noisy,PI_Time,sort_ind,sort_ind_AUC, sort_ind_Cts, sort_ind_Slope, sort_ind_Acc);
        options = optimoptions('lsqcurvefit','Display', 'off');
        %% Exp_fit for Noisy data
        if Noisy(1,1) > Noisy(1,end) % Neg. Slope
            Starting=[-1*max(Noisy(1,:)),0,0];
            lb=[-10000,-10000,-10000];
            ub=[10000,10000,10000];
        else % Pos. Slope
            Starting=[0,0, max(Noisy(1,:))];
            lb=[-10000,-10000,-10000];
            ub=[10000,10000,10000];
        end
        [Estimates,SSE,Residual,d,e,f,Jacobian]=lsqcurvefit(@Exp_New, Starting, PI_Time,Noisy,lb,ub,options); % for C-A*exp(-B*t)   
        Fitted_Noisy=Exp_New(Estimates,[10:0.1:90]); % for C-A*exp(-B*t)


        [N_Ct_DB,N_Ct_DB_MM,O_Ct_DB]=Norm_Cts(permutes(sort_ind(sort_ind_AUC(1:10)),:),Fitted_Noisy,PI_Time,1); % for DB
        [N_Noisy,N_Noisy_MM,O_Noisy]=Norm_Cts(permutes(sort_ind(sort_ind_AUC(1:10)),:),Fitted_Noisy,PI_Time,2); % for Noisy

        [sort_val_MI,sort_ind_MI]=Rank_MI(N_Ct_DB,N_Noisy,PI_Time);
        %[sort_val_Acc,sort_ind_Acc,sort_val_Slope,sort_ind_Slope]=Rank_Slope_Acc(N_Ct_DB,N_Noisy,PI_Time);
        [sort_val_Con_Ct,sort_ind_Con_Ct,sort_val_Con_Slope,sort_ind_Con_Slope]=Rank_Connect(N_Ct_DB,N_Noisy,PI_Time);
        
        sort_inds=[transpose([1:1:10]),sort_ind_Cts, sort_ind_MI, sort_ind_Slope, sort_ind_Acc,sort_ind_Con_Ct,sort_ind_Con_Slope];
        sort_vals=[sort_val_AUC(1:10),sort_val_Cts, sort_val_MI, sort_val_Slope, sort_val_Acc, sort_val_Con_Ct,sort_val_Con_Slope];

        [sort_val_Score,sort_ind_Score]=Calc_ToT_Score(sort_vals,sort_inds,permutes, sort_ind(sort_ind_AUC(1:10)),0);
        
        ind_min=sort_ind(sort_ind_AUC(sort_ind_Score(1)));

    case 3 %% Testing (Original + finer Prob. + Sel. Power)
        [sort_val_AUC,sort_ind_AUC]=Selector_AUC(permutes(sort_ind(1:300),:),Noisy,PI_Time);

        % Getting L-Spectrum
        [FLT_database_Cts,FLT_database_Slope,FLT_database_Acc]=L_Spectrum_Database(permutes(sort_ind(sort_ind_AUC(1:10)),:),PI_Time);
        [FLT_noisy_Cts,FLT_noisy_Slope,FLT_noisy_Acc]=L_Spectrum_Noisy(Noisy,PI_Time);
    
        % Comparison in L-Space
        [sort_val_Cts,sort_ind_Cts]=Comp_L_Space(FLT_database_Cts,FLT_noisy_Cts);
        [sort_val_Slope,sort_ind_Slope]=Comp_L_Space(FLT_database_Slope,FLT_noisy_Slope);
        [sort_val_Acc,sort_ind_Acc]=Comp_L_Space(FLT_database_Acc,FLT_noisy_Acc);

        % Scoring (perfect score: 1 = (1/40)*(10+10+10+10))// AUC & Ct & Slope & Acc
        %[sort_val_Score, sort_ind_Score]= ToT_Score_MI(permutes,Noisy,PI_Time,sort_ind,sort_ind_AUC, sort_ind_Cts, sort_ind_Slope, sort_ind_Acc);
        options = optimoptions('lsqcurvefit','Display', 'off');
        %% Exp_fit for Noisy data
        if Noisy(1,1) > Noisy(1,end) % Neg. Slope
            Starting=double([-1*max(Noisy(1,:)),0,0]);
            lb=[-10000,-10000,-10000];
            ub=[10000,10000,10000];
        else % Pos. Slope
            Starting=double([0,0, max(Noisy(1,:))]);
            lb=[-10000,-10000,-10000];
            ub=[10000,10000,10000];
        end
        [Estimates,SSE,Residual,d,e,f,Jacobian]=lsqcurvefit(@Exp_New, Starting, PI_Time,double(Noisy),lb,ub,options); % for C-A*exp(-B*t)   
        Fitted_Noisy=Exp_New(Estimates,[10:0.1:90]); % for C-A*exp(-B*t)


        [N_Ct_DB,N_Ct_DB_MM,O_Ct_DB]=Norm_Cts(permutes(sort_ind(sort_ind_AUC(1:10)),:),Fitted_Noisy,PI_Time,1); % for DB
        [N_Noisy,N_Noisy_MM,O_Noisy]=Norm_Cts(permutes(sort_ind(sort_ind_AUC(1:10)),:),Fitted_Noisy,PI_Time,2); % for Noisy

        [sort_val_MI,sort_ind_MI]=Rank_MI(N_Ct_DB,N_Noisy,PI_Time);
        %[sort_val_Acc,sort_ind_Acc,sort_val_Slope,sort_ind_Slope]=Rank_Slope_Acc(N_Ct_DB,N_Noisy,PI_Time);
        [sort_val_Con_Ct,sort_ind_Con_Ct,sort_val_Con_Slope,sort_ind_Con_Slope]=Rank_Connect(N_Ct_DB,N_Noisy,PI_Time);
        
        sort_inds=[transpose([1:1:10]),sort_ind_Cts, sort_ind_MI, sort_ind_Slope, sort_ind_Acc,sort_ind_Con_Ct,sort_ind_Con_Slope];
        sort_vals=[sort_val_AUC(1:10),sort_val_Cts, sort_val_MI, sort_val_Slope, sort_val_Acc, sort_val_Con_Ct,sort_val_Con_Slope];

        [sort_val_Score,sort_ind_Score]=Calc_ToT_Score(sort_vals,sort_inds,permutes, sort_ind(sort_ind_AUC(1:10)),1);
        
        ind_min=sort_ind(sort_ind_AUC(sort_ind_Score(1)));
    case 4 % just final Similarity test!!
        %PI_Time_fine=[10:0.1:90];

            Ct_DB=TTCM_analytic_Multi(permutes(sort_ind(1:300),:),PI_Time_fine); % using TTCM_analytic
            %Ct_DB=TTCM_Conv(permutes(sort_ind(1:300),:),[10:0.1:90]); % using TTCM_Conv
            options = optimoptions('lsqcurvefit','Display', 'off');
            %% Exp_fit for Noisy data
            if Noisy(1,1) > Noisy(1,end) % Neg. Slope
                Starting=[-1*max(Noisy(1,:)),0,0];
                lb=[-10000,-10000,-10000];
                ub=[10000,10000,10000];
            else % Pos. Slope
                Starting=[0,0, max(Noisy(1,:))];
                lb=[-10000,-10000,-10000];
                ub=[10000,10000,10000];
            end
            [Estimates,SSE,Residual,d,e,f,Jacobian]=lsqcurvefit(@Exp_New, Starting, PI_Time,Noisy,lb,ub,options); % for C-A*exp(-B*t)   
            Fitted_Noisy=Exp_New(Estimates,PI_Time_fine); % for C-A*exp(-B*t)

            [sort_val_AUC,sort_ind_AUC]=Rank_AUC(Ct_DB,Fitted_Noisy,PI_Time_fine);

            %[N_Ct_DB,N_Ct_DB_MM,O_Ct_DB]=Norm_Cts(permutes(sort_ind(sort_ind_AUC(1:10)),:),Fitted_Noisy,PI_Time,1); % for DB
            %[N_Noisy,N_Noisy_MM,O_Noisy]=Norm_Cts(permutes(sort_ind(sort_ind_AUC(1:10)),:),Fitted_Noisy,PI_Time,2); % for Noisy
        
            Ct_DB=TTCM_analytic_Multi(permutes(sort_ind(sort_ind_AUC(1:10)),:),PI_Time_fine); % using TTCM_analytic
            %Ct_DB=TTCM_Conv(permutes(sort_ind(sort_ind_AUC(1:10)),:),[10:0.1:90]); % using TTCM_Conv


            % Ranking the Physical Features
            [sort_val_Overlap,sort_ind_Overlap]=Rank_AUC_Overlapped(Ct_DB,Fitted_Noisy,PI_Time_fine);
            [sort_val_Ct,sort_ind_Ct]=Rank_Ct(Ct_DB,Fitted_Noisy,PI_Time_fine);
            [sort_val_Acc,sort_ind_Acc,sort_val_Slope,sort_ind_Slope]=Rank_Slope_Acc(Ct_DB,Fitted_Noisy,PI_Time_fine);
            [sort_val_Con_Ct,sort_ind_Con_Ct,sort_val_Con_Slope,sort_ind_Con_Slope]=Rank_Connect(Ct_DB,Fitted_Noisy,PI_Time_fine);

            % Ranking the Statistical Feature
            [sort_val_MI,sort_ind_MI]=Rank_MI(Ct_DB,Fitted_Noisy,PI_Time);

            sort_inds=[transpose([1:1:10]), sort_ind_Overlap, sort_ind_Ct, sort_ind_Slope, sort_ind_Acc, sort_ind_Con_Ct, sort_ind_Con_Slope, sort_ind_MI];
            sort_vals=[sort_val_AUC(1:10), sort_val_Overlap, sort_val_Ct, sort_val_Slope, sort_val_Acc, sort_val_Con_Ct, sort_val_Con_Slope, sort_val_MI];

            % Calc. of Tot. Score & Ranking
            [sort_val_Score,sort_ind_Score]=Calc_ToT_Score(sort_vals,sort_inds,permutes, sort_ind(sort_ind_AUC(1:10)),1);       
            ind_min=sort_ind(sort_ind_AUC(sort_ind_Score(1)));


    case 5 % New Test (with GPUfit)
            Ct_DB=TTCM_analytic_Multi(permutes(sort_ind(1:300),:),PI_Time_fine); % using TTCM_analytic
            [sort_val_AUC,sort_ind_AUC]=Rank_AUC(Ct_DB,Fitted_Noisy,PI_Time_fine);
            Ct_DB=TTCM_analytic_Multi(permutes(sort_ind(sort_ind_AUC(1:10)),:),PI_Time_fine); % using TTCM_analytic

            % Ranking the Physical Features
            [sort_val_Overlap,sort_ind_Overlap]=Rank_AUC_Overlapped(Ct_DB,Fitted_Noisy,PI_Time_fine);
            [sort_val_Ct,sort_ind_Ct]=Rank_Ct(Ct_DB,Fitted_Noisy,PI_Time_fine);
            [sort_val_Acc,sort_ind_Acc,sort_val_Slope,sort_ind_Slope]=Rank_Slope_Acc(Ct_DB,Fitted_Noisy,PI_Time_fine);
            [sort_val_Con_Ct,sort_ind_Con_Ct,sort_val_Con_Slope,sort_ind_Con_Slope]=Rank_Connect(Ct_DB,Fitted_Noisy,PI_Time_fine);

            % Ranking the Statistical Feature
            [sort_val_MI,sort_ind_MI]=Rank_MI(Ct_DB,Fitted_Noisy,PI_Time);

            sort_inds=[transpose([1:1:10]), sort_ind_Overlap, sort_ind_Ct, sort_ind_Slope, sort_ind_Acc, sort_ind_Con_Ct, sort_ind_Con_Slope, sort_ind_MI];
            sort_vals=[sort_val_AUC(1:10), sort_val_Overlap, sort_val_Ct, sort_val_Slope, sort_val_Acc, sort_val_Con_Ct, sort_val_Con_Slope, sort_val_MI];

            % Calc. of Tot. Score & Ranking
            [sort_val_Score,sort_ind_Score]=Calc_ToT_Score(sort_vals,sort_inds,permutes, sort_ind(sort_ind_AUC(1:10)),1);       
            ind_min=sort_ind(sort_ind_AUC(sort_ind_Score(1)));


end







end