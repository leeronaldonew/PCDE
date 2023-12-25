function [obj_val]=Object_1(params)

options = optimoptions('lsqcurvefit','Display', 'off');
global Local_Estimates

PI_Time=[0:1:120];

k1=params(1); k2=params(2); k3=params(3); k4=params(4);
k_loss= (k2*k4) / (k2+k3);

Func_TTCM=@(tau) TTCM_analytic_Multi(params,tau);
Ct_True=TTCM_analytic_Multi(params,PI_Time); % with Exp_4
Func_Exp_4=@(tau) Exp_4(Local_Estimates,tau); % for Exp_4

Func_Exp_4_Multiplied = @(tau) Exp_4_Multiplied_Exp_Loss([Local_Estimates;k_loss], tau);
Cp=Exp_4(Local_Estimates,PI_Time); % for Exp_4

% Generalized Patlak
for p=1:1:size(PI_Time,2)
    X_Patlak(p)= (exp(-1*k_loss*PI_Time(p))*integral(Func_Exp_4_Multiplied, 0, PI_Time(p), 'ArrayValued',true)) / Cp(p);
    Y_Patlak(p)= Ct_True(p) / Cp(p);
end
% Logan
for p=1:1:size(PI_Time,2)
    if p==1
        X_Logan(p)=0;
        Y_Logan(p)=0;
    else
        X_Logan(p)=integral(Func_Exp_4, 0, PI_Time(p), 'ArrayValued',true) / Ct_True(p); % for Exp_4
        Y_Logan(p)= (trapz(PI_Time(1:p),Ct_True(1:p))) / Ct_True(p);
    end
end
% Ito
%for p=1:1:size(PI_Time,2)
%    X_Ito(p)=integral(Func_TTCM,0,PI_Time(p),'ArrayValued', true) / integral(Func_Exp_4, 0, PI_Time(p), 'ArrayValued',true) ; % for Exp_4
%    Y_Ito(p)=Ct_True(p) / integral(Func_Exp_4, 0, PI_Time(p), 'ArrayValued',true);
%end


% Patlak
X_Patlak=X_Patlak(2:end);
Y_Patlak=Y_Patlak(2:end);
p_Patlak = polyfit(X_Patlak,Y_Patlak,1);
Ki=p_Patlak(1);
Vd=p_Patlak(2);

% Logan
X_Logan=X_Logan(2:end);
Y_Logan=Y_Logan(2:end);
p_Logan= polyfit(X_Logan, Y_Logan,1);
Vt=p_Logan(1);
Int=p_Logan(2);




% Synthesis of Ct (Early artificial data + Measured data)
%Ct_temp=TTCM_analytic_Multi(params,[10:10:120]);
%Ct_temp_noisy=Ct_temp + Ct_temp.*0.1.*randn(1,12);
%Ct_Noisy=Ct_temp_noisy;
global Ct_Noisy
global PI_Time_Noisy;
Ct_art=[Ct_True(1:10),Ct_Noisy];
Time_art=[0:1:9,PI_Time_Noisy];


% Pre-setting
Func_Exp_4_Multiplied = @(tau) Exp_4_Multiplied_Exp_Loss([Local_Estimates;k_loss], tau);
Cp=Exp_4(Local_Estimates,Time_art); % for Exp_4

% Patlak (using the artificial data)
for p=1:1:size(Time_art,2)
    X_Patlak_art(p)= (exp(-1*k_loss*Time_art(p))*integral(Func_Exp_4_Multiplied, 0, Time_art(p), 'ArrayValued',true)) / Cp(p);
    Y_Patlak_art(p)= Ct_art(p) / Cp(p);
end
% Logan (using the artificial data)
for p=1:1:size(Time_art,2)
    if p==1
        X_Logan_art(p)=0;
        Y_Logan_art(p)=0;
    else
        X_Logan_art(p)= integral(Func_Exp_4, 0, Time_art(p), 'ArrayValued',true) / Ct_art(p); % for Exp_4
        Y_Logan_art(p)= (trapz(Time_art(1:p),Ct_art(1:p))) / Ct_art(p);
    end  
end

