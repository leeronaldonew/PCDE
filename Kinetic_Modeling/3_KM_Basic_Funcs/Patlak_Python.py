def Patlak (x, K_i, V_d):
    import numpy as np
    from scipy.optimize import curve_fit
    from scipy.integrate import quad
    import time as time 
    
    def Feng(x, tau, A_1, A_2, A_3, Lamda_1, Lamda_2, Lamda_3):
       
        if np.size(x)==1:
            x=np.array([x])
        else:
            x=np.array(x)
            
        C_p=np.zeros(np.size(x))
        
        for i in range(np.size(x)):
            if x[i] < tau:
                C_p[i]=0.0
            else:
                C_p[i]=(A_1*(x[i]-tau)-A_2-A_3)*np.exp(Lamda_1*(x[i]-tau)) + A_2*np.exp(Lamda_2*(x[i]-tau)) + A_3*np.exp(Lamda_3*(x[i]-tau))  
        
        return C_p
    
    C_tot=np.zeros(np.size(x))
    integ=np.zeros(np.size(x))
    
    tau=0.000356658660071742
    A_1=23177.1449488085
    A_2=19.2018417046470
    A_3=18.4487074499540
    Lamda_1=-85.6705870530595
    Lamda_2=-1.09182878990573
    Lamda_3=-0.0826756377537840
        
    for i in range(np.size(x)):
        integ[i]=quad(Feng, 0, x[i], args=(tau, A_1, A_2, A_3, Lamda_1, Lamda_2, Lamda_3) )[0]
    
    for i in range(np.size(x)):
        C_tot[i]=K_i*integ[i] + V_d*Feng(x[i], tau, A_1, A_2, A_3, Lamda_1, Lamda_2, Lamda_3)
    
    return  C_tot
