function Gen_Parametric_Vol_TTCM(Num_Passes, Num_Beds, Starting, LB, UB)

% Loading the necessary data
load('kBq.mat');
load('PI_Time.mat');

%load('kBq_half.mat');
%load('PI_Time_half.mat');

Size_WB=size(kBq);

% initialization
%X_data=zeros(Num_Passes,1);
%Y_data=zeros(Num_Passes,1);
%K_1=zeros(Size_WB(1),Size_WB(2),Size_WB(3));
%K_2=zeros(Size_WB(1),Size_WB(2),Size_WB(3));
%K_3=zeros(Size_WB(1),Size_WB(2),Size_WB(3));
%K_4=zeros(Size_WB(1),Size_WB(2),Size_WB(3));

%% Original code
%f_waitbar = waitbar(0,'Please wait...', 'Name','Fitting with 2TCM');
%for k=1:1:Size_WB(3)
%    waitbar(k/Size_WB(3), f_waitbar, "Current Slice Index: " + num2str(k) + " / " + num2str(Size_WB(3)));
%    for j=1:1:Size_WB(2)
%        for i=1:1:Size_WB(1)
%            for p=1:1:Num_Passes
%                X_data(p)=PI_Time(i,j,k,p);
%                Y_data(p)=kBq(i,j,k,p);
%            end
%            tic;
%            [Estimates,SSE,Residual,d,e,f,Jacobian]=lsqcurvefit(@TTCM_vector, Starting, double(X_data(:)),double(Y_data(:)), LB, UB);
%            toc;
%            K_1(i,j,k)=Estimates(1);
%            K_2(i,j,k)=Estimates(2);
%            K_3(i,j,k)=Estimates(3);
%            K_4(i,j,k)=Estimates(4);
%        end
%    end    
%end

%% Coronal slice test!
%f_waitbar = waitbar(0,'Please wait...', 'Name','Fitting with 2TCM');
%for k=1:1:Size_WB(3)
%    waitbar(k/Size_WB(3), f_waitbar, "Current Slice Index: " + num2str(k) + " / " + num2str(Size_WB(3)));
%    i=128;    
%    for j=1:1:Size_WB(2)
%        for p=1:1:Num_Passes
%            X_data(p)=PI_Time(i,j,k,p);
%            Y_data(p)=kBq(i,j,k,p);
%        end
%        tic;
%        [Estimates,SSE,Residual,d,e,f,Jacobian]=lsqcurvefit(@TTCM_vector, Starting, X_data,Y_data, LB, UB);
%        toc;
%        K_1(i,j,k)=Estimates(1);
%        K_2(i,j,k)=Estimates(2);      
%        K_3(i,j,k)=Estimates(3);
%        K_4(i,j,k)=Estimates(4);                  
%    end
%end

%% Single Loop test
%parfor N=1:1:(Size_WB(1)*Size_WB(2)*Size_WB(3))
%    k=floor( ( (N-1)/(Size_WB(1)*Size_WB(2)) ) + 1 );
%    j=floor( ( (N-1) / Size_WB(1) ) + 1 - (Size_WB(2)*(k-1)) );
%    i= ( N-(Size_WB(1)*(j-1)) - (Size_WB(1)*Size_WB(2)*(k-1)) ) ;
%    
%        X_data=reshape(PI_Time(i,j,k,:), [Num_Passes,1]);
%        Y_data=reshape(kBq(i,j,k,:), [Num_Passes,1]);
%
%    [Estimates,SSE,Residual,d,e,f,Jacobian]=lsqcurvefit(@TTCM_vector, Starting, X_data, Y_data, LB, UB);
%    K_1(( N-(Size_WB(1)*(j-1)) - (Size_WB(1)*Size_WB(2)*(k-1)) ),floor( ( (N-1) / Size_WB(1) ) + 1 - (Size_WB(2)*(k-1)) ),floor( ( (N-1)/(Size_WB(1)*Size_WB(2)) ) + 1 ))=Estimates(1);

%    K_2(i,j,k)=Estimates(2);      
%    K_3(i,j,k)=Estimates(3);
%    K_4(i,j,k)=Estimates(4);
%end


