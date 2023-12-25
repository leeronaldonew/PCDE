function [RE, se_update]=Get_RE(J, parameters, chi_squares,Num_Passes, Num_inlier,inlierIdx_update ,model_index)
% Model Index: 1 for Patlak, 2 for 2TCM
warning('off');
%warning('off','MATLAB:nearlySingularMatrix');

Num_fits=size(chi_squares,2);
n = Num_Passes; % Num of data points
p = size(parameters,1); % Num of prameters
%v = n-p; % degree of freedom
DOF=Num_inlier-p; % DOF
%DOF(DOF<1)=1;

switch model_index
    case 1 % for Patlak
        % Calculate covariance matrix & SE
        J_intercept=reshape(J(:,1),n,Num_fits);
        J_slope=reshape(J(:,2),n,Num_fits);
        J_voxel=single(zeros(n,p));
    
        for i=1:1:Num_fits
            J_voxel=[J_intercept(:,i), J_slope(:,i)];
            chi_squares_voxel=chi_squares(1,i);

            rm_ind=find(~inlierIdx_update(:,i)); % finding outlier's Jacobian value and removing it!
            J_voxel(rm_ind,:)=[];

            if chi_squares_voxel==0
                se=single([0;0]);
            else
                % Approximation when a column is zero vector
                temp = find(max(abs(J_voxel)) == 0);
                if ~isempty(temp)
                    J_voxel(:,temp) = sqrt(eps(class(J_voxel)));
                end
                [~,R] = qr(J_voxel,0);
                Rinv = R\eye(size(R));
                diag_info = sum(Rinv.*Rinv,2);
                rmse = sqrt(chi_squares_voxel) / sqrt(DOF(i));
                se = sqrt(diag_info) * rmse;
            end

            if i==1
                se_update = se;
            else
                se_update=cat(2, se_update, se);
            end
        end
        % calc. of Relative Error[%]
        RE=se_update./abs(parameters) *100;
        RE(isnan(RE)) = 0 ; % dealing with zero/zero as zero SE[%]
        RE(isinf(RE)) = 0 ; % dealing with zero denominator as zero SE[%]
        

    case 2 % for 2TCM
        % Calculate covariance matrix & SE
        J_k1=reshape(J(:,1),n,Num_fits);
        J_k2=reshape(J(:,2),n,Num_fits);
        J_k3=reshape(J(:,3),n,Num_fits);
        J_k4=reshape(J(:,4),n,Num_fits);
        J_voxel=zeros(n,p);

        for i=1:1:Num_fits
            J_voxel=double([J_k1(:,i),J_k2(:,i),J_k3(:,i),J_k4(:,i)]);
            chi_squares_voxel=chi_squares(1,i);

            rm_ind=find(~inlierIdx_update(:,i)); % finding outlier's Jacobian value and removing it!
            J_voxel(rm_ind,:)=[];

            if chi_squares_voxel==0
                se=single([0;0]);
            else
                % Approximation when a column is zero vector
                temp = find(max(abs(J_voxel)) == 0);
                if ~isempty(temp)
                    J_voxel(:,temp) = sqrt(eps(class(J_voxel)));
                end
                [~,R] = qr(J_voxel,0);
                Rinv = R\eye(size(R));
                diag_info = sum(Rinv.*Rinv,2);
                rmse = sqrt(chi_squares_voxel) / sqrt(DOF(i));
                se = sqrt(diag_info) * rmse;
            end

            if i==1
                se_update = se;
            else
                se_update=cat(2, se_update, se);
            end
        end
        % calc. of Relative Error[%]
        RE=se_update./abs(parameters) *100;
        RE(isnan(RE)) = 0 ; % dealing with zero/zero as zero SE[%]
        RE(isinf(RE)) = 0 ; % dealing with zero denominator as zero SE[%]


end




end