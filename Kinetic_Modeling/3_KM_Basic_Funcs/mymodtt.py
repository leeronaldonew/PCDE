# -*- coding: utf-8 -*-

import numpy as np
import matplotlib.pyplot as plt
from scipy.optimize import curve_fit
from scipy.integrate import quad

#%%
xdata = [ -10.0, -9.0, -8.0, -7.0, -6.0, -5.0, -4.0, -3.0, -2.0, -1.0, 0.0, 1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0]
ydata = [1.2, 4.2, 6.7, 8.3, 10.6, 11.7, 13.5, 14.5, 15.7, 16.1, 16.6, 16.0, 15.4, 14.4, 14.2, 12.7, 10.3, 8.6, 6.1, 3.9, 2.1]

#Recast xdata and ydata into numpy arrays so we can use their handy features
xdata = np.asarray(xdata)
ydata = np.asarray(ydata)
plt.plot(xdata, ydata, 'o')


def Gauss(x, A, B):
    import numpy as np
    
    y = A*np.exp(-1*B*x**2)
    return y

test=Gauss(xdata, 1, 2)


def Linear (x, A,B):
    y=A*x+B
    return y


parameters, covariance = curve_fit(Gauss, xdata, ydata)
perr = np.sqrt(np.diag(covariance))

#%%
import numpy as np
import matplotlib.pyplot as plt
from scipy.optimize import curve_fit
from scipy.integrate import quad
import time as time
import pydicom #library for DICOM support


x=np.array([1,2,3,4,5,6])
tau=1.5;
A_1=1
A_2=0
A_3=0
Lamda_1=1
Lamda_2=0
Lamda_3=0

#%%
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

#%%
import numpy as np
import matplotlib.pyplot as plt
from scipy.optimize import curve_fit
from scipy.integrate import quad
import time as time

def Patlak (x, K_i, V_d):
    
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
    C_tot_over_C_p=(np.size(x))
    integ=np.zeros(np.size(x))
    Feng_value=np.zeros(np.size(x))
    
    tau=0.000356658660071742
    A_1=23177.1449488085
    A_2=19.2018417046470
    A_3=18.4487074499540
    Lamda_1=-85.6705870530595
    Lamda_2=-1.09182878990573
    Lamda_3=-0.0826756377537840
        
    for i in range(np.size(x)):
        integ[i]=quad(Feng, 0, x[i], args=(tau, A_1, A_2, A_3, Lamda_1, Lamda_2, Lamda_3) )[0]
        Feng_value[i]=Feng(x[i], tau, A_1, A_2, A_3, Lamda_1, Lamda_2, Lamda_3)
    
    #for i in range(np.size(x)):
    #    C_tot[i]=K_i*integ[i] + V_d*Feng_value[i]
    
    C_tot=K_i*integ + V_d*Feng_value
    #C_tot_over_C_p=K_i*(integ/Feng_value) + V_d
    
    return  C_tot

#%%
def Linear (x, A,B):
    y=A*x+B
    return y

#%% Fitting (Patlak)
xdata=np.array([1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16])
ydata=np.array([1.1, 2.3, 3.4, 4.6, 5.5, 6.1, 7.8, 8.9, 9.6, 10.6, 11.3, 12.5, 13.6, 14.5, 15.7, 16.9])

tic=time.time()
fit_result=curve_fit(Patlak,xdata,ydata,p0=np.array([0.5, 0.05]),bounds=([0,0], [1,1]) )
toc=time.time()
processing_time=toc-tic
print(processing_time)

#%% Fitting (Linear)
xdata=np.array([1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16])
ydata=np.array([1.1, 2.3, 3.4, 4.6, 5.5, 6.1, 7.8, 8.9, 9.6, 10.6, 11.3, 12.5, 13.6, 14.5, 15.7, 16.9])
tic=time.time()
fit_result=np.polyfit(xdata,ydata,1)
toc=time.time()
processing_time=toc-tic
print(processing_time)












# Lab1
import pydicom #library for DICOM support
import numpy as np  #arrays and matrices
import pydicom #library for DICOM support
import matplotlib.pyplot as plt #for visualization and plots
import pandas as pd #for data analysis

