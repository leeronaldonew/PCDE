%% XCAT_Recon_dPETSTEP
clear
t1=clock;
for b=1:1:5
    filename=['dPETSTEP_Bed_',num2str(b),'.mat'];
    load(filename);
    %% Run simulation
    [data,simSet,FBP4D,OS4D,OSEM_PSF_Bed,counts,countsNoise,nFWprompts,FWtrues,FWscatters,FWrandoms,wcc] = Dynamic_main_dynamicImage(data_XCAT,frame_XCAT,scaleFactor_XCAT);
    filename_save=['OSEM_PSF_Bed_',num2str(b),'.mat'];
    OSEM_PSF_Bed=single(OSEM_PSF_Bed);
    save(filename_save, 'OSEM_PSF_Bed','-v7.3');
    clearvars -except b t1
end   
t2=clock;
E_Time_Recon=etime(t2,t1)/3600; %[hrs]
save E_Time_Recon.mat E_Time_Recon

load OSEM_PSF_Bed_1.mat
Num_Iters= size(OSEM_PSF_Bed,5);
Num_Reals= size(OSEM_PSF_Bed,6);
clearvars -except Num_Iters Num_Reals

%% Converting the save contents into the format for KM
t1=clock;
for Iter=1:1:Num_Iters
    for R=1:1:Num_Reals
        for b=1:1:5
            filename=['OSEM_PSF_Bed_',num2str(b),'.mat'];
            load(filename);
            for p=1:1:size(OSEM_PSF_Bed,4)
                Act_XCAT_Recon_Bed{p,b}=OSEM_PSF_Bed(:,:,:,p,Iter,R);
            end   
        end
        for p=1:1:size(OSEM_PSF_Bed,4)
            vec_temp=cat(1,Act_XCAT_Recon_Bed{p,1}(:),Act_XCAT_Recon_Bed{p,2}(:),Act_XCAT_Recon_Bed{p,3}(:),Act_XCAT_Recon_Bed{p,4}(:),Act_XCAT_Recon_Bed{p,5}(:));
            Act_XCAT_Recon{p,1}=reshape(vec_temp,[165,165,35*5]);
        end
        filename_save=['XCAT_Recon_Iter_',num2str(Iter),'_N_',num2str(R),'.mat'];
        save(filename_save, 'Act_XCAT_Recon', 'Act_XCAT_Recon_Bed', '-v7.3');
    end
end
t2=clock;
E_Time_Conv=etime(t2,t1)/3600; %[hrs]
save E_Time_Conv.mat E_Time_Conv
