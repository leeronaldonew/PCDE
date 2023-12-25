function [Num_Passes, Num_Beds, PI_Times_PCDE, Vol_Multi_WB, WB_Vol]= Import_Binary_XCAT(xdim,ydim,zdim, Decay_ind,lamda)

% Please use Folder Names as follows (for each Pass Data!)
% P1, P2, P3, .. P20


paths=uigetdir2(); % Importing Multiple Folders using the code downloaded from MathWorks File Exchange (i.e., not my code!)

for i=1:1:size(paths,2)
    files_temp{i,1}=dir(fullfile(paths{1,i},'*.bin'));
    files_temp_cell{i,1}=struct2cell(files_temp{i,1});   
    for j=1:1:size(files_temp_cell{i,1},2)
        files{i,1}{1,j}=files_temp_cell{i,1}{1,j};
    end
end
Num_Passes=size(paths,2);
Num_Beds=6; % assuming it when using XCAT Phantom Images


for p=1:1:Num_Passes
    Names_Passes(p)="Pass_" +p;
end

%% Open Binary Files
for i=1:1:Num_Passes
    fileID=fopen( append(paths{1,i},'\',files{i,1}{1,1}), 'r' );
    Input_temp = fread(fileID, xdim*ydim*zdim, 'float32', 'ieee-le'); % Refer to XCAT instruction!
    Input_temp= reshape(Input_temp,xdim,ydim,zdim);
    Input_Vol{i,1}=imrotate3(flip(Input_temp,3), 90, [0 0 1]);
end


%% Gen. of "PI_Times_PCDE"
Time_temp=[10:5:10+(Num_Passes-1)*5];
for p=1:1:Num_Passes
    for b=1:1:6
        PI_Times_PCDE(p,b)=Time_temp(1,p);
    end
end

%% Gen. of "Vol_Multi_WB" & "WB_Vol"
%Names_Passes=["Pass_1", "Pass_2","Pass_3","Pass_4","Pass_5","Pass_6","Pass_7","Pass_8","Pass_9","Pass_10","Pass_11","Pass_12","Pass_13","Pass_14","Pass_15", "Pass_16","Pass_17","Pass_18","Pass_19","Pass_20"];

for i=1:1:Num_Passes
    newStr = split(paths{1,i},'\');
    Fold_name=newStr{size(newStr,1),1};

    switch Fold_name
        case 'P1' % 1st Pass
            WB_Vol.Pass_1{1,1}=Input_Vol{i,1};       
            Tot_Slices_WB=size(WB_Vol.Pass_1{1,1},3);
            Num_Slices_per_Bed=floor(Tot_Slices_WB/Num_Beds); % Assuming 6 Beds!
            for b=1:1:6
                if b==6
                    Vol_Multi_WB.Pass_1{b,1}=WB_Vol.Pass_1{1,1}(:,:,(Num_Slices_per_Bed*(b-1)+1):(Tot_Slices_WB) );
                    Vol_Multi_WB.Pass_1{b,2}='001000';
                else
                    Vol_Multi_WB.Pass_1{b,1}=WB_Vol.Pass_1{1,1}(:,:,(Num_Slices_per_Bed*(b-1)+1):(Num_Slices_per_Bed*b) );
                    Vol_Multi_WB.Pass_1{b,2}='001000';
                end   
            end
        case 'P2'
            WB_Vol.Pass_2{1,1}=Input_Vol{i,1};    
            Tot_Slices_WB=size(WB_Vol.Pass_2{1,1},3);
            Num_Slices_per_Bed=floor(Tot_Slices_WB/Num_Beds); % Assuming 6 Beds!
            for b=1:1:6
                if b==6
                    Vol_Multi_WB.Pass_2{b,1}=WB_Vol.Pass_2{1,1}(:,:,(Num_Slices_per_Bed*(b-1)+1):(Tot_Slices_WB) );
                    Vol_Multi_WB.Pass_2{b,2}='001500';
                else
                    Vol_Multi_WB.Pass_2{b,1}=WB_Vol.Pass_2{1,1}(:,:,(Num_Slices_per_Bed*(b-1)+1):(Num_Slices_per_Bed*b) );
                    Vol_Multi_WB.Pass_2{b,2}='001500';
                end   
            end
        case 'P3'
            WB_Vol.Pass_3{1,1}=Input_Vol{i,1};
            Tot_Slices_WB=size(WB_Vol.Pass_3{1,1},3);
            Num_Slices_per_Bed=floor(Tot_Slices_WB/Num_Beds); % Assuming 6 Beds!
            for b=1:1:6
                if b==6
                    Vol_Multi_WB.Pass_3{b,1}=WB_Vol.Pass_3{1,1}(:,:,(Num_Slices_per_Bed*(b-1)+1):(Tot_Slices_WB) );
                    Vol_Multi_WB.Pass_3{b,2}='002000';
                else
                    Vol_Multi_WB.Pass_3{b,1}=WB_Vol.Pass_3{1,1}(:,:,(Num_Slices_per_Bed*(b-1)+1):(Num_Slices_per_Bed*b) );
                    Vol_Multi_WB.Pass_3{b,2}='002000';
                end   
            end
        case 'P4'
            WB_Vol.Pass_4{1,1}=Input_Vol{i,1};

            Tot_Slices_WB=size(WB_Vol.Pass_4{1,1},3);
            Num_Slices_per_Bed=floor(Tot_Slices_WB/Num_Beds); % Assuming 6 Beds!
            for b=1:1:6
                if b==6
                    Vol_Multi_WB.Pass_4{b,1}=WB_Vol.Pass_4{1,1}(:,:,(Num_Slices_per_Bed*(b-1)+1):(Tot_Slices_WB) );
                    Vol_Multi_WB.Pass_4{b,2}='002500';
                else
                    Vol_Multi_WB.Pass_4{b,1}=WB_Vol.Pass_4{1,1}(:,:,(Num_Slices_per_Bed*(b-1)+1):(Num_Slices_per_Bed*b) );
                    Vol_Multi_WB.Pass_4{b,2}='002500';
                end   
            end
        case 'P5'
            WB_Vol.Pass_5{1,1}=Input_Vol{i,1};

            Tot_Slices_WB=size(WB_Vol.Pass_5{1,1},3);
            Num_Slices_per_Bed=floor(Tot_Slices_WB/Num_Beds); % Assuming 6 Beds!
            for b=1:1:6
                if b==6
                    Vol_Multi_WB.Pass_5{b,1}=WB_Vol.Pass_5{1,1}(:,:,(Num_Slices_per_Bed*(b-1)+1):(Tot_Slices_WB) );
                    Vol_Multi_WB.Pass_5{b,2}='003000';
                else
                    Vol_Multi_WB.Pass_5{b,1}=WB_Vol.Pass_5{1,1}(:,:,(Num_Slices_per_Bed*(b-1)+1):(Num_Slices_per_Bed*b) );
                    Vol_Multi_WB.Pass_5{b,2}='003000';
                end   
            end
        case 'P6'
            WB_Vol.Pass_6{1,1}=Input_Vol{i,1};

            Tot_Slices_WB=size(WB_Vol.Pass_6{1,1},3);
            Num_Slices_per_Bed=floor(Tot_Slices_WB/Num_Beds); % Assuming 6 Beds!
            for b=1:1:6
                if b==6
                    Vol_Multi_WB.Pass_6{b,1}=WB_Vol.Pass_6{1,1}(:,:,(Num_Slices_per_Bed*(b-1)+1):(Tot_Slices_WB) );
                    Vol_Multi_WB.Pass_6{b,2}='003500';
                else
                    Vol_Multi_WB.Pass_6{b,1}=WB_Vol.Pass_6{1,1}(:,:,(Num_Slices_per_Bed*(b-1)+1):(Num_Slices_per_Bed*b) );
                    Vol_Multi_WB.Pass_6{b,2}='003500';
                end   
            end
        case 'P7'
            WB_Vol.Pass_7{1,1}=Input_Vol{i,1};

            Tot_Slices_WB=size(WB_Vol.Pass_7{1,1},3);
            Num_Slices_per_Bed=floor(Tot_Slices_WB/Num_Beds); % Assuming 6 Beds!
            for b=1:1:6
                if b==6
                    Vol_Multi_WB.Pass_7{b,1}=WB_Vol.Pass_7{1,1}(:,:,(Num_Slices_per_Bed*(b-1)+1):(Tot_Slices_WB) );
                    Vol_Multi_WB.Pass_7{b,2}='004000';
                else
                    Vol_Multi_WB.Pass_7{b,1}=WB_Vol.Pass_7{1,1}(:,:,(Num_Slices_per_Bed*(b-1)+1):(Num_Slices_per_Bed*b) );
                    Vol_Multi_WB.Pass_7{b,2}='004000';
                end   
            end
        case 'P8'
            WB_Vol.Pass_8{1,1}=Input_Vol{i,1};

            Tot_Slices_WB=size(WB_Vol.Pass_8{1,1},3);
            Num_Slices_per_Bed=floor(Tot_Slices_WB/Num_Beds); % Assuming 6 Beds!
            for b=1:1:6
                if b==6
                    Vol_Multi_WB.Pass_8{b,1}=WB_Vol.Pass_8{1,1}(:,:,(Num_Slices_per_Bed*(b-1)+1):(Tot_Slices_WB) );
                    Vol_Multi_WB.Pass_8{b,2}='004500';
                else
                    Vol_Multi_WB.Pass_8{b,1}=WB_Vol.Pass_8{1,1}(:,:,(Num_Slices_per_Bed*(b-1)+1):(Num_Slices_per_Bed*b) );
                    Vol_Multi_WB.Pass_8{b,2}='004500';
                end   
            end
        case 'P9'
            WB_Vol.Pass_9{1,1}=Input_Vol{i,1};

            Tot_Slices_WB=size(WB_Vol.Pass_9{1,1},3);
            Num_Slices_per_Bed=floor(Tot_Slices_WB/Num_Beds); % Assuming 6 Beds!
            for b=1:1:6
                if b==6
                    Vol_Multi_WB.Pass_9{b,1}=WB_Vol.Pass_9{1,1}(:,:,(Num_Slices_per_Bed*(b-1)+1):(Tot_Slices_WB) );
                    Vol_Multi_WB.Pass_9{b,2}='005000';
                else
                    Vol_Multi_WB.Pass_9{b,1}=WB_Vol.Pass_9{1,1}(:,:,(Num_Slices_per_Bed*(b-1)+1):(Num_Slices_per_Bed*b) );
                    Vol_Multi_WB.Pass_9{b,2}='005000';
                end   
            end
        case 'P10'
            WB_Vol.Pass_10{1,1}=Input_Vol{i,1};

            Tot_Slices_WB=size(WB_Vol.Pass_10{1,1},3);
            Num_Slices_per_Bed=floor(Tot_Slices_WB/Num_Beds); % Assuming 6 Beds!
            for b=1:1:6
                if b==6
                    Vol_Multi_WB.Pass_10{b,1}=WB_Vol.Pass_10{1,1}(:,:,(Num_Slices_per_Bed*(b-1)+1):(Tot_Slices_WB) );
                    Vol_Multi_WB.Pass_10{b,2}='005500';
                else
                    Vol_Multi_WB.Pass_10{b,1}=WB_Vol.Pass_10{1,1}(:,:,(Num_Slices_per_Bed*(b-1)+1):(Num_Slices_per_Bed*b) );
                    Vol_Multi_WB.Pass_10{b,2}='005500';
                end   
            end
        case 'P11'
            WB_Vol.Pass_11{1,1}=Input_Vol{i,1};

            Tot_Slices_WB=size(WB_Vol.Pass_11{1,1},3);
            Num_Slices_per_Bed=floor(Tot_Slices_WB/Num_Beds); % Assuming 6 Beds!
            for b=1:1:6
                if b==6
                    Vol_Multi_WB.Pass_11{b,1}=WB_Vol.Pass_11{1,1}(:,:,(Num_Slices_per_Bed*(b-1)+1):(Tot_Slices_WB) );
                    Vol_Multi_WB.Pass_11{b,2}='010000';
                else
                    Vol_Multi_WB.Pass_11{b,1}=WB_Vol.Pass_11{1,1}(:,:,(Num_Slices_per_Bed*(b-1)+1):(Num_Slices_per_Bed*b) );
                    Vol_Multi_WB.Pass_11{b,2}='010000';
                end   
            end
        case 'P12'
            WB_Vol.Pass_12{1,1}=Input_Vol{i,1};

            Tot_Slices_WB=size(WB_Vol.Pass_12{1,1},3);
            Num_Slices_per_Bed=floor(Tot_Slices_WB/Num_Beds); % Assuming 6 Beds!
            for b=1:1:6
                if b==6
                    Vol_Multi_WB.Pass_12{b,1}=WB_Vol.Pass_12{1,1}(:,:,(Num_Slices_per_Bed*(b-1)+1):(Tot_Slices_WB) );
                    Vol_Multi_WB.Pass_12{b,2}='010500';
                else
                    Vol_Multi_WB.Pass_12{b,1}=WB_Vol.Pass_12{1,1}(:,:,(Num_Slices_per_Bed*(b-1)+1):(Num_Slices_per_Bed*b) );
                    Vol_Multi_WB.Pass_12{b,2}='010500';
                end   
            end
        case 'P13'
            WB_Vol.Pass_13{1,1}=Input_Vol{i,1};

            Tot_Slices_WB=size(WB_Vol.Pass_13{1,1},3);
            Num_Slices_per_Bed=floor(Tot_Slices_WB/Num_Beds); % Assuming 6 Beds!
            for b=1:1:6
                if b==6
                    Vol_Multi_WB.Pass_13{b,1}=WB_Vol.Pass_13{1,1}(:,:,(Num_Slices_per_Bed*(b-1)+1):(Tot_Slices_WB) );
                    Vol_Multi_WB.Pass_13{b,2}='011000';
                else
                    Vol_Multi_WB.Pass_13{b,1}=WB_Vol.Pass_13{1,1}(:,:,(Num_Slices_per_Bed*(b-1)+1):(Num_Slices_per_Bed*b) );
                    Vol_Multi_WB.Pass_13{b,2}='011000';
                end   
            end
        case 'P14'
            WB_Vol.Pass_14{1,1}=Input_Vol{i,1};

            Tot_Slices_WB=size(WB_Vol.Pass_14{1,1},3);
            Num_Slices_per_Bed=floor(Tot_Slices_WB/Num_Beds); % Assuming 6 Beds!
            for b=1:1:6
                if b==6
                    Vol_Multi_WB.Pass_14{b,1}=WB_Vol.Pass_14{1,1}(:,:,(Num_Slices_per_Bed*(b-1)+1):(Tot_Slices_WB) );
                    Vol_Multi_WB.Pass_14{b,2}='011500';
                else
                    Vol_Multi_WB.Pass_14{b,1}=WB_Vol.Pass_14{1,1}(:,:,(Num_Slices_per_Bed*(b-1)+1):(Num_Slices_per_Bed*b) );
                    Vol_Multi_WB.Pass_14{b,2}='011500';
                end   
            end
        case 'P15'
            WB_Vol.Pass_15{1,1}=Input_Vol{i,1};

            Tot_Slices_WB=size(WB_Vol.Pass_15{1,1},3);
            Num_Slices_per_Bed=floor(Tot_Slices_WB/Num_Beds); % Assuming 6 Beds!
            for b=1:1:6
                if b==6
                    Vol_Multi_WB.Pass_15{b,1}=WB_Vol.Pass_15{1,1}(:,:,(Num_Slices_per_Bed*(b-1)+1):(Tot_Slices_WB) );
                    Vol_Multi_WB.Pass_15{b,2}='012000';
                else
                    Vol_Multi_WB.Pass_15{b,1}=WB_Vol.Pass_15{1,1}(:,:,(Num_Slices_per_Bed*(b-1)+1):(Num_Slices_per_Bed*b) );
                    Vol_Multi_WB.Pass_15{b,2}='012000';
                end   
            end
        case 'P16'
            WB_Vol.Pass_16{1,1}=Input_Vol{i,1};

            Tot_Slices_WB=size(WB_Vol.Pass_16{1,1},3);
            Num_Slices_per_Bed=floor(Tot_Slices_WB/Num_Beds); % Assuming 6 Beds!
            for b=1:1:6
                if b==6
                    Vol_Multi_WB.Pass_16{b,1}=WB_Vol.Pass_16{1,1}(:,:,(Num_Slices_per_Bed*(b-1)+1):(Tot_Slices_WB) );
                    Vol_Multi_WB.Pass_16{b,2}='012500';
                else
                    Vol_Multi_WB.Pass_16{b,1}=WB_Vol.Pass_16{1,1}(:,:,(Num_Slices_per_Bed*(b-1)+1):(Num_Slices_per_Bed*b) );
                    Vol_Multi_WB.Pass_16{b,2}='012500';
                end   
            end
        case 'P17'
            WB_Vol.Pass_17{1,1}=Input_Vol{i,1};

            Tot_Slices_WB=size(WB_Vol.Pass_17{1,1},3);
            Num_Slices_per_Bed=floor(Tot_Slices_WB/Num_Beds); % Assuming 6 Beds!
            for b=1:1:6
                if b==6
                    Vol_Multi_WB.Pass_17{b,1}=WB_Vol.Pass_17{1,1}(:,:,(Num_Slices_per_Bed*(b-1)+1):(Tot_Slices_WB) );
                    Vol_Multi_WB.Pass_17{b,2}='013000';
                else
                    Vol_Multi_WB.Pass_17{b,1}=WB_Vol.Pass_17{1,1}(:,:,(Num_Slices_per_Bed*(b-1)+1):(Num_Slices_per_Bed*b) );
                    Vol_Multi_WB.Pass_17{b,2}='013000';
                end   
            end
        case 'P18'
            WB_Vol.Pass_18{1,1}=Input_Vol{i,1};

            Tot_Slices_WB=size(WB_Vol.Pass_18{1,1},3);
            Num_Slices_per_Bed=floor(Tot_Slices_WB/Num_Beds); % Assuming 6 Beds!
            for b=1:1:6
                if b==6
                    Vol_Multi_WB.Pass_18{b,1}=WB_Vol.Pass_18{1,1}(:,:,(Num_Slices_per_Bed*(b-1)+1):(Tot_Slices_WB) );
                    Vol_Multi_WB.Pass_18{b,2}='013500';
                else
                    Vol_Multi_WB.Pass_18{b,1}=WB_Vol.Pass_18{1,1}(:,:,(Num_Slices_per_Bed*(b-1)+1):(Num_Slices_per_Bed*b) );
                    Vol_Multi_WB.Pass_18{b,2}='013500';
                end   
            end
        case 'P19'
            WB_Vol.Pass_19{1,1}=Input_Vol{i,1};

            Tot_Slices_WB=size(WB_Vol.Pass_19{1,1},3);
            Num_Slices_per_Bed=floor(Tot_Slices_WB/Num_Beds); % Assuming 6 Beds!
            for b=1:1:6
                if b==6
                    Vol_Multi_WB.Pass_19{b,1}=WB_Vol.Pass_19{1,1}(:,:,(Num_Slices_per_Bed*(b-1)+1):(Tot_Slices_WB) );
                    Vol_Multi_WB.Pass_19{b,2}='014000';
                else
                    Vol_Multi_WB.Pass_19{b,1}=WB_Vol.Pass_19{1,1}(:,:,(Num_Slices_per_Bed*(b-1)+1):(Num_Slices_per_Bed*b) );
                    Vol_Multi_WB.Pass_19{b,2}='014000';
                end   
            end
        case 'P20' % Upto 20th Pass
            WB_Vol.Pass_20{1,1}=Input_Vol{i,1};

            Tot_Slices_WB=size(WB_Vol.Pass_20{1,1},3);
            Num_Slices_per_Bed=floor(Tot_Slices_WB/Num_Beds); % Assuming 6 Beds!
            for b=1:1:6
                if b==6
                    Vol_Multi_WB.Pass_20{b,1}=WB_Vol.Pass_20{1,1}(:,:,(Num_Slices_per_Bed*(b-1)+1):(Tot_Slices_WB) );
                    Vol_Multi_WB.Pass_20{b,2}='014500';
                else
                    Vol_Multi_WB.Pass_20{b,1}=WB_Vol.Pass_20{1,1}(:,:,(Num_Slices_per_Bed*(b-1)+1):(Num_Slices_per_Bed*b) );
                    Vol_Multi_WB.Pass_20{b,2}='014500';
                end   
            end
    end

end



if Decay_ind==1 % Decay Correction
    for p=1:1:Num_Passes
        for b=1:1:Num_Beds
           Vol_Multi_WB_PCDE.(Names_Passes(1,p)){b,1} = exp(lamda.*PI_Times_PCDE(p,b)).*Vol_Multi_WB.(Names_Passes(1,p)){b,1}; % Decay correction!
           Vol_Multi_WB_PCDE.(Names_Passes(1,p)){b,2} = Vol_Multi_WB.(Names_Passes(1,p)){b,2};
        end    
    end
else
    Vol_Multi_WB_PCDE=Vol_Multi_WB; % [Unit: can be different depending on unit used for XCAT Phantom Image] (if Unit of XCAT: [kBq/ml] then Unit of Result: [kBq/ml])
end

save("Vol_Multi_WB_PCDE.mat",'Vol_Multi_WB_PCDE','-v7.3','-nocompression');

end