hdr = pydicom.read_file('Calibration.dcm')


a=hdr.EnergyWindowInformationSequence[0]
b=a.EnergyWindowRangeSequence[0]
float(b.EnergyWindowLowerLimit)


hdr.EnergyWindowInformationSequence[0].EnergyWindowRangeSequence[0]


nwin=6

ewin = {}
for w in range(nwin):
    ewin[w] = {}
    ewin[w]['lower'] = hdr.EnergyWindowInformationSequence[w].EnergyWindowRangeSequence[0].EnergyWindowLowerLimit
    ewin[w]['upper'] = hdr.EnergyWindowInformationSequence[w].EnergyWindowRangeSequence[0].EnergyWindowUpperLimit
    ewin[w]['center'] = ((ewin[w]['upper'] - ewin[w]['lower'])/2) + ewin[w]['lower']
    ewin[w]['width'] = ewin[w]['upper'] - ewin[w]['lower']


ewin







img = hdr.pixel_array
img.shape

plt.figure(figsize=(22,6))
for ind,i in enumerate(range(0,int(img.shape[0]),2)):
    # Top row Detector 1
    plt.subplot(2,6,ind+1)
    plt.imshow(img[i,:,:])
    plt.title(f'Detector1 {ewin[ind]["center"]} keV')
    plt.colorbar()
    
    
#     # Bottom row Detector 2
    plt.subplot(2,6,ind+7)
    plt.imshow(img[i+1,:,:])
    plt.title(f'Detector2 {ewin[ind]["center"]} keV')
    plt.colorbar()
plt.tight_layout()


# How many counts do you have in each window for each detector?
counts_tot={"Detector1": {}, "Detector2": {} }
for i in range(0, 6, 1):
    counts_tot["Detector1"][str(round(ewin[i]["center"]))]=np.sum(img[i*2,:,:])
    counts_tot["Detector2"][str(round(ewin[i]["center"]))]=np.sum(img[i*2+1,:,:])
    
plt.scatter([95,113,139,170,208,255],[counts_tot["Detector1"]["95"],counts_tot["Detector1"]["113"],counts_tot["Detector1"]["139"],counts_tot["Detector1"]["170"],counts_tot["Detector1"]["208"],counts_tot["Detector1"]["255"] ] )
plt.scatter([95,113,139,170,208,255],[counts_tot["Detector2"]["95"],counts_tot["Detector2"]["113"],counts_tot["Detector2"]["139"],counts_tot["Detector2"]["170"],counts_tot["Detector2"]["208"],counts_tot["Detector2"]["255"] ] )

# Triple Energy Windwow Scatter Correction
# There are two photopeaks for Lu-177 (i.e., 113 keV and 208 keV)
counts_scat={"Detector1": {}, "Detector2": {} }
counts_scat["Detector1"]["113keV"]= ((counts_tot["Detector1"]["95"]/ewin[0]["width"])+(counts_tot["Detector1"]["139"]/ewin[2]["width"])) * (ewin[1]["width"]/2)
counts_scat["Detector2"]["113keV"]= ((counts_tot["Detector2"]["95"]/ewin[0]["width"])+(counts_tot["Detector2"]["139"]/ewin[2]["width"])) * (ewin[1]["width"]/2)
counts_scat["Detector1"]["208keV"]= ((counts_tot["Detector1"]["170"]/ewin[3]["width"])+(counts_tot["Detector1"]["255"]/ewin[5]["width"])) * (ewin[4]["width"]/2)
counts_scat["Detector2"]["208keV"]= ((counts_tot["Detector2"]["170"]/ewin[3]["width"])+(counts_tot["Detector2"]["255"]/ewin[5]["width"])) * (ewin[4]["width"]/2)

