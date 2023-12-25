function PI_Times_Multi_WB_x=Convert_HHMMSS_into_PI_min(Times_Multi_WB_Pass_x, Tracer_Injection_Time)
% Converting HHMMSS into Post-Injection Time [min]
%Times=Times_Multi_WB.Pass_1;
Times=Times_Multi_WB_Pass_x;

% Converting HH:MM:SS format into seconds
for i=1:1:size(Times, 2)
    Time_String_HH{1,i}=num2str(Times(1,i),'%06.f');
    Time_String_HH{1,i}(3:6)=[];
end
for i=1:1:size(Times, 2)
    Time_String_MM{1,i}=num2str(Times(1,i),'%06.f');
    Time_String_MM{1,i}(1:2)=[];
    Time_String_MM{1,i}(3:4)=[];
end
for i=1:1:size(Times, 2)
    Time_String_SS{1,i}=num2str(Times(1,i),'%06.f');
    Time_String_SS{1,i}(1:2)=[];
    Time_String_SS{1,i}(1:2)=[];
end
for i=1:1:size(Times,2)
    Time_Sec(1,i)= (str2num(Time_String_HH{1,i})*3600.00) + (str2num(Time_String_MM{1,i})*60.00) + str2num(Time_String_SS{1,i}) ;
end
% for Radiopharmaceutical injection time (under the assumption that the time is given with the form like this, '120200.00', 6 digits with 2 decimal points)
for i=1:1:size(Times, 2)
    Tracer_Injection_Time_String_HH{1,i}=Tracer_Injection_Time;
    Tracer_Injection_Time_String_HH{1,i}(7:9)=[];
    Tracer_Injection_Time_String_HH{1,i}(3:6)=[];
end
for i=1:1:size(Times, 2)
    Tracer_Injection_Time_String_MM{1,i}=Tracer_Injection_Time;
    Tracer_Injection_Time_String_MM{1,i}(7:9)=[];
    Tracer_Injection_Time_String_MM{1,i}(1:2)=[];
    Tracer_Injection_Time_String_MM{1,i}(3:4)=[];
end
for i=1:1:size(Times, 2)
    Tracer_Injection_Time_String_SS{1,i}=Tracer_Injection_Time;
    Tracer_Injection_Time_String_SS{1,i}(7:9)=[];
    Tracer_Injection_Time_String_SS{1,i}(1:4)=[];
end
for i=1:1:size(Times,2)
    Tracer_Injection_Time_Sec(1,i)= (str2num(Tracer_Injection_Time_String_HH{1,i})*3600.00) + (str2num(Tracer_Injection_Time_String_MM{1,i})*60.00) + str2num(Tracer_Injection_Time_String_SS{1,i}) ;
end

% Getting exact post-injection time for each frame
PI_Time_Sec=Time_Sec - Tracer_Injection_Time_Sec; % PI time in terms of Sec
PI_Time_Min=PI_Time_Sec/60.0; % PI time in terms of Min

PI_Times_Multi_WB_x=PI_Time_Min;

end