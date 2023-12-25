function [Val_MI,Ind_MI]=Rank_MI_GPU(DB_10,Slice_FTACs,Time_intv)

Num_DB=size(DB_10,1);
Num_Vox=size(Slice_FTACs,1);

% Making PDF (DB): 1.52 [sec]
DB_PDF= DB_10 ./ sum(DB_10,2); 
DB_PDF(isnan(DB_PDF))=0; % removing NaN

% Making PDF (FTACs): 0.16 [sec]
FTACs_PDF=Slice_FTACs ./ sum(Slice_FTACs,2);
FTACs_PDF(isnan(FTACs_PDF))=0; % removing NaN

% Calc. of Entropy (DB): 2.5 [sec]
DB_PW=-1.*DB_PDF.*log2(DB_PDF);
DB_PW(isnan(DB_PW))=0; % removing Nan
H_DB=sum(DB_PW,2);

% Calc. of Entropy (FTACs): 0.3 [sec]
FTACs_PW=-1.*FTACs_PDF.*log2(FTACs_PDF);
FTACs_PW(isnan(FTACs_PW))=0; % removing Nan
H_FTACs_temp=sum(FTACs_PW,2);
H_FTACs=zeros(Num_DB,1,'single');
for v=1:1:Num_Vox
    H_FTACs(10*(v-1)+1:10*v,1)=repmat(H_FTACs_temp(v),10,1);
end

% Segmentation
DB_PDF_seg=DB_PDF(find(sum(DB_PDF,2)~=0),:);
Num_DB_seg=size(DB_PDF_seg,1);
v_seg=ceil(find(sum(DB_PDF,2)~=0)/10);


% Calc. of Joint Entropy: 5.7 [sec]
Num_bins=10;
PDF_Joint=zeros(Num_DB,Num_bins*Num_bins,'single');
PDF_Joint_seg=zeros(Num_DB_seg,Num_bins*Num_bins,'single');
parfor d=1:1:Num_DB_seg
    [PDF_Joint_temp,Xedges,Yedges]=histcounts2(DB_PDF_seg(d,:),FTACs_PDF(v_seg(d),:),Num_bins,'Normalization','probability'); 
    PDF_Joint_seg(d,:)=PDF_Joint_temp(:);
end
PDF_Joint(find(sum(DB_PDF,2)~=0),:)=PDF_Joint_seg;
PW_Joint=-1*PDF_Joint.*log2(PDF_Joint);
PW_Joint(isnan(PW_Joint))=0; % removing Nan
H_Joint=sum(PW_Joint,2);



% Calc. of MI: 0.007 [sec]
MI= H_DB + H_FTACs - H_Joint ;

% Ranking!: 0.17 [sec]
Ind_MI=zeros(10,Num_Vox,'single');
Val_MI=zeros(10,Num_Vox,'single');
for v=1:1:Num_Vox
    if Slice_FTACs(v,1)==0
        Ind_MI(:,v)=0;
        Val_MI(:,v)=0;
    else
        [B,I] = gpucoder.sort( MI(10*(v-1)+1:10*v,1), 'descend' );
        %[B,I] = maxk(  MI(10*(v-1)+1:10*v,1) ,10,1);
        Ind_MI(:,v)=I;
        Val_MI(:,v)=B;
    end
end

end