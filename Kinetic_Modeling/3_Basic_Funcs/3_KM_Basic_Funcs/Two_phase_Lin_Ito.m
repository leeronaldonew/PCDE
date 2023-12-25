function Yt = Two_phase_Lin_Ito(params,t)

a1=params(1);
b1=params(2);
x_th=params(3);
a2=params(4);

b2=x_th*(a2-a1)+b1;


for i=1:1:size(t,2)
    if t(i) < x_th
        Yt(i)=-1*a1*t(i) + b1;
    else
        Yt(i)=-1*a2*t(i) + b2;
    end
end


end


