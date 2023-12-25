def osem(measured_sino,n_it,original,proj_angles,subsets):   
    s_ind = 0  
    for i in range(1,n_it+1):    
        if i == 1:
            estimate = np.ones(original.shape) #modify this line to create your estimate
            mserr = []
        for s in subsets.values():
            indices = np.in1d(proj_angles,s) 
            sampled_sino = measured_sino[:,indices]            
            forward_estimate = radon(estimate, theta=s, circle='True', preserve_range='True')#modify this line with your code
            ratio = np.divide (sampled_sino, forward_estimate, out=np.zeros_like(sampled_sino), where=forward_estimate!=0 )#modify this line with your code
            backproj = iradon(ratio,theta=s,filter_name=None)
            
            sino_ones = np.ones(measured_sino.shape)
            # Backproject this sinogram only using the subset angles 
            backproj_of_ones = iradon(sino_ones[:,indices],filter_name=None)
            
            estimate = np.multiply(estimate, backproj_of_ones) #modify this line with your code
            estimate = estimate / np.sum(estimate) #modify this line with your code
            
            # update the iterative updates counter
            s_ind+=1     
        mserr.append(mse(original,estimate))

    return mserr