%% parfor test
%f_waitbar = waitbar(0,'Please wait...', 'Name','Fitting with 2TCM');
%K_1_cell=cell(Size_WB(3),1);
%K_2_cell=cell(Size_WB(3),1);
%K_3_cell=cell(Size_WB(3),1);
%K_4_cell=cell(Size_WB(3),1);
%for k=1:1:Size_WB(3)
%    %waitbar(k/Size_WB(3), f_waitbar, "Current Slice Index: " + num2str(k) + " / " + num2str(Size_WB(3)));
%    j=128;    
%    K_1_current=zeros(1, Size_WB(1));
%    K_2_current=zeros(1, Size_WB(1));
%    K_3_current=zeros(1, Size_WB(1));
%    K_4_current=zeros(1, Size_WB(1));
%    X_data=zeros(Num_Passes,1);
%    Y_data=zeros(Num_Passes,1);
%    for i=1:1:Size_WB(1)
%        for p=1:1:Num_Passes
%            X_data(p)=PI_Time_in(i,j,k,p);
%            Y_data(p)=kBq_in(i,j,k,p);
%        end
%        [Estimates,SSE,Residual,d,e,f,Jacobian]=lsqcurvefit(@TTCM_vector, Starting, X_data,Y_data, LB, UB);
%        K_1_current(i)=Estimates(1);
%        K_2_current(i)=Estimates(2);      
%        K_3_current(i)=Estimates(3);
%        K_4_current(i)=Estimates(4);      
%    end
%    K_1_cell{k,1}=K_1_current;
%    K_2_cell{k,1}=K_1_current;
%    K_3_cell{k,1}=K_1_current;
%    K_4_cell{k,1}=K_1_current;
%end
%for k=1:1:Size_WB(3)
%    K_1(:,128,k)=K_1_cell{k,1};
%    K_2(:,128,k)=K_2_cell{k,1};
%    K_3(:,128,k)=K_3_cell{k,1};
%    K_4(:,128,k)=K_4_cell{k,1};
%end

%% using GPUfit
[x_gpu, y_gpu, initial_params, constraints]=Make_GPUfit_Input(PI_Time, kBq, Starting, LB, UB, 2); % for 2TCM model index == 2

% GPUfit setting
estimator_id = EstimatorID.LSE;
model_id = ModelID.TTCM;
tolerance = 1e-9;
max_n_iterations = 1000; % Original


constraint_types = int32([ConstraintType.LOWER_UPPER, ConstraintType.LOWER_UPPER, ConstraintType.LOWER_UPPER, ConstraintType.LOWER_UPPER]); % considering both lower & upper bounds

x_gpu_temp=zeros(1, Size_WB(4)*Size_WB(1)*Size_WB(2), 'single');
y_gpu_temp=zeros(Size_WB(4), Size_WB(1)*Size_WB(2), 'single');
initial_params_temp=zeros(size(Starting,1),Size_WB(1)*Size_WB(2), 'single');
constraints_temp=zeros(2*size(Starting,1),Size_WB(1)*Size_WB(2), 'single');

Num_inlier=single(repmat(Size_WB(4),1,size(y_gpu,2)));
inlierIdx=single(ones(Size_WB(4),size(y_gpu,2)));

f_waitbar = waitbar(0,'Please wait...', 'Name','Fitting with 2TCM');
for k=1:1:Size_WB(3) % fiitting slice by slice
    tic;
    waitbar(k/Size_WB(3), f_waitbar, "Current Slice Index: " + num2str(k) + " / " + num2str(Size_WB(3)));
    i_start= ((k-1)*Size_WB(1)*Size_WB(2))+1; % initialization
    i_end= k*Size_WB(1)*Size_WB(2);
    i_start_x_gpu_temp=((k-1)*Size_WB(4)*Size_WB(1)*Size_WB(2))+1;
    i_end_x_gpu_temp=k*Size_WB(4)*Size_WB(1)*Size_WB(2);
    x_gpu_temp=x_gpu(1, i_start_x_gpu_temp:i_end_x_gpu_temp);
    y_gpu_temp=y_gpu(:,i_start:i_end);
    initial_params_temp=initial_params(:,i_start:i_end);
    constraints_temp=constraints(:,i_start:i_end);

    if y_gpu_temp==0
        parameters=zeros(4,Size_WB(1)*Size_WB(2),'single');
        chi_squares=zeros(1,Size_WB(1)*Size_WB(2),'single');
        RE_slice=zeros(4,Size_WB(1)*Size_WB(2),'single');
    else
        [parameters, states, chi_squares, n_iterations, time]...
            = gpufit_constrained(y_gpu_temp, [], model_id, initial_params_temp, constraints_temp, constraint_types, tolerance, max_n_iterations, [], estimator_id, x_gpu_temp);
        % Calc. of RE[%] from Jacobian(through calc. of Covariance Matrix)
        J_slice=Get_Jacobian(parameters,x_gpu_temp,Num_Passes,2); % 2TCM: model index=2
        [RE_slice, se_slice]=Get_RE(J_slice, parameters, chi_squares, Num_Passes,Num_inlier,inlierIdx,2); % 2TCM: model index=2
    end

    if k==1
        parameters_update=parameters;
        RE_update=RE_slice;
    else
        parameters_update=cat(2, parameters_update, parameters);
        RE_update=cat(2, RE_update, RE_slice);
    end
    toc;
end
close(f_waitbar);

k1=reshape(parameters_update(1,:),Size_WB(1),Size_WB(2),Size_WB(3));
k2=reshape(parameters_update(2,:),Size_WB(1),Size_WB(2),Size_WB(3));
k3=reshape(parameters_update(3,:),Size_WB(1),Size_WB(2),Size_WB(3));
k4=reshape(parameters_update(4,:),Size_WB(1),Size_WB(2),Size_WB(3));