counts_pri={"Detector1": {}, "Detector2": {} }
counts_pri["Detector1"]["113keV"]= (counts_tot["Detector1"]["113"]) - (counts_scat["Detector1"]["113keV"])
counts_pri["Detector2"]["113keV"]= (counts_tot["Detector2"]["113"]) - (counts_scat["Detector2"]["113keV"])
counts_pri["Detector1"]["208keV"]= (counts_tot["Detector1"]["208"]) - (counts_scat["Detector1"]["208keV"])
counts_pri["Detector2"]["208keV"]= (counts_tot["Detector2"]["208"]) - (counts_scat["Detector2"]["208keV"])


# Calculate the activity of the source at the time of acquisition?
from datetime import datetime

A0 =13 #MBq [MBq]
t_ref = '20140123 175900'
t_acq = f"{hdr.AcquisitionDate} {hdr.AcquisitionTime.split('.')[0]}"
t_ref = datetime.strptime(t_ref,'%Y%m%d %H%M%S')
t_acq = datetime.strptime(t_acq,'%Y%m%d %H%M%S')
delta_t = t_acq - t_ref
delta = delta_t.total_seconds()/60 #this gives delta_t in minutes [min]
delta_day=delta/(24*60) # converting [min] to [day]

def activity_decay(A_initial,delta_t,half_life):
    A_decayed=A_initial*((0.5)**(delta_t/half_life))  
    return A_decayed

half_life=6.74 # for Lu-177, half life = 6.74 [day]
A_acq=activity_decay(A0,delta_day,half_life)

# Use Detector 1 for the following
det= 'Detector1'

# Calculate the sensitivity of this gamma camera for the 208 keV photopeak of Lu-177 in cpm/kBq (not corrected)
Acq_duration=(float(hdr.ActualFrameDuration)/60) * (10**(-3)) # converting [msec] into [min]
sens_208_not_corrected= (counts_tot[det]["208"]/Acq_duration)/(1000*A_acq) # calc. of sensitivy (not corrected) [cpm/kBq]

# Calculate the sensitivity of this gamma camera for the 208 keV photopeak of Lu-177 corrected for scatter in cpm/kBq (corrected)
sens_208_corrected= (counts_pri[det]["208keV"]/Acq_duration)/(1000*A_acq) # calc. of sensitivy (not corrected) [cpm/kBq]

# Which of the 2 sensitivity values would you use to generate quantitatively accurate images? why?
print("we should use the second(corrected) sensitivity!")
print("This is because we ultimately hope to quantify some quantity from the source at each specific position.")
print("The scattered radiation is most likeliy to originate from the other source in other position, which we hope not to be detected")


#%% Lab #2

# Install libraries and Download data
!pip install phantominator pydicom matplotlib numpy
!wget https://github.com/carluri/nucmed_physics_examples/raw/master/Lab2/suv.dcm

# Load libraries
import matplotlib.pyplot as plt
import numpy as np

# Shepp-Logan Phantom
from phantominator import shepp_logan
true_img=shepp_logan(256)

# Display the phantom using a 'Greys_r' colormap and place the origin of the axes in the lower left corner
plt.imshow(true_img, cmap='Greys_r', origin='lower')

# Image Reconstruction

