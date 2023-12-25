
tic;
for i=1:1:10
[sort_ind]=PCL_300_mex(DB,Voxel_TAC);
end
toc;

tic;
for i=1:1:100
    [sort_ind]=PCL_300(DB,Voxel_TAC);
end
toc;

tic;
[Ind_300]=PCL_300_GPU_mex(DB,Slice_TACs);
toc;

tic;
Ind_10=zeros(10,256,256,'single');
Val_10=zeros(10,256,256,'single');
k=220;
parfor r=1:1:256
    Ind_300_row=Ind_300(:,256*(r-1)+1:256*r);
    Ind_300_row=Ind_300_row(:);
    Logic_Pos=(Ind_300_row == 0);
    Logic_Neg=(Ind_300_row ~= 0);
    Ind_300_row=Ind_300_row+Logic_Pos;
    PL_300=single(permutes(Ind_300_row,:));
    PL_300=PL_300.*Logic_Neg;
    Row_DB_300=TTCM_analytic_Multi(PL_300,[10:0.1:90]);
    Row_FTACs=Exp_New(squeeze(Fitted_4D(:,r,k,:)),[10:0.1:90]);

    [Val,Ind]=Rank_AUC_GPU(Row_DB_300,Row_FTACs,Time_intv);
    Ind_10(:,:,r)=Ind;
    Val_10(:,:,r)=Val;
end
toc;




tic;
[Ind_10]=Rank_AUC_GPU_mex(Row_DB_300_10T,Row_FTACs_10T,Time_intv);
toc;


tic;
[Val_ROA,Ind_ROA]=Rank_AUC_Overlapped_GPU(DB_10,Slice_FTACs,Time_intv);
toc;

tic;
[Val_ROA,Ind_ROA]=Rank_AUC_Overlapped_GPU_mex(DB_10,Slice_FTACs,Time_intv);
toc;

tic;
[DB_3D]=Conv_4D_3D_GPU(kBq);
toc;

tic;
[DB_3D]=Conv_4D_3D_GPU_mex(kBq);
toc;

tic;
[DN_Slice_TACs]=Denoising_FLT(DB_3D(:,:,220));
toc;

tic;
[Val_Ct,Ind_Ct]=Rank_Ct_GPU(DB_10,Slice_FTACs,Time_intv);
toc;

tic;
[Val_Ct,Ind_Ct]=Rank_Ct_GPU_mex(DB_10,Slice_FTACs,Time_intv);
toc;

tic;
[Val_Sl,Ind_Sl,Val_Acc,Ind_Acc]=Rank_Slope_Acc_GPU(DB_10,Slice_FTACs,Time_intv);
toc;

tic;
[Val_Con_Ct,Ind_Con_Ct,Val_Con_Sl,Ind_Con_Sl]=Rank_Connect_GPU(DB_10,Slice_FTACs,Time_intv);
toc;

tic;
[Val_Con_Ct,Ind_Con_Ct,Val_Con_Sl,Ind_Con_Sl]=Rank_Connect_GPU_mex(DB_10,Slice_FTACs,Time_intv);
toc;


tic;
[Val_MI,Ind_MI]=Rank_MI_GPU(DB_10,Slice_FTACs,Time_intv);
toc;


tic;
Num_Vox_row=256;
[Row_DB_300]=Gen_Row_DB(r,Num_Vox_row,Ind_300,permutes,PI_Time_fine);
toc;

tic;
r=100;
k=220;
[Row_FTACs]=Gen_Row_FTACs(r,k,Fitted_4D,PI_Time_fine);
toc;

