function Ct= Exp_New(params, t)

a=params(:,1);
b=params(:,2);
c=params(:,3);

Ct= c-a.*exp(-b.*t);

end