# Forward projection and backprojection (radon: forward projection, iradon: backward projection)
from skimage.transform import radon, iradon
# 1) Use np.arange to generate an array from 0 to 179 degrees every one degree
Array_1_deg=np.arange(0,180,1)
# 2) Use np.arange to generate an array from 0 to 179 degrees every three degrees
Array_3_deg=np.arange(0,180,3)
# Assume you have a gamma camera that you will be using to collect projections of the Shepp-Logan phantom at every 3 degrees for half a full rotation. Store those angles in proj_angles
proj_angles=np.arange(0,180,3)
# Let's now FORWARD PROJECT the phantom and stack the projections together in a sinogram
sino= radon(true_img, theta=proj_angles, circle='True', preserve_range='True')
sino.shape
# Display the sinogram by showing the projection angle on the vertical axis and the projection bin in the horizontal axis
sino_real=sino.T
plt.figure(figsize=(12,16))
plt.imshow(sino_real, cmap='Greys_r', origin='lower', extent=(0, 256, 0, 180))
plt.xlabel("Projection Bin")
plt.ylabel("Projection Angle (degrees)")
# Now use the sinogram above and reconstruct the image using the backprojection algorithm (i.e., no filter)
recon=iradon(sino,theta=proj_angles, filter_name=None, circle='True', preserve_range='True')
plt.subplot(1,2,1)
plt.imshow(recon, cmap='Greys_r')
plt.title("Reconstructed Image")
plt.axis('off')
plt.subplot(1,2,2)
plt.imshow(true_img, cmap='Greys_r')
plt.title("True Image")
plt.axis('off')
# Now try using Filtered-Backprojection (with "Ramp", "Shepp-Logan", "Hamming" filters)
proj_angles_FB=np.arange(0,180,3) # projection angles for FBP
sino_FB= radon(true_img, theta=proj_angles_FB, circle='True', preserve_range='True') 
recon_FB_ramp=iradon(sino_FB, theta=proj_angles_FB, filter_name='ramp', circle='True', preserve_range='True') # with Ramp filter
recon_FB_shepplogan=iradon(sino_FB, theta=proj_angles_FB, filter_name='shepp-logan', circle='True', preserve_range='True') # with Shepp-Logan filter
recon_FB_hamming=iradon(sino_FB,theta=proj_angles_FB, filter_name='hamming', circle='True', preserve_range='True') # with Hamming filter
plt.subplot(3,3,1)
plt.imshow(recon_FB_ramp, cmap='Greys_r')
plt.title("Recon(Ramp)")
plt.axis('off')
plt.subplot(3,3,2)
plt.imshow(true_img, cmap='Greys_r')
plt.title("True")
plt.axis('off')
plt.subplot(3,3,3)
plt.imshow(true_img - recon_FB_ramp, cmap='Greys_r')
plt.title("True - Recon(Ramp)")
plt.axis('off')
plt.subplot(3,3,4)
plt.imshow(recon_FB_shepplogan, cmap='Greys_r')
plt.title("Recon(Shepp-Logan)")
plt.axis('off')
plt.subplot(3,3,5)
plt.imshow(true_img, cmap='Greys_r')
plt.title("True")
plt.axis('off')
plt.subplot(3,3,6)
plt.imshow(true_img - recon_FB_shepplogan, cmap='Greys_r')
plt.title("True - Recon(Shepp-Logan)")
plt.axis('off')
plt.subplot(3,3,7)
plt.imshow(recon_FB_hamming, cmap='Greys_r')
plt.title("Recon(Hamming)")
plt.axis('off')
plt.subplot(3,3,8)
plt.imshow(true_img, cmap='Greys_r')
plt.title("True")
plt.axis('off')
plt.subplot(3,3,9)
plt.imshow(true_img - recon_FB_hamming, cmap='Greys_r')
plt.title("True - Recon(Hamming)")
plt.axis('off')

# Maximum Likilihood Expectation Maximization (MLEM)
# Defining the Mean Squared Error
def mse(imageA, imageB):
	err = np.sum((imageA.astype("float") - imageB.astype("float")) ** 2)
	err /= float(imageA.shape[0] * imageA.shape[1])
	return err
