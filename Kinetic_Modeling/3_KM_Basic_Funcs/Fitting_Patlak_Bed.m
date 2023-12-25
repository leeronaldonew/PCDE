function Fitting_Patlak_Bed(Bed_index, Num_Passes, Num_Beds, Vol_Multi_WB, Starting, LB, UB)
    
% Loading the Cell Arrays which are already made
switch Bed_index
    case 1
        kBq=load('kBq_Bed_1.mat');
        PI_Time=load('PI_Time_Bed_1.mat');
        C_tot_over_C_p=load('C_tot_over_C_p_Bed_1.mat');
        Integ_C_p_over_C_p=load('Integ_C_p_over_C_p_Bed_1.mat');
    case 2
        kBq=load('kBq_Bed_2.mat');
        PI_Time=load('PI_Time_Bed_2.mat');
        C_tot_over_C_p=load('C_tot_over_C_p_Bed_2.mat');
        Integ_C_p_over_C_p=load('Integ_C_p_over_C_p_Bed_2.mat');
    case 3
        kBq=load('kBq_Bed_3.mat');
        PI_Time=load('PI_Time_Bed_3.mat');
        C_tot_over_C_p=load('C_tot_over_C_p_Bed_3.mat');
        Integ_C_p_over_C_p=load('Integ_C_p_over_C_p_Bed_3.mat');
    case 4
        kBq=load('kBq_Bed_4.mat');
        PI_Time=load('PI_Time_Bed_4.mat');
        C_tot_over_C_p=load('C_tot_over_C_p_Bed_4.mat');
        Integ_C_p_over_C_p=load('Integ_C_p_over_C_p_Bed_4.mat');
    case 5
        kBq=load('kBq_Bed_5.mat');
        PI_Time=load('PI_Time_Bed_5.mat');
        C_tot_over_C_p=load('C_tot_over_C_p_Bed_5.mat');
        Integ_C_p_over_C_p=load('Integ_C_p_over_C_p_Bed_5.mat');
    case 6
        kBq=load('kBq_Bed_6.mat');
        PI_Time=load('PI_Time_Bed_6.mat');
        C_tot_over_C_p=load('C_tot_over_C_p_Bed_6.mat');
        Integ_C_p_over_C_p=load('Integ_C_p_over_C_p_Bed_6.mat');
    case 7
        kBq=load('kBq_Bed_7.mat');
        PI_Time=load('PI_Time_Bed_7.mat');
        C_tot_over_C_p=load('C_tot_over_C_p_Bed_7.mat');
        Integ_C_p_over_C_p=load('Integ_C_p_over_C_p_Bed_7.mat');
    case 8
        kBq=load('kBq_Bed_8.mat');
        PI_Time=load('PI_Time_Bed_8.mat');
        C_tot_over_C_p=load('C_tot_over_C_p_Bed_8.mat');
        Integ_C_p_over_C_p=load('Integ_C_p_over_C_p_Bed_8.mat');
    case 9
        kBq=load('kBq_Bed_9.mat');
        PI_Time=load('PI_Time_Bed_9.mat');
        C_tot_over_C_p=load('C_tot_over_C_p_Bed_9.mat');
        Integ_C_p_over_C_p=load('Integ_C_p_over_C_p_Bed_9.mat');
    case 10
        kBq=load('kBq_Bed_10.mat');
        PI_Time=load('PI_Time_Bed_10.mat');
        C_tot_over_C_p=load('C_tot_over_C_p_Bed_10.mat');
        Integ_C_p_over_C_p=load('Integ_C_p_over_C_p_Bed_10.mat');
    end


% Names for each Pass and Bed
for p=1:1:Num_Passes
    Names_Passes(p)="Pass_" +p;
end
for i=1:1:Num_Beds
    Names_Beds(i)="Bed_" + i;
end

% Getting size info.
for i=1:1:Num_Beds
    Size_Beds{i,1}=size(Vol_Multi_WB.Pass_1{i, 1}); % based on assumption that sizes of each bed are different each other but the trend remains same for all passes  
end


% Patlak Analysis
for b=1:1:Num_Beds
    vol_size=Size_Beds{b,1};
    Parametric_Patlak=cell(vol_size);
    K_i=zeros(vol_size);
    V_d=zeros(vol_size);

    for N=1:1:prod(vol_size)
        k=floor( ( (N-1)/(vol_size(1)*vol_size(2)) ) + 1 );
        j=floor( ( (N-1) / vol_size(1) ) + 1 - (vol_size(2)*(k-1)) );
        i= ( N-(vol_size(1)*(j-1)) - (vol_size(1)*vol_size(2)*(k-1)) ) ;
        
        % using anonymous function with lsqcurvefit
        %[Estimates,SSE,Residual,d,e,f,Jacobian]=lsqcurvefit(@Patlak_vector, Starting, WB_PI_Time{i,j,k},WB_Concent{i,j,k}, LB, UB);
        %Parametric_Patlak{i,j,k}=[Estimates,SSE,Residual,d,e,f,Jacobian];

        % using polyfit or polyfitn
        Parametric_Patlak{i,j,k}=polyfitn(Integ_C_p_over_C_p.Integ_C_p_over_C_p{i,j,k},C_tot_over_C_p.C_tot_over_C_p{i,j,k},1);
    end


end





end