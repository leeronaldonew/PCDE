function [DN_DB_3D,DN_kBq]=Denoising_FLT(kBq, Denoising_Ind)
%% Converting 4D array into 3D array
coder.gpu.kernelfun();
size_WB=size(kBq);
DB_3D=zeros(size_WB(1)*size_WB(2),size_WB(4),size_WB(3),'single');
for k=1:1:size_WB(3)
    for j=1:1:size_WB(2)
        for i=1:1:size_WB(1)
            for p=1:1:size_WB(4)
                DB_3D(i+size_WB(1)*(j-1),p,k)=kBq(i,j,k,p);
            end
        end
    end
end

if Denoising_Ind ==1 % Denoising with FLT
    %% Denoising %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    size_DB=size(DB_3D);
    %DB_3D_rs=reshape(DB_3D,size_DB(1)*size_DB(3),size_DB(2));
    DB_3D_rs=zeros(size_DB(1)*size_DB(3),size_DB(2),'single');
    for k=1:1:size_DB(3)
        DB_3D_rs(size_DB(1)*(k-1)+1:size_DB(1)*k,:)=DB_3D(:,:,k);
    end
    nl=3; % Legendre Polynomial's max order
    kmax=3; % cut-off order for denoising
    Num_p=size(DB_3D_rs,2); % # of data points
    Num_Vox=size(DB_3D_rs,1);
    DN_DB=zeros(Num_Vox,Num_p,'single');

    parfor v=1:1:Num_Vox
        if DB_3D_rs(v,:)==0
            DN_DB(v,:)=0;
        else
            y_py=py.numpy.array(DB_3D_rs(v,:));
            FLT_results=single(py.LegendrePolynomials.LT(y_py,py.numpy.array(nl)));      
            iFLT_results_py=py.LegendrePolynomials.iLT(py.numpy.array(FLT_results(1,1:kmax)),py.numpy.array(Num_p)); % iFLT
            DN_DB(v,:)=single(iFLT_results_py);
        end
    end
    %DN_DB_3D=reshape(DN_DB,size_DB(1),size_DB(2),size_DB(3));
    for k=1:1:size_DB(3)
        DN_DB_3D(:,:,k)=DN_DB(size_DB(1)*(k-1)+1:size_DB(1)*k,:);
    end
    %% Converting 3D into 4D Array
    for p=1:1:size_WB(4)
        DN_kBq(:,:,:,p)=reshape(DN_DB(:,p),size_WB(1),size_WB(2),size_WB(3));
    end
else % X Denoising
    DN_kBq=kBq;
    DN_DB_3D=DB_3D;
end

