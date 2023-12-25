function [Parametric_Vol]=Gen_Parametric_Vol(PI_Time, Vol_kBq, Feng_values_input, C_p_integral_input, Model, Starting, LB, UB)
global Feng_values;
global C_p_integral;
Feng_values=Feng_values_input{1,1,1}; % in the same Bed position, they have same Feng_values (b/c of same time)
C_p_integral=C_p_integral_input{1,1,1}; % in the same Bed position, they have same C_p_integral (b/c of same time)

vol_size=size(PI_Time);
Parametric_Vol=cell(vol_size);

    switch Model
        case 1 % Patlak Analysis
            % for using just lsqcurvefit with anonymous function
            %for N=1:1:prod(vol_size)
            %    k=floor( ( (N-1)/(vol_size(1)*vol_size(2)) ) + 1 );
            %    j=floor( ( (N-1) / vol_size(1) ) + 1 - (vol_size(2)*(k-1)) );
            %    i= ( N-(vol_size(1)*(j-1)) - (vol_size(1)*vol_size(2)*(k-1)) ) ;
            %    [Estimates,SSE,Residual,d,e,f,Jacobian]=lsqcurvefit(@Patlak_vector, Starting, PI_Time{i,j,k},Vol_kBq{i,j,k}, LB, UB);
            %    Parametric_Vol{i,j,k}=Estimates;
            %end
            
            % for using parfor with polyfit or polyfitn (X using anonymous function) 
            parfor N=1:1:prod(vol_size)
                k=floor( ( (N-1)/(vol_size(1)*vol_size(2)) ) + 1 );
                j=floor( ( (N-1) / vol_size(1) ) + 1 - (vol_size(2)*(k-1)) );
                i= ( N-(vol_size(1)*(j-1)) - (vol_size(1)*vol_size(2)*(k-1)) ) ;
                [Estimates,SSE,Residual,d,e,f,Jacobian]=lsqcurvefit(@Patlak_vector, Starting, PI_Time{i,j,k},Vol_kBq{i,j,k}, LB, UB);
                Parametric_Vol{i,j,k}=Estimates;
            end



        case 2 % TTCM (using general eq.)
            for N=1:1:prod(vol_size)
                k=floor( ( (N-1)/(vol_size(1)*vol_size(2)) ) + 1 );
                j=floor( ( (N-1) / vol_size(1) ) + 1 - (vol_size(2)*(k-1)) );
                i= ( N-(vol_size(1)*(j-1)) - (vol_size(1)*vol_size(2)*(k-1)) ) ;
                [Estimates,SSE,Residual,d,e,f,Jacobian]=lsqcurvefit(@TTCM_vector, Starting, PI_Time{i,j,k},Vol_kBq{i,j,k}, LB, UB);
                Parametric_Vol{i,j,k}=Estimates;
            end
    end







end