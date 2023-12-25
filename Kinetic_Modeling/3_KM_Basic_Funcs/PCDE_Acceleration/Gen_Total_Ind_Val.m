function [Vals,Inds]=Gen_Total_Ind_Val(Initial_List,Ind_ROA,Ind_Ct,Ind_Sl,Ind_Acc,Ind_Con_Ct,Ind_Con_Sl,Ind_MI,Val_10,Val_ROA,Val_Ct,Val_Sl,Val_Acc,Val_Con_Ct,Val_Con_Sl,Val_MI)

Inds=zeros(10,size(Initial_List,2),8,'single');
Vals=zeros(10,size(Initial_List,2),8,'single');

Inds(:,:,1)=Initial_List;
Inds(:,:,2)=Ind_ROA;
Inds(:,:,3)=Ind_Ct;
Inds(:,:,4)=Ind_Sl;
Inds(:,:,5)=Ind_Acc;
Inds(:,:,6)=Ind_Con_Ct;
Inds(:,:,7)=Ind_Con_Sl;
Inds(:,:,8)=Ind_MI;

Vals(:,:,1)=Val_10;
Vals(:,:,2)=Val_ROA;
Vals(:,:,3)=Val_Ct;
Vals(:,:,4)=Val_Sl;
Vals(:,:,5)=Val_Acc;
Vals(:,:,6)=Val_Con_Ct;
Vals(:,:,7)=Val_Con_Sl;
Vals(:,:,8)=Val_MI;


end