# Defining the MLEM function
def mlem(measured_sino,n_it,original,proj_angles):    
    # Define a sinogram filled with "ones" which we will use to normalize the data
    # and that has the same shape as the measured sinogram
    sino_ones = np.ones(measured_sino.shape)
    # Backrpoject the sino_ones sinogram. Be careful to specify that no filter is required
    backproj_of_ones = iradon(sino_ones, theta=proj_angles, filter_name=None, circle='True', preserve_range='True')
    # This will be the loop that will run the iterations
    for i in range(1,n_it+1):
        if i == 1:
            estimate = np.ones(backproj_of_ones.shape) # Defining the first estimate as matrix filled with ones           
            mserr = []        
        estimate_sino = radon(estimate, theta=proj_angles, circle='True', preserve_range='True')
        ratio = np.divide(measured_sino, estimate_sino, out=np.zeros_like(measured_sino), where=estimate_sino!=0)
        backproj = iradon(ratio, theta=proj_angles, filter_name=None, circle='True', preserve_range='True')
        # Before generating the new estimate, visualize what you've been doing.
        # let's only show every 10th iteration
        if i==1 or i%10 == 0:
            plt.figure(figsize=(8,8))
            plt.subplot(2,3,1)
            plt.title(f'Estimate {i}')
            plt.imshow(estimate,cmap='Greys_r') #add a line to show the current estimate
            plt.axis('off')
            plt.subplot(2,3,2)
            plt.title(f'Sinogram of Estimate')
            plt.imshow(estimate_sino.T, cmap='Greys_r')# add a line to show the estimated sinogram
            plt.axis('off')
            plt.subplot(2,3,3)
            plt.title(f'True - Estimate')
            plt.imshow(original - estimate, cmap='Greys_r')# add a line to show the difference between original and estimated image
            plt.axis('off')
            plt.subplot(2,3,5)
            plt.title(f'Measured Sinogram')
            plt.imshow(measured_sino.T, cmap='Greys_r') # add a line to show the measured sinogram
            plt.axis('off') 
            plt.subplot(2,3,4)
            plt.title(f'Truth')
            plt.imshow(original, cmap='Greys_r') # add a line to show the original image
            plt.axis('off')
            plt.subplot(2,3,6)
            plt.title(f'Measured/Estimate')
            plt.imshow(ratio.T, cmap='Greys_r') #add a line to show the ratio of the measured and estimated sinogram         
            plt.suptitle(f'Iteration {i}')
            plt.axis('off')
            plt.tight_layout()
            plt.show()
        # Now generate a new estimate
        # First multiply the current estimate by the backrpojected ratio of the sinograms
        # hint use np.multiply
        #estimate = backproj * estimate #modify this line with your code
        estimate = np.multiply(backproj, estimate)
        #now you need to normalize the new image to maintain the number of counts
        estimate= np.divide(estimate, backproj_of_ones, out=np.zeros_like(estimate), where=backproj_of_ones!=0)
        # append the current mse to this iteration
        mserr.append(mse(original,estimate))
    return mserr
 
# run your function, test a different nubmer of iterations. Play with your code and try
#to understand what is happening at each step
proj_angles= np.arange(0,180,1)
measured_sino=radon(true_img, theta=proj_angles, circle='True', preserve_range='True') 
n_it=30
original=true_img
mlem_mse = mlem(measured_sino,n_it,original,proj_angles) #edit this line with your code   

# Explain your results from the plot above in this cell
# plot the MSE and try to explain in the next cell what you see
plt.plot(range(len(mlem_mse)),mlem_mse)
plt.xlabel("Iteration")
plt.ylabel('MSE')
plt.title('MSE vs. Iterative Updates');
print("As you can see from the graph above, the MSE decreases with the # of iteration. This is because as the iteration is repeated the difference between True image and the Estimated image(i.e., updated image) is getting more smaller, in terms of the MSE(Mean Squared Error)")

# OSEM will use subsets of the projections for each iteration. First we need a way of generating subsets from the projection angles
subsets = {}
n_subsets = 10
proj_angles=np.arange(0,180,3)
for s in range(n_subsets):
    if not len(proj_angles) % n_subsets:
        subsets[s] = proj_angles[s: :n_subsets]
    else:
        print("Number of subsets should be a divisor of the total number of projections.")
        break
proj_angles
subsets
 
