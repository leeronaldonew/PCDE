function [Abs_Ind]=Conv_Rel_to_Abs_Ind(Ind_300,Ind_10)

Abs_Ind=zeros(10,size(Ind_10,2),'single');

for v=1:1:size(Ind_10,2)
    if Ind_10(:,v)==0
        Abs_Ind(:,v)=0;
    else
        Abs_Ind(:,v)=Ind_300(Ind_10(:,v),v);
    end    
end

end