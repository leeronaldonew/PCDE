using PyPlot
#using CurveFit
using LsqFit
using QuadGK
using Cubature
using Pkg

#x = 0.0:0.02:2.0
#y0 = @. 1 + x + x*x + randn()/10
#fit = curve_fit(Polynomial, x, y0, 2)
#y0b = fit.(x)
#plot(x, y0, "o", x, y0b, "r-", linewidth=3)


#xdata=[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16];
#ydata=[1.1, 2.3, 3.4, 4.6, 5.5, 6.1, 7.8, 8.9, 9.6, 10.6, 11.3, 12.5, 13.6, 14.5, 15.7, 16.9];

xdata=[1.0,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16]
ydata=[1.1, 2.3, 3.4, 4.6, 5.5, 6.1, 7.8, 8.9, 9.6, 10.6, 11.3, 12.5, 13.6, 14.5, 15.7, 16.9]
p0 = [0.5, 0.05]

tau=0.000356658660071742
A_1=23177.1449488085
A_2=19.2018417046470
A_3=18.4487074499540
Lamda_1=-85.6705870530595
Lamda_2=-1.09182878990573
Lamda_3=-0.0826756377537840
params=[tau, A_1, A_2, A_3, Lamda_1, Lamda_2, Lamda_3]

L(x,p)=@. (p[1] * x + p[2])

## Defining Patlak Analysis
    function Patlak(x, p)
        tau=0.000356658660071742
        A_1=23177.1449488085
        A_2=19.2018417046470
        A_3=18.4487074499540
        Lamda_1=-85.6705870530595
        Lamda_2=-1.09182878990573
        Lamda_3=-0.0826756377537840
        function Feng(x, tau, A_1, A_2, A_3, Lamda_1, Lamda_2, Lamda_3)
            if size(x,1) == 1
                x=Vector{Float64}([x])
            else
            end
            C_tot=zeros(size(x)[1])
            for i in 1:size(x)[1]
                if x[i] < tau
                    C_tot[i]=0.0
                else
                    C_tot[i]=(A_1*(x[i]-tau)-A_2-A_3)*exp(Lamda_1*(x[i]-tau)) + A_2*exp(Lamda_2*(x[i]-tau)) + A_3*exp(Lamda_3*(x[i]-tau))
                end
            end
            return C_tot
        end
        C_tot_patlak=zeros(size(x)[1])
        integ=zeros(size(x)[1])
        Feng_val=zeros(size(x)[1])
        for i in 1:size(x)[1]
            integ[i]=quadgk(x->Feng(x, tau, A_1, A_2, A_3, Lamda_1, Lamda_2, Lamda_3), 0, x[i])[1][1]
            Feng_val[i]=Feng(x[i],tau, A_1, A_2, A_3, Lamda_1, Lamda_2, Lamda_3)[1]
        end
        C_tot_patlak=p[1]*integ + p[2]*Feng_val
        return C_tot_patlak
    end



##

## Fitting (Patlak)
xdata=[1.0,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16]
ydata=[1.1, 2.3, 3.4, 4.6, 5.5, 6.1, 7.8, 8.9, 9.6, 10.6, 11.3, 12.5, 13.6, 14.5, 15.7, 16.9]
p0 = [0.5, 0.05]
@time fit=curve_fit(Patlak, xdata, ydata, p0)





integ=quadgk(x->Feng(x, tau, A_1, A_2, A_3, Lamda_1, Lamda_2, Lamda_3), 0, 1)[1]

exp_new(x,a,b)=a*exp(-b*x)
@time quadgk(x->exp_new(x,1,1), 0, 1)
f(x)=exp(-x)
@time quadgk(f,0,1)
@time quadgk(x->exp(-x), 0,1)

function exp_new_new(x,a,b)
    val=zeros(size(x)[1])
    for i in (1:size(x)[1])
        val[i]=a*exp(-b*x[i])
    end
    return val
end
function exp_new_new(x,a,b)
    val=a*exp(-b*x)
    return val
end


quadgk(x->exp_new_new(x,1,1), 0,1)
hquadrature(x->exp_new_new(x,1,1), 0, 1)




@time fit=curve_fit(L, xdata, ydata, p0)


fit=curve_fit(m, xdata, ydata, p0)


m(t, p) = p[1] * exp.(p[2] * t)
p0 = [0.5, 0.5]
fit = curve_fit(m, xdata, ydata, p0)
