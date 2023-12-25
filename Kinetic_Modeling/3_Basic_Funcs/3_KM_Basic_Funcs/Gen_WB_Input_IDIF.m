function [Image_Derived_Data_from_zero_kBq,Post_Injection_Time_Min_from_zero]=Gen_WB_Input_IDIF(Num_Passes,Num_Beds,Vol_WB,Vol_Multi_WB,Raw_Data_Multi_WB,Times_Multi_WB,Num_Times_Multi_WB)

[RT_S_file, RT_S_path, RT_S_index]=uigetfile('*.dcm'); % DCM RT Struct. for WB
RT_S_file_path= [RT_S_path,RT_S_file];
RT_S_Header=dicominfo(RT_S_file_path);
RT_S_Contour=dicomContours(RT_S_Header); % Extracting absolute coordinates of points which make contours

image_size=size(Vol_WB.Pass_1{1,1}); % the # of voxels along with Rows X Columns X Z axis
Limit_X=[(Raw_Data_Multi_WB.Pass_1{1,1}.ImagePositionPatient(1,1)), (Raw_Data_Multi_WB.Pass_1{1,1}.PixelSpacing(2,1)*image_size(1,2))+(Raw_Data_Multi_WB.Pass_1{1, 1}.ImagePositionPatient(1,1))]; % for X-limit
Limit_Y=[(Raw_Data_Multi_WB.Pass_1{1, 1}.ImagePositionPatient(2,1)), (Raw_Data_Multi_WB.Pass_1{1,1}.PixelSpacing(1,1)*image_size(1,1))+(Raw_Data_Multi_WB.Pass_1{1, 1}.ImagePositionPatient(2,1))]; % for Y-limit
for i=1:1:size(Raw_Data_Multi_WB.Pass_1,2)
    Limit_Z_temp(1,i)=Raw_Data_Multi_WB.Pass_1{4,i};
end
Limit_Z= [min(Limit_Z_temp), max(Limit_Z_temp)]; % for Z-limit
reference_Info=imref3d(image_size, Limit_X, Limit_Y, Limit_Z);
Struct_Mask=createMask(RT_S_Contour, 1, reference_Info);
Struct_Mask_array=double(Struct_Mask);
Num_of_Voxels_VOI=nnz(Struct_Mask_array);

Index_Passes=[1:1:Num_Passes];

for i=1:1:Num_Passes
    Names_Passes=["Pass_"+Index_Passes(1,i)];
    Multiplied_matrix{i,1}=Vol_WB.(Names_Passes){1,1}.*Struct_Mask_array; % for verifying the values in the VOI
    Image_Derived_Data(i,1)= (sum(Multiplied_matrix{i,1}, 'all', 'double')) / (Num_of_Voxels_VOI); % Calc. of Mean Concentration of tracer in the VOI: unit = [Bq/ml]
end
% Converting HH:MM:SS format into seconds (LV: 4th Bed!)
for i=1:1:Num_Passes %HH
    Names_Passes=["Pass_"+Index_Passes(1,i)];
    Image_Acquisition_Time_String_HH{1,i}=num2str(Vol_Multi_WB.(Names_Passes){4,2},'%06.f'); % Every Patients except for FDG Pat.
    %Image_Acquisition_Time_String_HH{1,i}=num2str(Vol_Multi_WB.(Names_Passes){5,2},'%06.f'); % FDG
    Image_Acquisition_Time_String_HH{1,i}(3:6)=[];
end
for i=1:1:Num_Passes %MM
    Names_Passes=["Pass_"+Index_Passes(1,i)];
    Image_Acquisition_Time_String_MM{1,i}=num2str(Vol_Multi_WB.(Names_Passes){4,2},'%06.f');
    %Image_Acquisition_Time_String_MM{1,i}=num2str(Vol_Multi_WB.(Names_Passes){5,2},'%06.f');
    Image_Acquisition_Time_String_MM{1,i}(1:2)=[];
    Image_Acquisition_Time_String_MM{1,i}(3:4)=[];
end
for i=1:1:Num_Passes %SS
    Names_Passes=["Pass_"+Index_Passes(1,i)];
    Image_Acquisition_Time_String_SS{1,i}=num2str(Vol_Multi_WB.(Names_Passes){4,2},'%06.f');
    %Image_Acquisition_Time_String_SS{1,i}=num2str(Vol_Multi_WB.(Names_Passes){5,2},'%06.f');
    Image_Acquisition_Time_String_SS{1,i}(1:2)=[];
    Image_Acquisition_Time_String_SS{1,i}(1:2)=[];
