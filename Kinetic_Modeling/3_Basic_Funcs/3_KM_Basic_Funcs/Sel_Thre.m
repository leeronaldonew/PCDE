function [sel_val,sel_ind]=Sel_Thre(sort_ind,sort_val,thre)

sel_ind=sort_ind(find(sort_val < thre));
sel_val=sort_val(find(sort_val < thre));

end