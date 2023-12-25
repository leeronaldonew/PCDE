function Ct= Lin_Exp(params, t)

a=params(:,1);
b=params(:,2);
%c=params(3);

%Ct= a*exp(-1*b*t)+c;

Ct= a.*exp(-1.*b.*t);

end