end
for i=1:1:Num_Passes
    Image_Acquisition_Time_Sec(1,i)= (str2num(Image_Acquisition_Time_String_HH{1,i})*3600.00) + (str2num(Image_Acquisition_Time_String_MM{1,i})*60.00) + str2num(Image_Acquisition_Time_String_SS{1,i}) ;
end
% for Radiopharmaceutical injection time (under the assumption that the time is given with the form like this, '120200.00', 6 digits with 2 decimal points)
for i=1:1:Num_Passes
    %Tracer_Injection_Time_String_HH{1,i}=Raw_Data_Multi_WB.Pass_1{1, 1}.RadiopharmaceuticalStartTime;
    Tracer_Injection_Time_String_HH{1,i}=Raw_Data_Multi_WB.Pass_1{1, 1}.RadiopharmaceuticalInformationSequence.Item_1.RadiopharmaceuticalStartTime;
    Tracer_Injection_Time_String_HH{1,i}(7:9)=[];
    Tracer_Injection_Time_String_HH{1,i}(3:6)=[];
end
for i=1:1:Num_Passes
    %Tracer_Injection_Time_String_MM{1,i}=Raw_Data_Multi_WB.Pass_1{1, 1}.RadiopharmaceuticalStartTime;
    Tracer_Injection_Time_String_MM{1,i}=Raw_Data_Multi_WB.Pass_1{1, 1}.RadiopharmaceuticalInformationSequence.Item_1.RadiopharmaceuticalStartTime;
    Tracer_Injection_Time_String_MM{1,i}(7:9)=[];
    Tracer_Injection_Time_String_MM{1,i}(1:2)=[];
    Tracer_Injection_Time_String_MM{1,i}(3:4)=[];
end
for i=1:1:Num_Passes
    %Tracer_Injection_Time_String_SS{1,i}=Raw_Data_Multi_WB.Pass_1{1, 1}.RadiopharmaceuticalStartTime;
    Tracer_Injection_Time_String_SS{1,i}=Raw_Data_Multi_WB.Pass_1{1, 1}.RadiopharmaceuticalInformationSequence.Item_1.RadiopharmaceuticalStartTime;
    Tracer_Injection_Time_String_SS{1,i}(7:9)=[];
    Tracer_Injection_Time_String_SS{1,i}(1:4)=[];
end
for i=1:1:Num_Passes
    Tracer_Injection_Time_Sec(1,i)= (str2num(Tracer_Injection_Time_String_HH{1,i})*3600.00) + (str2num(Tracer_Injection_Time_String_MM{1,i})*60.00) + str2num(Tracer_Injection_Time_String_SS{1,i}) ;
end
% Getting exact post-injection time for each frame
Post_Injection_Time_Sec= Image_Acquisition_Time_Sec - Tracer_Injection_Time_Sec; % PI time in terms of Sec
Post_Injection_Time_Min=Post_Injection_Time_Sec/60.0; % PI time in terms of Min
% Modifyting and Plotting the Image-Derived Data Points [time duration: 0~6 min]
for i=1:1:size(Post_Injection_Time_Min, 2)
    if Post_Injection_Time_Min(1,i) < 0.0
        Image_Derived_Data_from_zero_temp(i,1)=0.0;
        Post_Injection_Time_Min_from_zero_temp(1,i)=0.0;
    else
        Image_Derived_Data_from_zero_temp(i,1)=Image_Derived_Data(i,1);
        Post_Injection_Time_Min_from_zero_temp(1,i)=Post_Injection_Time_Min(1,i);
    end
end
%Post_Injection_Time_Min_from_zero=[0.0, transpose(nonzeros(Post_Injection_Time_Min_from_zero_temp))];
%Image_Derived_Data_from_zero=[0.0; nonzeros(Image_Derived_Data_from_zero_temp)];
Post_Injection_Time_Min_from_zero=Post_Injection_Time_Min_from_zero_temp;
Image_Derived_Data_from_zero=Image_Derived_Data_from_zero_temp;

% Converting [Bq/ml] to [kBq/ml] and plotting
Image_Derived_Data_from_zero_kBq=0.001.*Image_Derived_Data_from_zero;

end