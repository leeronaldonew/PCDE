function [x_gpu, y_gpu, initial_params_gpu, constraints_gpu]=Make_GPUfit_Input(x_4D, y_4D, starting, lb, ub, model)

Sizes_4D=size(x_4D);
Num_Passes=Sizes_4D(4);
Num_x=Sizes_4D(2);
Num_y=Sizes_4D(1);
Num_z=Sizes_4D(3);

%% for x_gpu & y_gpu
for p=1:1:Num_Passes
    vec_x=reshape(x_4D(:,:,:,p), 1, Num_x*Num_y*Num_z);
    vec_y=reshape(y_4D(:,:,:,p), 1, Num_x*Num_y*Num_z);
    if p==1
        vec_update_x=vec_x;
        vec_update_y=vec_y;
    else
        vec_update_x=vertcat(vec_update_x,vec_x);
        vec_update_y=vertcat(vec_update_y,vec_y);
    end
end
x_gpu=single(reshape(vec_update_x, 1, Num_x*Num_y*Num_z*Num_Passes));
y_gpu=single(vec_update_y);

%% for initial_params_gpu & constraints_gpu
num_params=size(starting,1);
num_fits=Num_x*Num_y*Num_z;
switch model
    case 1 % for Patlak
        starting_g(1,1)=starting(2); % for intercept
        starting_g(2,1)=starting(1); % for slope
        initial_params_gpu=single(repmat(starting_g,1, num_fits));
        bound=single(zeros(2*num_params,1));
        bound(1,1)=lb(2); % for intercept
        bound(2,1)=ub(2);
        bound(3,1)=lb(1); % for slope
        bound(4,1)=ub(1);   
        constraints_gpu = single(repmat(bound,1, num_fits));
    case 2 % for 2TCM
        initial_params_gpu=single(repmat(starting,1, num_fits));
        bound=single(zeros(2*num_params,1));
        bound(1,1)=lb(1); % for K1
        bound(2,1)=ub(1);
        bound(3,1)=lb(2); % for K2
        bound(4,1)=ub(2);
        bound(5,1)=lb(3); % for K3
        bound(6,1)=ub(3);
        bound(7,1)=lb(4); % for K4
        bound(8,1)=ub(4);
        constraints_gpu = single(repmat(bound,1, num_fits));
    case 3 % C-A*exp(-B*t) // X care about entered "starting" b/c we need different "starting" depending on voxels
        dims=size(y_4D);
        initial_params_gpu=zeros(3,dims(1)*dims(2)*dims(3),'single');

        for k=1:1:dims(3)
            for j=1:1:dims(2)
                for i=1:1:dims(1)
                    %tic;
                    Ct=squeeze(y_4D(i,j,k,:));
                    if Ct(1,1) > Ct(1,end) % Neg. Slope
                        Starting=[-1*max(Ct(1,:));0;0];
                    else % Pos. Slope
                        Starting=[0;0;max(Ct(1,:))];
                    end
                    if i==1 & j==1 & k==1
                        initial_params_gpu=Starting;
                    else
                        initial_params_gpu=cat(2,initial_params_gpu,Starting);
                    end    
                    %toc;
                end
            end
        end
        bound=single(zeros(2*3,1));
        bound(1,1)=lb(1); % for A
        bound(2,1)=ub(1);
        bound(3,1)=lb(2); % for B
        bound(4,1)=ub(2);
        bound(5,1)=lb(3); % for C
        bound(6,1)=ub(3);
        constraints_gpu = single(repmat(bound,1, dims(1)*dims(2)*dims(3)));

       


end












end