% Ito (using the artificial data)
%for p=1:1:size(Time_art,2)
%    X_Ito_art(p)=integral(Func_TTCM,0,Time_art(p),'ArrayValued', true) / integral(Func_Exp_4, 0, Time_art(p), 'ArrayValued',true); % for Exp_4
%    Y_Ito_art(p)=Ct_art(p) / integral(Func_Exp_4, 0, Time_art(p), 'ArrayValued',true);
%end


% Patlak
X_Patlak_art=X_Patlak_art(2:end);
Y_Patlak_art=Y_Patlak_art(2:end);
p_Patlak_art = polyfit(X_Patlak_art,Y_Patlak_art,1);
Ki_art=p_Patlak_art(1);
Vd_art=p_Patlak_art(2);

% Logan
X_Logan_art=X_Logan_art(2:end);
Y_Logan_art=Y_Logan_art(2:end);
p_Logan_art= polyfit(X_Logan_art, Y_Logan_art,1);
Vt_art=p_Logan_art(1);
Int_art=p_Logan_art(2);


% Two_Phase_Lin (for Logan plot)
Starting=[0,0,0,0];
LB=[0,-100000,0,-100000];
UB=[100000,100000,100000,100000];
[Estimates_Logan,SSE,Residual,d,e,f,Jacobian]=lsqcurvefit(@Two_phase_Lin, Starting, X_Logan, Y_Logan, LB, UB,options);
[Estimates_Logan_art,SSE,Residual,d,e,f,Jacobian]=lsqcurvefit(@Two_phase_Lin, Starting, X_Logan_art, Y_Logan_art, LB, UB,options);
%Fitted=[transpose([0:0.1:10]), transpose(Two_phase_Lin(Estimates,[0:0.1:10]))];

% Two_Phase_Lin (for Ito plot)
%Starting=[0,0,0,0];
%LB=[-1000000,-1000000,-1000000,-1000000];
%UB=[1000000,1000000,1000000,1000000];
%[Estimates_Ito,SSE,Residual,d,e,f,Jacobian]=lsqcurvefit(@Two_phase_Lin_Ito, Starting, X_Ito, Y_Ito, LB, UB,options);
%[Estimates_Ito_art,SSE,Residual,d,e,f,Jacobian]=lsqcurvefit(@Two_phase_Lin_Ito, Starting, X_Ito_art, Y_Ito_art, LB, UB,options);


Ct_True=TTCM_analytic_Multi(params,Time_art);


%obj_val=  (   sum((Ct_True-Ct_art).^(2)) + ((Ki-Ki_art)^2) + ((Vd-Vd_art)^2) + ((Vt-Vt_art)^2) + ((Int-Int_art)^2)  )^(0.5);

%obj_val= (    sum((Ct_True-Ct_art).^(2)) +  ((Ki-Ki_art)^2) + ((Vd-Vd_art)^2) + sum((Estimates_Logan(1:3)-Estimates_Logan_art(1:3)).^(2))       )^(0.5);

%obj_val= (    sum((Ct_True-Ct_art).^(2)) +  ((Ki-Ki_art)^2)  + sum((Estimates_Logan(1:3)-Estimates_Logan_art(1:3)).^(2))       )^(0.5);

obj_val= (    sum((Ct_True-Ct_art).^(2)) +  ((Ki-Ki_art)^2) +  ((Vd-Vd_art)^2) + sum((Estimates_Logan(1:4)-Estimates_Logan_art(1:4)).^(2))       )^(0.5);

%obj_val= (    sum((Ct_True-Ct_art).^(2)) +  ((Ki-Ki_art)^2)  + sum((Estimates_Logan(1:3)-Estimates_Logan_art(1:3)).^(2))       )^(0.5);


%obj_val=  (   ((Ki-Ki_art)^2) + ((Vd-Vd_art)^2) + ((Vt-Vt_art)^2) + ((Int-Int_art)^2)  )^(0.5);

%obj_val=  (  sum((Ct_True-Ct_art).^(2)) + ((Ki-Ki_art)^2) + ((Vd-Vd_art)^2) + ((Vt-Vt_art)^2) )^(0.5);

%obj_val= (  sum((Ct_True-Ct_art).^(2)) + sum((X_Logan-X_Logan_art).^(2)) + sum((Y_Logan-Y_Logan_art).^(2)) +  ((Ki-Ki_art)^2) + ((Vd-Vd_art)^2)  )^(0.5);

end