# Similar to what was done for MLEM, try to code a function for OSEM
def osem(measured_sino, n_it, original, proj_angles, subsets):   
    # start a counter to keep track of the iterative updates   
    s_ind = 0       
    
    # start the loop to iterate
    for i in range(1,n_it+1):    
        if i == 1:
            # create your first image estimate
            estimate = np.ones(original.shape) #modify this line to create your estimate           
            # create an empty list to store the MSE
            mserr = []        
        # start the loop to iterate over the subsets, i.e. only use certain projection angles
        for s in subsets.values():         
            # because each subset has few angles, we need to define a way of finding the corresponding
            #angle. The indices provide the index within a subset that correspond to a particular angle
            indices = np.in1d(proj_angles,s) 
            # Take only the projections at the angle of the current subset
            measured_sino_subset = measured_sino[:,indices]   
            estimate_sino_subset=radon(estimate, theta=s, circle='True', preserve_range='True')
            ratio = np.divide(measured_sino_subset, estimate_sino_subset, out=np.zeros_like(measured_sino_subset), where=estimate_sino_subset!=0 ) #modify this line with your code
            # Now you need to backproject the "ratio sinogram". Again, be careful as now you will have
            # to do this for the corresponding angles in the subset
            backproj = iradon(ratio,theta=s,filter_name=None)     
            # There are more efficient ways of doing this step, but here we are trying to be
            # very explicit.
            # Create a sinogram of ones with the same shape as the measured sinogram
            sino_ones = np.ones(measured_sino.shape)
            # Backproject this sinogram only using the subset angles 
            backproj_of_ones = iradon(sino_ones[:,indices],filter_name=None, circle='True', preserve_range='True')
            # Now generate a new estimate
            # First multiply the current estimate by the backrpojected ratio of the sinograms
            # hint use np.multiply
            estimate = np.multiply(backproj, estimate) #modify this line with your code
            estimate = np.divide(estimate, backproj_of_ones, out=np.zeros_like(estimate), where=backproj_of_ones!=0)      
            # update the iterative updates counter
            s_ind+=1   
            # generate plots on every 10 iterative updates 
            if s_ind==1 or s_ind%10 == 0:
                plt.figure(figsize=(8,8))
                plt.subplot(2,3,1)
                plt.title(f'Estimate {i}')
                plt.imshow(estimate,cmap='Greys_r',origin='lower')
                plt.axis('off')
                plt.subplot(2,3,2)
                plt.title(f'Sinogram of Estimate')
                plt.imshow(estimate_sino_subset.T,cmap='Greys_r',origin='lower',extent=(0,estimate_sino_subset.shape[0],0,max(proj_angles)+1),interpolation='none')
                plt.axis('off')
                plt.subplot(2,3,3)
                plt.title(f'True - Estimate')
                plt.imshow( original - estimate , cmap='Greys_r',origin='lower')
                plt.axis('off')
                plt.subplot(2,3,5)
                plt.title(f'Measured Sinogram')
                plt.imshow(measured_sino_subset.T,cmap='Greys_r',origin='lower',extent=(0,measured_sino_subset.shape[0],0,max(proj_angles)+1),interpolation='none')
                plt.axis('off')
                plt.subplot(2,3,4)
                plt.title(f'Truth')            
                plt.imshow(original,cmap='Greys_r',origin='lower')
                plt.axis('off')
                plt.subplot(2,3,6)
                plt.title(f'Measured/Estimate')
                plt.imshow(ratio.T,cmap='Greys_r',origin='lower',extent=(0,ratio.shape[0],0,max(proj_angles)+1),interpolation='none')
                plt.suptitle(f'Iterative update {s_ind}')
                plt.axis('off')
                plt.tight_layout()
                plt.show()              
        mserr.append(mse(original,estimate))
    return mserr

# run your function, test a different nubmer of iterations maybe even also a different number of subsets.
#Play with your code and try to understand what is happening at each step
proj_angles= np.arange(0,180,1)
measured_sino=radon(true_img, theta=proj_angles, circle='True', preserve_range='True') 
n_it=30
original=true_img
n_subsets = 10
subsets = {}
for s in range(n_subsets):
    if not len(proj_angles) % n_subsets:
        subsets[s] = proj_angles[s: :n_subsets]
    else:
        print("Number of subsets should be a divisor of the total number of projections.")
        break

mlem_mse = mlem(measured_sino, n_it, original, proj_angles) #edit this line with your code 
osem_mse = osem(measured_sino, n_it, original, proj_angles, subsets) #replace this line with your code to run OSEM

# plot the MSE of both MLEM and OSEM
# what do you think?
plt.plot(range(len(osem_mse)),osem_mse)
plt.plot(range(len(mlem_mse)),mlem_mse)
plt.xlabel("Iterations")
plt.ylabel('MSE')
plt.title('MSE vs. Iterations');

