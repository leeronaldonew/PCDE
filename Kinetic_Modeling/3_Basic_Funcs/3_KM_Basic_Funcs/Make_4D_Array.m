function Make_4D_Array(Num_Passes,Num_Beds,Vol_WB,Vol_Multi_WB,Times_Multi_WB, Tracer_Injection_Time, Decay_ind, lamda) 

% Pre-processing
for p=1:1:Num_Passes
    Names_Passes(p)="Pass_" +p;
end
Num_Beds=size(Vol_Multi_WB.Pass_1,1);
for i=1:1:Num_Beds
    Names_Beds(i)="Bed_" + i;
end
Size_WB=size(Vol_WB.Pass_1{1,1});
for i=1:1:Num_Beds
    Size_Beds{i,1}=size(Vol_Multi_WB.Pass_1{i, 1}); % based on assumption that sizes of each bed are different each other but the trend remains same for all passes  
end


%% for PI_Time [min]
% Converting HHMMSS into PI [min] time
for p=1:1:Num_Passes
    PI_Times_Multi_WB.(Names_Passes(p))=Convert_HHMMSS_into_PI_min(Times_Multi_WB.(Names_Passes(p)), Tracer_Injection_Time);
end
% initialization
PI_Time=single(zeros(Size_WB(1),Size_WB(2),Size_WB(3),Num_Passes)); 
PI_Time_temp=single(zeros(Size_WB(1),Size_WB(2),Size_WB(3))); 
%for k=1:1:Size_WB(3)
%% Getting b (bed index) from k (slice index)
%b=Get_b_from_k(k, Size_Beds);
%    for j=1:1:Size_WB(2)
%        for i=1:1:Size_WB(1)
%            for p=1:1:Num_Passes
%                PI_Time(i,j,k,p)=single(PI_Times_Multi_WB.(Names_Passes(p))(b));
%            end
%        end
%    end
%end
for p=1:1:Num_Passes
    for k=1:1:Size_WB(3)
        b=Get_b_from_k(k, Size_Beds);
        PI_Time_temp(:,:,k)=single(PI_Times_Multi_WB.(Names_Passes(p))(b));
    end
    if p==1
        PI_Time=PI_Time_temp;
    else
        PI_Time=cat(4, PI_Time, PI_Time_temp);
    end
end
%% saving
save("PI_Time.mat",'PI_Time','-v7.3','-nocompression');
save("PI_Times_Multi_WB.mat", 'PI_Times_Multi_WB', '-v7.3', '-nocompression');


%% for kBq [kBq/ml]
if Decay_ind ==1
    kBq=single(zeros(Size_WB(1),Size_WB(2),Size_WB(3),Num_Passes));
    kBq_temp=single(zeros(Size_WB(1),Size_WB(2),Size_WB(3)));
    for p=1:1:Num_Passes
        kBq_temp=single( (0.001*Vol_WB.(Names_Passes(p)){1,1}).*exp(lamda.*PI_Time(:,:,:,p)) ) ; % Decay Correction
        if p==1
            kBq=kBq_temp;
        else
            kBq=cat(4, kBq, kBq_temp);
        end
    end 
else
    kBq=single(zeros(Size_WB(1),Size_WB(2),Size_WB(3),Num_Passes));
    kBq_temp=single(zeros(Size_WB(1),Size_WB(2),Size_WB(3)));
    for p=1:1:Num_Passes
        kBq_temp=single(0.001*Vol_WB.(Names_Passes(p)){1,1});
        if p==1
            kBq=kBq_temp;
        else
            kBq=cat(4, kBq, kBq_temp);
        end
    end 
end

%% saving
save("kBq.mat",'kBq','-v7.3','-nocompression');


%% for C_tot_over_C_p
global Local_Estimates;
%Func_Feng=@(tau) Feng(Local_Estimates,tau);
Func_Exp_4=@(tau) Exp_4(Local_Estimates,tau);
for p=1:1:Num_Passes
    for b=1:1:Num_Beds
        %C_p_values.(Names_Passes(p))(b)=Func_Feng(PI_Times_Multi_WB.(Names_Passes(p))(b));
        C_p_values.(Names_Passes(p))(b)=Func_Exp_4(PI_Times_Multi_WB.(Names_Passes(p))(b));
    end
end
for p=1:1:Num_Passes
    for b=1:1:Num_Beds
        %Integ_C_p_values.(Names_Passes(p))(b)=integral(Func_Feng, 0, PI_Times_Multi_WB.(Names_Passes(p))(b), 'ArrayValued',true);
        Integ_C_p_values.(Names_Passes(p))(b)=integral(Func_Exp_4, 0, PI_Times_Multi_WB.(Names_Passes(p))(b), 'ArrayValued',true);
    end
end

%C_tot_over_C_p=single(zeros(Size_WB(1),Size_WB(2),Size_WB(3),Num_Passes)); % initialization
%for k=1:1:Size_WB(3)
%    b=Get_b_from_k(k, Size_Beds);
%    for j=1:1:Size_WB(2)
%        for i=1:1:Size_WB(1)
%            for p=1:1:Num_Passes
%                C_tot_over_C_p(i,j,k,p)=( 0.001*Vol_WB.(Names_Passes(p)){1,1}(i,j,k) ) / (  C_p_values.(Names_Passes(p))(b)  )   ;
%            end
%        end
%    end
%end
C_tot_over_C_p=single(zeros(Size_WB(1),Size_WB(2),Size_WB(3),Num_Passes)); % initialization
C_tot_over_C_p_temp=single(zeros(Size_WB(1),Size_WB(2),Size_WB(3))); % initialization

