function [Val_Con_Ct,Ind_Con_Ct,Val_Con_Sl,Ind_Con_Sl]=Rank_Connect_Speedy(DB_10,Slice_FTACs,Time_intv)

% Calc. & Ranking the connectivity at Eariest Measurement point (e.g., 10 [min])

DB_Sl=diff(DB_10(:,1:2),1,2) ./ Time_intv; % First derivative
FTACs_Sl=diff(Slice_FTACs(:,1:2),1,2) ./ Time_intv; 

Num_Vox=size(Slice_FTACs,1);
Ind_Con_Ct=zeros(10,Num_Vox,'single');
Val_Con_Ct=zeros(10,Num_Vox,'single');
Ind_Con_Sl=zeros(10,Num_Vox,'single');
Val_Con_Sl=zeros(10,Num_Vox,'single');

coder.gpu.kernelfun();
for v=1:1:Num_Vox
    if Slice_FTACs(v,:) == 0
        Ind_Con_Ct(:,v)=0;
        Val_Con_Ct(:,v)=0;
        Ind_Con_Sl(:,v)=0;
        Val_Con_Sl(:,v)=0;
    else
        %[B,I] = gpucoder.sort( sum( (DB_10(10*(v-1)+1:10*v,1)-Slice_FTACs(v,1)).^(2),2 ) );
        [B,I] = mink(  sum( (DB_10(10*(v-1)+1:10*v,1)-Slice_FTACs(v,1)).^(2),2 ) ,10,1);
        Ind_Con_Ct(:,v)=I;
        Val_Con_Ct(:,v)=B;
        %[B,I] = gpucoder.sort( sum( (DB_Sl(10*(v-1)+1:10*v,1)-FTACs_Sl(v,1)).^(2),2 ) );
        [B,I] = mink(  sum( (DB_Sl(10*(v-1)+1:10*v,1)-FTACs_Sl(v,1)).^(2),2 ) ,10,1);
        Ind_Con_Sl(:,v)=I;
        Val_Con_Sl(:,v)=B; 
    end
end