%%%% Rank_AUC_GPU per Slice %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
tic;
k=220;
Num_Vox_row=256;
%Ind_10=zeros(10,256,256,'single');
%Val_10=zeros(10,256,256,'single');
Fitted_4D_Slice=squeeze(Fitted_4D(:,:,k,:));
Row_DB_300_zeros=zeros(300*256,size(PI_Time_fine,2),'single');
I_zeros=zeros(10,256,'single');
V_zeros=zeros(10,256,'single');
for r=1:1:256  
    [Row_FTACs]=Gen_Row_FTACs(r,k,Fitted_4D_Slice,PI_Time_fine);
    if Row_FTACs ==0
        Row_DB_300=Row_DB_300_zeros;
        I=I_zeros;
        V=V_zeros;
    else
        [Row_DB_300]=Gen_Row_DB(r,Num_Vox_row,Ind_300,permutes,PI_Time_fine,Local_Estimates);
        [V,I]=Rank_AUC_GPU(Row_DB_300,Row_FTACs,Time_intv);
    end
    if r==1
        Ind_10=I;
        Val_10=V;
    else
        Ind_10=cat(2,Ind_10,I);
        Val_10=cat(2,Val_10,V);
    end
    %Ind_10(:,:,r)=I;
    %Val_10(:,:,r)=V;
end
%Ind_10=reshape(Ind_10,10,256*256);
%Val_10=reshape(Val_10,10,256*256);
toc;


tic;
C_tot=TTCM_analytic_Multi_GPU(PL_300,PI_Time_fine,Local_Estimates);
toc;


tic;
[Slice_DB_10]=Gen_Slice_DB_10(Ind_10,permutes,PI_Time_fine,Local_Estimates);
toc;


tic;
k=220;
[Slice_FTACs]=Gen_Slice_FTACs(k,Fitted_4D,PI_Time_fine);
toc;

tic;
k=220;
Num_Vox_row=256;
[Val_10,Ind_10]=Rank_AUC_GPU_Slice(k,Num_Vox_row,Fitted_4D,permutes,PI_Time_fine,Time_intv,Ind_300,Local_Estimates);
toc;





%% Mandelbrot example
maxIterations = 500; gridSize = 1000;
xlim = [-0.748766713922161,-0.748766707771757]; ylim = [0.123640844894862,0.123640851045266];
x = linspace(xlim(1),xlim(2),gridSize); y = linspace(ylim(1),ylim(2),gridSize); [xGrid,yGrid] = meshgrid(x,y);
%% Mandelbrot computation in MATLAB
tic;
count = mandelbrot_count(maxIterations,xGrid,yGrid);
toc;
tic;
count = mandelbrot_test_mex(maxIterations,xGrid,yGrid);
toc;


%save('mandelbrot_test.mat','maxIterations','xGrid','yGrid');
% Show
figure(1)
imagesc(x,y,count);
colormap([jet();flipud(jet());0 0 0]); 
axis off 
title('Mandelbrot set with MATLAB');



tic;
Ct=TTCM_analytic_Multi_GPU(PL,PI_Time_fine,Local_Estimates);
toc;
tic;
Ct=TTCM_analytic_Multi_GPU_mex(PL,PI_Time_fine,Local_Estimates);
toc;

for i=1:1:10
    for j=1:1:8
        before_sorted_vals(i,j)=sort_vals(find(sort_inds(:,j)==i),j);
    end
end

colmin=min(before_sorted_vals);
colmax=max(before_sorted_vals);
N_val=rescale(before_sorted_vals,'InputMin',colmin,'InputMax',colmax);



edges_k1 = [0:0.05:1];
edges_k2 = [0:0.05:1];
edges_k3 = [0:0.05:1];
edges_k4 = [0:0.05:1];
prob_k1 = histcounts(permutes(Final_inds,1),edges_k1,'Normalization', 'probability');
prob_k2 = histcounts(permutes(Final_inds,2),edges_k2,'Normalization', 'probability');
prob_k3 = histcounts(permutes(Final_inds,3),edges_k3,'Normalization', 'probability');
prob_k4 = histcounts(permutes(Final_inds,3),edges_k4,'Normalization', 'probability');

[edges_k1(1:end-1)', prob_k1'];
[edges_k2(1:end-1)', prob_k2'];
[edges_k3(1:end-1)', prob_k3'];