# Write a short answer analyzing the MSE of your Two recon algorithms
print("As you can see from the graph above, both algorithms (orange: MLEM, blue: OSEM) have a trend that the MSE decreases with the # of iteration. However, the OSEM algorirhm is better than the MLEM in terms of MSE statistics, and the OSEM alrogirhm is much more fastly converged into the minimum MSE. Thus, at least for this case, the OSEM algorithm is more accurate and time-efficient than the MLEM algorithm.")

# Standard Uptake Value (SUV)
import pydicom
from skimage.measure import find_contours
from datetime import datetime
import matplotlib.pyplot as plt
import numpy as np


# Similar to Lab #1, load the SUV.dcm dicom file contained in the current folder
ds=pydicom.read_file('suv.dcm')
# Similar to Lab #1, load the image data into the img variable
img=ds.pixel_array
# Display the image using the Greys colormap
plt.imshow(img, cmap='Greys')
# Let's look into a way to change our image from "pixel units" to "data units"
ConstPixelDims = (int(ds.Columns), int(ds.Rows), 1) # Load dimensions based on the number of columns (x), rows (y), and slices (Z axis)
ConstPixelSpacing = (float(ds.PixelSpacing[0]), float(ds.PixelSpacing[1]), float(ds.SliceThickness)) # Load spacing values (in mm)
max_xy = (np.array(ConstPixelDims)-1)*ConstPixelSpacing/2
x = np.linspace(-max_xy[0], max_xy[0], ConstPixelDims[0])
y = np.linspace(-max_xy[1], max_xy[1], ConstPixelDims[1])
z = float(ds.SliceLocation)
image_grid = (x, y, z)

plt.imshow(img,cmap='Greys',extent=(image_grid[0][0], image_grid[0][-1], image_grid[1][-1], image_grid[1][0]));
plt.xlabel('mm');
plt.ylabel('mm');

# It would be great to measure something from the image. Banary masks are great for this, but here is a method to generate masks using functions
# create a grid to easily make a mask
xx, yy = np.meshgrid(image_grid[0], image_grid[1], sparse=False)

plt.imshow(xx)
plt.colorbar()

plt.imshow(yy)
plt.colorbar()

mask = (xx > 0) & (yy > 0)
plt.imshow(mask,extent=(image_grid[0][0], image_grid[0][-1], image_grid[1][-1], image_grid[1][0]))

# Can you creat a mask that corresponds to a circle centered at the origin and with a radius of 60 mm?
mask =  (xx**2 + yy**2) <= 3600 # replace this line to create the circular mask
plt.imshow(mask,extent=(image_grid[0][0], image_grid[0][-1], image_grid[1][-1], image_grid[1][0]))

# Here's a method to obtain the contour of the mask and plot it over the image
# find the contours in the binary mask
contours = find_contours(mask, 0.5)
contours[0][:, 1] = (contours[0][:, 1])*ds.PixelSpacing[0]+ds.ImagePositionPatient[0]
contours[0][:, 0] = (contours[0][:, 0])*ds.PixelSpacing[1]+ds.ImagePositionPatient[1]

plt.imshow(img,cmap='Greys',extent=(image_grid[0][0], image_grid[0][-1], image_grid[1][-1], image_grid[1][0]));
plt.plot(contours[0][:,1],contours[0][:,0],color='green');
plt.colorbar();

# Let's check what is the data type of the loaded image
img

# RescaleSlope and RescaleIntercept
# What are the slope and intercept for this particular image?
slope=ds.RescaleSlope
slope
intercept=ds.RescaleIntercept
intercept

# Because our current image type
img=img.astype(float)
img

# Rescale your image
img= (img*slope) + intercept

# You can now use the created mask to slice the image matrix anbd select only the pixels that are "True"
img[mask].sum()
segmented_img=img[mask]
sum_seg=np.sum(segmented_img)
# Try calculating the mean and max value of that region of the image
img_max=np.amax(img[mask])
img_mean=np.average(img[mask])
# What are the units of values you just listed above?
print(ds.Units, ". Thus, the unit of the values is [Bq/ml]")

