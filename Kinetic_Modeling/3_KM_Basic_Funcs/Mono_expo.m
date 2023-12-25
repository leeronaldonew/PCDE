function C_p= Mono_expo(params, x)

t=x;
a=params(1);
b=params(2);

C_p= a*exp(-1*b*t);


end