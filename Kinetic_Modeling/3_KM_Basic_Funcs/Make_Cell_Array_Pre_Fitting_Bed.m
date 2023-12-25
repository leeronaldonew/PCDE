function Make_Cell_Array_Pre_Fitting_Bed(Num_Passes,Num_Beds,Vol_WB,Vol_Multi_WB,Times_Multi_WB, Tracer_Injection_Time) 
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
for i=1:1:Num_Beds
    Names_Vol__Pre_Fitting_Beds(i)="Vol_Pre_Fitting_Bed_" + i;
end

%for i=1:1:Num_Beds
%    for p=1:1:Num_Passes
%        Times_Fitting_at_each_Bed.(Names_Beds(i))(p,1)=Vol_Multi_WB.(Names_Passes(p)){i,2};
%    end
%end

% Extracting Voxel Values at each Bed position
Size_WB=size(Vol_WB.Pass_1{1,1});
for i=1:1:Num_Beds
    Size_Beds{i,1}=size(Vol_Multi_WB.Pass_1{i, 1}); % based on assumption that sizes of each bed are different each other but the trend remains same for all passes  
end
for b=1:1:Num_Beds    
    Vol_kBq_Pre_Fitting_Bed=cell(Size_Beds{b,1});
    for p=1:1:Num_Passes
        for k=1:1:size(Vol_kBq_Pre_Fitting_Bed, 3) % for Z-axis
            for j=1:1:size(Vol_kBq_Pre_Fitting_Bed, 2)% for X-axis
                for i=1:1:size(Vol_kBq_Pre_Fitting_Bed, 1) % for Y-axis
                    Vol_kBq_Pre_Fitting_Bed{i,j,k}(p,1)=0.001*Vol_WB.(Names_Passes(p)){1,1}(i,j,k); % Saving Voxel values as a unit of [kBq/ml]
                end
            end
        end
    end
    save("Vol_kBq_Pre_Fitting_"+Names_Beds(b) +".mat",'Vol_kBq_Pre_Fitting_Bed');
    %clear Vol_kBq_Pre_Fitting_Bed; % for saving memory!
end

% Converting HHMMSS into PI [min] time
for p=1:1:Num_Passes
    PI_Times_Multi_WB.(Names_Passes(p))=Convert_HHMMSS_into_PI_min(Times_Multi_WB.(Names_Passes(p)), Tracer_Injection_Time);
end
% Extracting PI times at each Bed position
for b=1:1:Num_Beds  
    PI_Time_Pre_Fitting_Bed=cell(Size_Beds{b,1});
    PI_Time_Pre_Fitting_Bed_temp=zeros(Num_Passes,1);
    for p=1:1:Num_Passes
        PI_Time_Pre_Fitting_Bed_temp(p,1)=PI_Times_Multi_WB.(Names_Passes(p))(1,b);
    end
    for k=1:1:size(PI_Time_Pre_Fitting_Bed, 3) % for Z-axis
        for j=1:1:size(PI_Time_Pre_Fitting_Bed, 2)% for X-axis
            for i=1:1:size(PI_Time_Pre_Fitting_Bed, 1) % for Y-axis
                for p=1:1:Num_Passes
                    PI_Time_Pre_Fitting_Bed{i,j,k}=PI_Time_Pre_Fitting_Bed_temp;
                end
            end
        end
    end
    save("PI_Time_Pre_Fitting_"+Names_Beds(b) +".mat",'PI_Time_Pre_Fitting_Bed');
    %clear PI_Time_Pre_Fitting_Bed; % for saving memory!
end

% Making Arrays of Feng_values and Integration of Feng.eq as a pre-processing for the reduced fitting time
global Local_Estimates;
Func_Feng=@(tau) Feng(Local_Estimates,tau);
for b=1:1:Num_Beds  
    Feng_values=cell(Size_Beds{b,1}); % initialization
    C_p_integral=cell(Size_Beds{b,1}); % initialization
    Feng_values_temp=zeros(Num_Passes,1); % initialization
    C_p_integral_temp=zeros(Num_Passes,1); % initialization
    Feng_values_temp=Feng(Local_Estimates,PI_Time_Pre_Fitting_Bed{1,1,1});
    for p=1:1:Num_Passes
        C_p_integral_temp(p,1)=integral(Func_Feng, 0, PI_Time_Pre_Fitting_Bed{1,1,1}(p,1), 'ArrayValued',true);
    end 
    for k=1:1:size(Feng_values, 3) % for Z-axis
        for j=1:1:size(Feng_values, 2)% for X-axis
            for i=1:1:size(Feng_values, 1) % for Y-axis
                Feng_values{i,j,k}=Feng_values_temp;
                C_p_integral{i,j,k}=C_p_integral_temp;
            end
        end
    end
    save("Feng_values_"+Names_Beds(b) +".mat",'Feng_values');
    save("C_p_integral_"+Names_Beds(b) +".mat",'C_p_integral');

end



end