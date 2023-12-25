function [Val_Ct,Ind_Ct]=Rank_Ct_Speedy(DB_10,Slice_FTACs,Time_intv)

coder.gpu.kernelfun();
Num_Vox=size(Slice_FTACs,1);
Ind_Ct=zeros(10,Num_Vox,'single');
Val_Ct=zeros(10,Num_Vox,'single');
for v=1:1:Num_Vox
    if Slice_FTACs(v,:) == 0
        Ind_Ct(:,v)=0;
        Val_Ct(:,v)=0;
    else
        %[B,I] = gpucoder.sort( sum( (DB_10(10*(v-1)+1:10*v,:)-Slice_FTACs(v,:)).^(2),2 ) );
        [B,I] = mink(  sum( (DB_10(10*(v-1)+1:10*v,:)-Slice_FTACs(v,:)).^(2),2 ) ,10,1);
        
        Ind_Ct(:,v)=I;
        Val_Ct(:,v)=B;
    end
end




end