%k1_RE=reshape(RE_update(1,:), Size_WB(1),Size_WB(2),Size_WB(3));
%k2_RE=reshape(RE_update(2,:), Size_WB(1),Size_WB(2),Size_WB(3));
%k3_RE=reshape(RE_update(3,:), Size_WB(1),Size_WB(2),Size_WB(3));
%k4_RE=reshape(RE_update(4,:), Size_WB(1),Size_WB(2),Size_WB(3));

%Masking (k-values: > 0.001)
% Settings
%Thre_k1 = 0;
%Thre_k2 = 0;
%Thre_k3 = 0;
%Thre_k4 = 0;
%k1_mask= k1 > Thre_k1;
%k2_mask= k2 > Thre_k2;
%k3_mask= k3 > Thre_k3;
%k4_mask= k4 > Thre_k4;
%k1=k1.*k1_mask;
%k2=k2.*k2_mask;
%k3=k3.*k3_mask;
%k4=k4.*k4_mask;
%k1_RE=k1_RE.*k1_mask;
%k2_RE=k2_RE.*k2_mask;
%k3_RE=k3_RE.*k3_mask;
%k4_RE=k4_RE.*k4_mask;

%% Validation test (there is the starting-point dependency!)
%x_gpu=single([0,1,2,3,4,5,6,7,8,9,10,15,20,25,30,40,50,60,70,80]);
%y_gpu=single([0;3.19;2.99;2.69;2.52;2.43;2.37;2.33;2.29;2.25;2.22;2.07;1.94;1.82;1.71;1.53;1.37;1.23;1.10;0.99]);
%initial_params=single([0.2;1.5;0.06;0.01]);
%constraints=single([0;2;0;2;0;2;0;2]);
%[parameters, states, chi_squares, n_iterations, time]...
%    = gpufit_constrained(y_gpu, [], model_id, initial_params, constraints, constraint_types, tolerance, max_n_iterations, [], estimator_id, x_gpu);
%fprintf('Fitted parameters = [%.2f, %.2f, %.2f, %.2f], SSE = %.2f \n', parameters, chi_squares);
% % k1=0.20, k2=1.49, k3=0.06, k4=0.01, SSE=0.0001
%x_data=double(transpose(x_gpu));
%y_data=double(y_gpu);
%options = optimoptions(@lsqcurvefit,'Algorithm','levenberg-marquardt', 'FunctionTolerance', 1e-9);
%[Estimates,SSE,Residual,d,e,f,Jacobian]=lsqcurvefit(@TTCM_vector, [0.5;0.5;0.05;0.05], x_data,y_data, [0;0;0;0], [2;2;2;2], options);
% % k1=0.20, k2=1.50, k3=0.06, k4=0.01, SSE=0.00007
%Fitted_X=transpose([0:0.01:85]);
%Fitted_TTCM_CPU=TTCM_vector(Estimates, Fitted_X);
%Fitted_TTCM_GPU=TTCM_vector(parameters, Fitted_X);
%Plot_Fitted_CPU=cat(2, Fitted_X, Fitted_TTCM_CPU);
%Plot_Fitted_GPU=cat(2, Fitted_X, Fitted_TTCM_GPU);
%Plot_measured=cat(2, x_data, y_data);

%% Generation of Early PI data using established database




%% Implementation of Ransac
%t1=clock;
%[k1_new,k2_new,k3_new,k4_new,k1_RE_new,k2_RE_new,k3_RE_new,k4_RE_new,REhist_k1_before,REhist_k1_after,REhist_k2_before,REhist_k2_after,REhist_k3_before,REhist_k3_after,REhist_k4_before,REhist_k4_after]=Perform_Ransac_2TCM(k1,k2,k3,k4,k1_RE,k2_RE,k3_RE,k4_RE,x_gpu, y_gpu,initial_params,constraints);
%t2=clock;
%etime(t2,t1)/60 % elapsed time [min]

%% saving outputs
save("k1.mat",'k1');
save("k2.mat",'k2');
save("k3.mat",'k3');
save("k4.mat",'k4');

%save("k1_RE.mat",'k1_RE');
%save("k2_RE.mat",'k2_RE');
%save("k3_RE.mat",'k3_RE');
%save("k4_RE.mat",'k4_RE');

%save("k1_new.mat",'k1_new');
%save("k2_new.mat",'k2_new');
%save("k3_new.mat",'k3_new');
%save("k4_new.mat",'k4_new');

%save("k1_RE_new.mat",'k1_RE_new');
%save("k2_RE_new.mat",'k2_RE_new');
%save("k3_RE_new.mat",'k3_RE_new');
%save("k4_RE_new.mat",'k4_RE_new');

%save("REhist_k1_before.mat",'REhist_k1_before');
%save("REhist_k1_after.mat",'REhist_k1_after');
%save("REhist_k2_before.mat",'REhist_k2_before');
%save("REhist_k2_after.mat",'REhist_k2_after');
%save("REhist_k3_before.mat",'REhist_k3_before');
%save("REhist_k3_after.mat",'REhist_k3_after');
%save("REhist_k4_before.mat",'REhist_k4_before');
%save("REhist_k4_after.mat",'REhist_k4_after');



end