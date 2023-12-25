%% XCAT_to_dPETSTEP_main
clear

load Act_XCAT_Tumors_Bed.mat
load Atn_XCAT_Bed.mat

%frame=60.*[10:5:95]'; % PI Times [sec] for 17 Passes (10-90 min)
frame=60.*[10:5:45]'; % PI Times [sec] for 7 Passes (10-40 min)

Pixs=[2,2,4.25]; % Physical Pixel Size [mm]

for b=1:1:5
    filename= string(['dPETSTEP_Bed_',num2str(b),'.mat']);
    for p=1:1:(size(frame,1)-1)
        Act_XCAT_temp(:,:,:,p)=Act_XCAT_Tumors_Bed{p,b};
    end
    Atn_XCAT_temp(:,:,:)=Atn_XCAT_Bed{p,b};
    [data_XCAT,frame_XCAT,scaleFactor_XCAT]=XCAT_to_dPETSTEP(Act_XCAT_temp,Atn_XCAT_temp,Pixs,frame);
    save(filename, 'data_XCAT','frame_XCAT','scaleFactor_XCAT');
end

clear