# Let's now show our image in SUV units. As a reminder SUV is defined as...
# Starting by finding the mass of the patient
body_mass_kg=ds.PatientWeight # Unit: Kg
body_mass_g=body_mass_kg * 1000 # Unit: g
# For information about injected activity
Radiopharma_info=ds.RadiopharmaceuticalInformationSequence
Injec_activity=Radiopharma_info[0].RadionuclideTotalDose # Unit [Bq]
Injec_activity_MBq= (Injec_activity / 1000000) # converting the unit as [MBq]
Radiopharma_info[0]
# And now let's create a function that given a dicom header it returns the image in SUV units
def suvbw(hdr, bm_g):
    '''Returns an image in units of SUV based on body weight.This function is based on the calculation described in the Quantitative Imaging Biomarkers Alliance 
    for the Vendor-neutral pseudo-code for SUV Calculation - extracted "happy path only". http://qibawiki.rsna.org/index.php/Standardized_Uptake_Value_(SUV)

    INPUT: 
            hdr: (object)
                the header of the DICOM slice

            bm: (float)
                the mass of the patient or object in grams. This is usually obtained from the header but in some cases (e.g. phantom scans) it is convenient to specify it manually due to rounding introduced by the scanner

    OUTPUT: suvbw_img: (numpy.ndarray) 
            matrix that contains the pixel information in "SUVbw" units (i.e. (Bq/ml)/(Bq/g)
    '''

    if ('ATTN' in hdr.CorrectedImage and 'DECY' in hdr.CorrectedImage) and hdr.DecayCorrection == 'START':
        if hdr.Units == 'BQML':
            
            # You will need to do some decay correction. Use the RadiopharmaceuticalInformationSequence
            # to obtain the half life of the radioisotope injected       
            half_life = hdr.RadiopharmaceuticalInformationSequence[0].RadionuclideHalfLife  # unit: [sec]
            #you also need to know the time at which this series was acquired
            scan_time = hdr.AcquisitionTime #modify this line to find the time of scan for this series
            start_time = hdr.RadiopharmaceuticalInformationSequence[0].RadiopharmaceuticalStartTime #modify this line to get the injection time
            # convert tref and injtime from strings to datetime
            scan_time = datetime.strptime(scan_time.split('.')[0], '%H%M%S')
            start_time = datetime.strptime(start_time.split('.')[0], '%H%M%S')
            # You now need to know what was the time of decay. You're trying to decay the activity to the scan time.
            decay_time = scan_time - start_time
            # You need to know how much activity was injected. Again find it in the RadiopharmaceuticalInformationSequence
            inj_act = hdr.RadiopharmaceuticalInformationSequence[0].RadionuclideTotalDose # edit this line to get the injected activity   
            # Now you can apply the decay correction
            decayed_act = inj_act * 2**(-decay_time.total_seconds()/half_life) # Unit: [Bq]
            # Use the input bm and the decayed activity to find the factor by which the image from the header needs to be
            # multipled for to obtain values in "SUV"
            SUVbw_scale_factor = bm_g / decayed_act #modify this line to obtain the scale factor    
            # lastly, load the pixel array from the dicom data, rescale it to the appropriate float values, and 
            #multiply the SUV scale factor you just calculated to obtain the image in SUV
            suvbw_img = ((hdr.pixel_array *hdr.RescaleSlope) +hdr.RescaleIntercept) * SUVbw_scale_factor #modify this line          
            # return the image
            return suvbw_img

img_suv=suvbw(ds, body_mass_g)
# Display the image again
plt.imshow(img_suv,cmap='Greys',extent=(image_grid[0][0], image_grid[0][-1], image_grid[1][-1], image_grid[1][0]));
plt.plot(contours[0][:,1],contours[0][:,0],color='green')
plt.colorbar()

# Lastly, calculate the mean and the max SUV in the circular region that you have already created
suv_max=np.amax(img_suv[mask])
suv_mean=np.average(img_suv[mask])

