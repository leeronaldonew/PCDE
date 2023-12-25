function [Val_Sl,Ind_Sl,Val_Acc,Ind_Acc]=Rank_Slope_Acc_Speedy(DB_10,Slice_FTACs,Time_intv)
coder.gpu.kernelfun();

DB_Sl=diff(DB_10,1,2) ./ Time_intv; % First derivative
DB_Acc=diff(DB_Sl,1,2) ./ Time_intv;  % Second derivative
FTACs_Sl=diff(Slice_FTACs,1,2) ./ Time_intv; % First derivative
FTACs_Acc=diff(FTACs_Sl,1,2) ./ Time_intv; % Second derivative

%tic;
%DB_Sl=gather(diff(gpuArray(DB_10),1,2) ./ Time_intv); % First derivative
%DB_Acc=gather(diff(gpuArray(DB_Sl),1,2) ./ Time_intv);  % Second derivative
%FTACs_Sl=gather(diff(gpuArray(Slice_FTACs),1,2) ./ Time_intv); % First derivative
%FTACs_Acc=gather(diff(gpuArray(FTACs_Sl),1,2) ./ Time_intv); % Second derivative
%toc;



Num_Vox=size(Slice_FTACs,1);
Ind_Sl=zeros(10,Num_Vox,'single');
Val_Sl=zeros(10,Num_Vox,'single');
Ind_Acc=zeros(10,Num_Vox,'single');
Val_Acc=zeros(10,Num_Vox,'single');

for v=1:1:Num_Vox
    if Slice_FTACs(v,:) == 0
        Ind_Sl(:,v)=0;
        Val_Sl(:,v)=0;
        Ind_Acc(:,v)=0;
        Val_Acc(:,v)=0;
    else
        %[B,I] = gpucoder.sort( sum( (DB_Sl(10*(v-1)+1:10*v,:)-FTACs_Sl(v,:)).^(2),2 ) );
        [B,I] = mink(  sum( (DB_Sl(10*(v-1)+1:10*v,:)-FTACs_Sl(v,:)).^(2),2 ) ,10,1);
        Ind_Sl(:,v)=I;
        Val_Sl(:,v)=B;
        %[B,I] = gpucoder.sort( sum( (DB_Acc(10*(v-1)+1:10*v,:)-FTACs_Acc(v,:)).^(2),2 ) );
        [B,I] = mink(  sum( (DB_Acc(10*(v-1)+1:10*v,:)-FTACs_Acc(v,:)).^(2),2 ) ,10,1);
        Ind_Acc(:,v)=I;
        Val_Acc(:,v)=B; 
    end
end




end