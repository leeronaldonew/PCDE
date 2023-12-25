function Ct= Inv_X_S(params, t)

a=params(:,1);
b=params(:,2);


Ct= a./(t.^2) + b;

end