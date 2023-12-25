function Make_Cell_Array(Num_Passes,Num_Beds,Vol_WB,Vol_Multi_WB,Times_Multi_WB, Tracer_Injection_Time) 
% Making Cell Array of Volume at each Bed position and Making Cell Array of Time at each Bed position for Fitting & Saving the Arrays into seperate files
% Cell Array of Volume: Unit==> [kBq/ml]
% Cell Array of Time: Unit ==> [min]


% Pre-processing for fitting
for p=1:1:Num_Passes
    Names_Passes(p)="Pass_" +p;
end
Num_Beds=size(Vol_Multi_WB.Pass_1,1);
for i=1:1:Num_Beds
    Names_Beds(i)="Bed_" + i;
end

%for i=1:1:Num_Beds
%    Names_Vol__Pre_Fitting_Beds(i)="Vol_Pre_Fitting_Bed_" + i;
%end
%for i=1:1:Num_Beds
%    for p=1:1:Num_Passes
%        Times_Fitting_at_each_Bed.(Names_Beds(i))(p,1)=Vol_Multi_WB.(Names_Passes(p)){i,2};
%    end
%end

% Extracting Voxel Values
Size_WB=size(Vol_WB.Pass_1{1,1});
for i=1:1:Num_Beds
    Size_Beds{i,1}=size(Vol_Multi_WB.Pass_1{i, 1}); % based on assumption that sizes of each bed are different each other but the trend remains same for all passes  
end
for b=1:1:Num_Beds
    kBq=cell(Size_Beds{b,1});
    for k=1:1:Size_Beds{b,1}(3) 
        for j=1:1:Size_Beds{b,1}(2)
            for i=1:1:Size_Beds{b,1}(1)
                for p=1:1:Num_Passes
                    kBq{i,j,k}(p,1)=0.001*Vol_Multi_WB.(Names_Passes(p)){b,1}(i,j,k); % Saving Voxel values as a unit of [kBq/ml]
                end
            end
        end
    end    
    save("kBq_"+Names_Beds(b)+".mat",'kBq');
end

% Converting HHMMSS into PI [min] time
for p=1:1:Num_Passes
    PI_Times_Multi_WB.(Names_Passes(p))=Convert_HHMMSS_into_PI_min(Times_Multi_WB.(Names_Passes(p)), Tracer_Injection_Time);
end
% Extracting PI times (Max. # of allowable beds: 10)
for b=1:1:Num_Beds
    PI_Time=cell(Size_Beds{b,1});
    for k=1:1:Size_Beds{b,1}(3)
        for j=1:1:Size_Beds{b,1}(2)
            for i=1:1:Size_Beds{b,1}(1)
                for p=1:1:Num_Passes
                    PI_Time{i,j,k}(p,1)=PI_Times_Multi_WB.(Names_Passes(p))(b);
                end
            end
        end
    end
    save("PI_Time_"+Names_Beds(b)+".mat",'PI_Time');
end

% Making Arrays of Feng_values and Integration of Feng.eq as a pre-processing for the reduced fitting time
global Local_Estimates;
Func_Feng=@(tau) Feng(Local_Estimates,tau);

for p=1:1:Num_Passes
    for b=1:1:Num_Beds
        C_p_values.(Names_Passes(p))(b)=Func_Feng(PI_Times_Multi_WB.(Names_Passes(p))(b));
    end
end
for p=1:1:Num_Passes
    for b=1:1:Num_Beds
        Integ_C_p_values.(Names_Passes(p))(b)=integral(Func_Feng, 0, PI_Times_Multi_WB.(Names_Passes(p))(b), 'ArrayValued',true);
    end
end

for b=1:1:Num_Beds
    C_tot_over_C_p=cell(Size_Beds{b,1});
    for k=1:1:Size_Beds{b,1}(3)
        for j=1:1:Size_Beds{b,1}(2)
            for i=1:1:Size_Beds{b,1}(1)
                for p=1:1:Num_Passes
                    C_tot_over_C_p{i,j,k}(p,1)= ( 0.001*Vol_Multi_WB.(Names_Passes(p)){b,1}(i,j,k) ) / ( C_p_values.(Names_Passes(p))(b) ) ;
                end
            end
        end
    end
    save("C_tot_over_C_p_"+Names_Beds(b)+".mat",'C_tot_over_C_p');
end

for b=1:1:Num_Beds
    Integ_C_p_over_C_p=cell(Size_Beds{b,1});  
    for k=1:1:Size_Beds{b,1}(3)
        for j=1:1:Size_Beds{b,1}(2)
            for i=1:1:Size_Beds{b,1}(1)
                for p=1:1:Num_Passes
                    Integ_C_p_over_C_p{i,j,k}(p,1)=( Integ_C_p_values.(Names_Passes(p))(b) ) / ( C_p_values.(Names_Passes(p))(b) );
                end
            end
        end
    end
    save("Integ_C_p_over_C_p_"+Names_Beds(b)+".mat",'Integ_C_p_over_C_p');
end








end


