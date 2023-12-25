function C_p= Exp_4(params, t)

A1=params(1);
B1=params(2);
A2=params(3);
B2=params(4);
A3=params(5);
B3=params(6);
A4=params(7);
B4=params(8);
%% for lsqcurvefit
C_p= A1*exp(-1*B1*t) + A2*exp(-1*B2*t) + A3*exp(-1*B3*t) + A4*exp(-1*B4*t);

%% for lsqnonlin
%resi=y- a*exp(-1*b*x) + c*exp(-1*d*x) + e*exp(-1*f*x) + g*exp(-1*h*x);

% for fsolve
%resi=y- a*exp(-1*b*x) + c*exp(-1*d*x) + e*exp(-1*f*x) + g*exp(-1*h*x);
%sse=sum(resi.^(2));
end