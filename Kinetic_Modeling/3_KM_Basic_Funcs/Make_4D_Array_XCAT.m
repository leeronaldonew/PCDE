function Make_4D_Array_XCAT(Num_Passes, Num_Beds, PI_Times_PCDE, Vol_Multi_WB, WB_Vol, Unit_ind)
for p=1:1:Num_Passes
    Names_Passes(p)="Pass_" +p;
end
Size_WB=size(WB_Vol.Pass_1{1,1});
%% for kBq [kBq/ml]
if Unit_ind == 1 % when using [Bq/ml] XCAT Image
    kBq=single(zeros(Size_WB(1),Size_WB(2),Size_WB(3),Num_Passes));
    kBq_temp=single(zeros(Size_WB(1),Size_WB(2),Size_WB(3)));
    for p=1:1:Num_Passes
        kBq_temp=single(0.001*WB_Vol.(Names_Passes(p)){1,1}); % converting into [kBq/ml]
        if p==1
            kBq=kBq_temp;
        else
            kBq=cat(4, kBq, kBq_temp);
        end
    end 
elseif Unit_ind==2 % when using [kBq/ml] XCAT Image
    kBq=single(zeros(Size_WB(1),Size_WB(2),Size_WB(3),Num_Passes));
    kBq_temp=single(zeros(Size_WB(1),Size_WB(2),Size_WB(3)));
    for p=1:1:Num_Passes
        kBq_temp=single(WB_Vol.(Names_Passes(p)){1,1}); % maintaining [kBq/ml]
        if p==1
            kBq=kBq_temp;
        else
            kBq=cat(4, kBq, kBq_temp);
        end
    end 
end

%% saving
save("kBq.mat",'kBq','-v7.3','-nocompression');


%% for PI_Time [min]
for i=1:1:Num_Beds
    Size_Beds{i,1}=size(Vol_Multi_WB.Pass_1{i, 1}); % based on assumption that sizes of each bed are different each other but the trend remains same for all passes  
end
% Converting HHMMSS into PI [min] time
for p=1:1:Num_Passes
    PI_Times_Multi_WB.(Names_Passes(p))=PI_Times_PCDE(p,:);
end
% initialization
PI_Time=single(zeros(Size_WB(1),Size_WB(2),Size_WB(3),Num_Passes)); 
PI_Time_temp=single(zeros(Size_WB(1),Size_WB(2),Size_WB(3))); 
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




end