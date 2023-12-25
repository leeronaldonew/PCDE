def Gauss(x, A, B):
  
    
    y = A*np.exp(-1*B*x**2)
    return y

def Linear (x, A,B):
    y=A*x+B
    return y