if Decay_ind==1
   for p=1:1:Num_Passes
        for k=1:1:Size_WB(3)
            b=Get_b_from_k(k, Size_Beds);
            C_tot_over_C_p_temp(:,:,k)=single( ( 0.001*Vol_WB.(Names_Passes(p)){1,1}(:,:,k).*exp(lamda.*PI_Time(:,:,k,p))  ) / (  C_p_values.(Names_Passes(p))(b)  )); % Decay Correction
        end
        if p==1
            C_tot_over_C_p=C_tot_over_C_p_temp;
        else
            C_tot_over_C_p=cat(4, C_tot_over_C_p, C_tot_over_C_p_temp);
        end
   end
else
    for p=1:1:Num_Passes
        for k=1:1:Size_WB(3)
            b=Get_b_from_k(k, Size_Beds);
            C_tot_over_C_p_temp(:,:,k)=single(( 0.001*Vol_WB.(Names_Passes(p)){1,1}(:,:,k) ) / (  C_p_values.(Names_Passes(p))(b)  ));
        end
        if p==1
            C_tot_over_C_p=C_tot_over_C_p_temp;
        else
            C_tot_over_C_p=cat(4, C_tot_over_C_p, C_tot_over_C_p_temp);
        end
    end
end


%% saving
save("C_tot_over_C_p.mat",'C_tot_over_C_p','-v7.3','-nocompression');

%% for Integ_C_p_over_C_p
Integ_C_p_over_C_p=single(zeros(Size_WB(1),Size_WB(2),Size_WB(3),Num_Passes)); % initialization
Integ_C_p_over_C_p_temp=single(zeros(Size_WB(1),Size_WB(2),Size_WB(3))); % initialization
for p=1:1:Num_Passes
    for k=1:1:Size_WB(3)
        b=Get_b_from_k(k, Size_Beds);
        Integ_C_p_over_C_p_temp(:,:,k)=single(( Integ_C_p_values.(Names_Passes(p))(b) ) / (  C_p_values.(Names_Passes(p))(b)  ) );
    end
    if p==1
        Integ_C_p_over_C_p=Integ_C_p_over_C_p_temp;
    else
        Integ_C_p_over_C_p=cat(4, Integ_C_p_over_C_p, Integ_C_p_over_C_p_temp);
    end
end
%% saving
save("Integ_C_p_over_C_p.mat",'Integ_C_p_over_C_p','-v7.3','-nocompression');


% Resizing the 4D volumes
%C_tot_over_C_p_origin=C_tot_over_C_p;
%Integ_C_p_over_C_p_origin=Integ_C_p_over_C_p;
%kBq_origin=kBq;
%PI_Time_origin=PI_Time;

%clear C_tot_over_C_p Integ_C_p_over_C_p;
%clear kBq PI_Time;

%for p=1:1:Num_Passes
%    C_tot_over_C_p(:,:,:,p)=imresize3(C_tot_over_C_p_origin(:,:,:,p),0.5);
%    Integ_C_p_over_C_p(:,:,:,p)=imresize3(Integ_C_p_over_C_p_origin(:,:,:,p),0.5);
%    kBq(:,:,:,p)=imresize3(kBq_origin(:,:,:,p),0.5);
%    PI_Time(:,:,:,p)=imresize3(PI_Time_origin(:,:,:,p),0.5);
%end
%save("C_tot_over_C_p_half.mat",'C_tot_over_C_p','-v7.3','-nocompression');
%save("Integ_C_p_over_C_p_half.mat",'Integ_C_p_over_C_p','-v7.3','-nocompression');
%save("kBq_half.mat",'kBq','-v7.3','-nocompression');
%save("PI_Time_half.mat",'PI_Time','-v7.3','-nocompression');


%% Saving Decay Corrected "Vol_Multi_WB"

if Decay_ind==1
    for p=1:1:Num_Passes
        for b=1:1:Num_Beds
             Vol_Multi_WB_PCDE.(Names_Passes(p)){b,1}=0.001.*Vol_Multi_WB.(Names_Passes(p)){b,1} .* exp(lamda.*PI_Times_Multi_WB.(Names_Passes(p))(1,b)); % Decay Correction! & converting into [kBq/ml]
             Vol_Multi_WB_PCDE.(Names_Passes(p)){b,2}=Vol_Multi_WB.(Names_Passes(p)){b,2};
        end
    end
else
   for p=1:1:Num_Passes
        for b=1:1:Num_Beds
             Vol_Multi_WB_PCDE.(Names_Passes(p)){b,1}=0.001.*Vol_Multi_WB.(Names_Passes(p)){b,1}; % Converting into [kBq/ml]
             Vol_Multi_WB_PCDE.(Names_Passes(p)){b,2}=Vol_Multi_WB.(Names_Passes(p)){b,2};
        end
    end
end

save("Vol_Multi_WB_PCDE.mat",'Vol_Multi_WB_PCDE','-v7.3','-nocompression'); % [kBq/ml]










end