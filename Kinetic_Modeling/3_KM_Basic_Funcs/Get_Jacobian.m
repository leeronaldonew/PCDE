function J=Get_Jacobian(parameters,x_gpu_temp,Num_Passes,model_index)
% Model Index: 1 for Patlak, 2 for 2TCM

num_data_points=Num_Passes;
num_fits=size(x_gpu_temp,2)/Num_Passes;

switch model_index
    case 1 % for Patlak
        syms slope intercept x y_hat
        y_hat= slope*x+intercept;
        Par_Derivation_slope=matlabFunction(diff(y_hat, slope));
        Par_Derivation_intercept=matlabFunction(diff(y_hat, intercept));
        Par_Derivation_slope_Value=transpose(Par_Derivation_slope(x_gpu_temp));
        Par_Derivation_intercept_Value=transpose(ones(size(x_gpu_temp)));
        J=single([Par_Derivation_intercept_Value, Par_Derivation_slope_Value]);

    case 2 % for 2TCM
        load("Local_Estimates.mat");
        syms k1 k2 k3 k4 alpha_TTCM beta_TTCM A1 A2 A3 A4 B1 B2 B3 B4 x C_tot
        alpha_TTCM=  ( (k2+k3+k4) + (((k2+k3+k4)^2)-(4*k2*k4))^(0.5) ) / 2;
        beta_TTCM=   ( (k2+k3+k4) - (((k2+k3+k4)^2)-(4*k2*k4))^(0.5) ) / 2;
        C_tot= ( ((k1*(alpha_TTCM-k4)-k1*k3)/(alpha_TTCM-beta_TTCM)) * (((A1/(alpha_TTCM-B1))*(exp(-1*B1*x)-exp(-1*alpha_TTCM*x))) + ((A2/(alpha_TTCM-B2))*(exp(-1*B2*x)-exp(-1*alpha_TTCM*x))) + ((A3/(alpha_TTCM-B3))*(exp(-1*B3*x)-exp(-1*alpha_TTCM*x))) + ((A4/(alpha_TTCM-B4))*(exp(-1*B4*x)-exp(-1*alpha_TTCM*x)))) ) + ( ((k1*k3-(k1*(beta_TTCM-k4)))/(alpha_TTCM-beta_TTCM)) * (((A1/(beta_TTCM-B1))*(exp(-1*B1*x)-exp(-1*beta_TTCM*x))) + ((A2/(beta_TTCM-B2))*(exp(-1*B2*x)-exp(-1*beta_TTCM*x))) + ((A3/(beta_TTCM-B3))*(exp(-1*B3*x)-exp(-1*beta_TTCM*x))) + ((A4/(beta_TTCM-B4))*(exp(-1*B4*x)-exp(-1*beta_TTCM*x)))) ) ;
        par_diff_k1= matlabFunction(diff(C_tot, k1));
        par_diff_k2= matlabFunction(diff(C_tot, k2));
        par_diff_k3= matlabFunction(diff(C_tot, k3));
        par_diff_k4= matlabFunction(diff(C_tot, k4));
        A1=Local_Estimates(1);
        B1=Local_Estimates(2);
        A2=Local_Estimates(3);
        B2=Local_Estimates(4);
        A3=Local_Estimates(5);
        B3=Local_Estimates(6);
        A4=Local_Estimates(7);
        B4=Local_Estimates(8);
        for i=1:1:num_fits
            k1_temp=repmat(parameters(1,i),1,num_data_points);
            k2_temp=repmat(parameters(2,i),1,num_data_points);
            k3_temp=repmat(parameters(3,i),1,num_data_points);
            k4_temp=repmat(parameters(4,i),1,num_data_points);
            if i==1
                k1=k1_temp;
                k2=k2_temp;
                k3=k3_temp;
                k4=k4_temp;
            else
                k1=cat(2,k1,k1_temp);
                k2=cat(2,k2,k2_temp);
                k3=cat(2,k3,k3_temp);
                k4=cat(2,k4,k4_temp);
            end
        end
        par_diff_k1_val=transpose(par_diff_k1(A1,A2,A3,A4,B1,B2,B3,B4,k2,k3,k4,x_gpu_temp));
        par_diff_k2_val=transpose(par_diff_k2(A1,A2,A3,A4,B1,B2,B3,B4,k1,k2,k3,k4,x_gpu_temp));
        par_diff_k3_val=transpose(par_diff_k3(A1,A2,A3,A4,B1,B2,B3,B4,k1,k2,k3,k4,x_gpu_temp));
        par_diff_k4_val=transpose(par_diff_k4(A1,A2,A3,A4,B1,B2,B3,B4,k1,k2,k3,k4,x_gpu_temp));
        J=[par_diff_k1_val,par_diff_k2_val,par_diff_k3_val,par_diff_k4_val];
end




end