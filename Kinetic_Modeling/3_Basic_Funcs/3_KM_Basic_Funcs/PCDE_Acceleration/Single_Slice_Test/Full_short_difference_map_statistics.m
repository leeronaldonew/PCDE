


diff=abs(k1_full(115,:,:)-k1_part(115,:,:));
mean(diff(:))

diff=abs(k2_full(115,:,:)-k2_part(115,:,:));
mean(diff(:))

diff=abs(k3_full(115,:,:)-k3_part(115,:,:));
mean(diff(:))

k1_full=Optim_Ks_full(115,:,:,1);
k1_part=Optim_Ks_part(115,:,:,1);
diff=abs(k1_full-k1_part);
mean(diff(:))


k2_full=Optim_Ks_full(115,:,:,2);
k2_part=Optim_Ks_part(115,:,:,2);
diff=abs(k2_full-k2_part);
mean(diff(:))

k3_full=Optim_Ks_full(115,:,:,3);
k3_part=Optim_Ks_part(115,:,:,3);
diff=abs(k3_full-k3_part);
mean(diff(:))


Ki_full=K_i_full(115,:,:);
Vd_full=V_d_full(115,:,:);
Ki_part=K_i_part(115,:,:);
Vd_part=V_d_part(115,:,:);
diff=abs(Ki_full-Ki_part);
mean(diff(:))
diff=abs(Vd_full-Vd_part);
mean(diff(:))


k1_full=squeeze(Optim_Ks_full(115,:,:,1));
k2_full=squeeze(Optim_Ks_full(115,:,:,2));
k3_full=squeeze(Optim_Ks_full(115,:,:,3));
k4_full=squeeze(Optim_Ks_full(115,:,:,4));
Ki_full=(k1_full.*k3_full)./(k2_full+k3_full);
Vd_full=(k1_full.*k2_full)./((k2_full+k3_full).^(2));

k1_part=squeeze(Optim_Ks_part(115,:,:,1));
k2_part=squeeze(Optim_Ks_part(115,:,:,2));
k3_part=squeeze(Optim_Ks_part(115,:,:,3));
k4_part=squeeze(Optim_Ks_part(115,:,:,4));
Ki_part=(k1_part.*k3_part)./(k2_part+k3_part);
Vd_part=(k1_part.*k2_part)./((k2_part+k3_part).^(2));

Ki_full(isnan(Ki_full))=0;
Ki_part(isnan(Ki_part))=0;
Vd_full(isnan(Vd_full))=0;
Vd_part(isnan(Vd_part))=0;

diff=abs(Ki_full-Ki_part);
mean(diff(:))
diff=abs(Vd_full-Vd_part);
mean(diff(:))

