function [Initial_List]=Gen_Initial_List(Ind_10)

Initial_List=zeros(10,size(Ind_10,2),'single');
for v=1:1:size(Ind_10,2)
    if Ind_10(:,v)==0
        Initial_List(:,v)=0;
    else
        Initial_List(:,v)=[1:1:10]';
    end    
end

end