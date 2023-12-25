function Ct= Neg_Poly_2(params, t)

a=params(:,1);
b=params(:,2);
c=params(:,3);

Ct= a./(t.^2) + b./t + c;

end