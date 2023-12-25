function [sort_ind]=Selector_Overall_Slope(selected_comb,Noisy,PI_Time)


%% using overall slope
%global Local_Estimates
%Local_Estimates=[17.86;0.00841;-3423.59;1.23;3348.58;1.13929;17.67;0.06774]; % Params for FDG with Exp_4 generated from Feng's graph for FDG
%PI_Time=[10:10:90];
PI_Time_database=[10:1:90];
%selected_comb=[0.86,0.98,0.01,0;0.42,0.48,0.01,0;0.41,0.47,0.01,0;0.43,0.49,0.01,0];
selected_Ct=TTCM_analytic_Multi(selected_comb,PI_Time_database);
%Noisy=[28.10206,20.05989,23.06002,22.74449,20.38858,18.74983,18.30985,19.35043,23.65045];

for i=1:1:(size(PI_Time_database,2)-1)
    slope_long(:,i)=(selected_Ct(:,size(PI_Time_database,2)-(i-1))-selected_Ct(:,1)) ./ (PI_Time_database(size(PI_Time_database,2)-(i-1))-PI_Time_database(1)) ;
end

for i=1:1:(size(PI_Time,2)-1)
    slope_long_Noisy(:,i)= (Noisy(:,size(PI_Time,2)-(i-1))-Noisy(:,1)) ./ (PI_Time(size(PI_Time,2)-(i-1))-PI_Time(1)) ;
end

for i=1:1:(size(PI_Time,2)-1)
    ind=find(PI_Time_database==PI_Time(i));
    slope_long_PI_Time(:,i)=slope_long(:,ind);
end


diff_slope_long=abs(slope_long_PI_Time-repmat(slope_long_Noisy,size(selected_comb,1),1)); 

%[sort_val,sort_ind]=sort(sum(diff_slope_long,2));

%[sort_val,sort_ind]=sort(diff_slope_long(:,1)+diff_slope_long(:,end));

diff_slope_long_first=diff_slope_long(:,1);
[sort_val,sort_ind]=sort(diff_slope_long_first);

%min=sort_ind(1);


%comb=selected_comb(min_ind,:);