function Ct=TTCM_Conv(params, x) 


global Local_Estimates;

k1=params(:,1);
k2=params(:,2);
k3=params(:,3);
k4=params(:,4);

Defined_Time=[0:0.01:90];

Cp=transpose(Feng(Local_Estimates,Defined_Time)); % for Feng's eq.

IRF=(k1.*k3./(k2+k3))+((k1.*k2./(k2+k3)).*exp(-1.*(k2+k3).*Defined_Time));

Cp_gpu = gpuArray(single(Cp));
IRF_gpu= gpuArray(single(IRF));

Ct_temp = 0.01*conv2(Cp_gpu,IRF_gpu);

Ct_conv=Ct_temp(:,1:size(IRF,2));


for i=1:1:max(size(x))
    Time_inds(i)=find(round(Defined_Time,2)==round(x(i),2));
end


Ct=Ct_conv(:,Time_inds);

Ct=double(gather(Ct));







end