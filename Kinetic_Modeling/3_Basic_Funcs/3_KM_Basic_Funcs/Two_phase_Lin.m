function Yt = Two_phase_Lin(params,t)

a1=params(1);
b1=params(2);
a2=params(3);
b2=params(4);

t_thre= (b1-b2) / (a2-a1);

if a2==a1
    t_thre=0;
end

for i=1:1:size(t,2)
    if t(i) <= t_thre
        Yt(i)=a1*t(i) + b1;
    else
        Yt(i)=a2*t(i) + b2;
    end
end


end