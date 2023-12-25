function C_p=Surge(params, x) % for using "lsqcurvefit" or 'nlinfit'function
%% Parameters for the surge function
A=params(1); 
P=params(2);
b=params(3);


%% Defining X-data (Time [min])
t=x; % PI Time

%% Function type (Feng's Model #2)
%for i=1:1:size(t,2) % (Column type for YData)
%    if t(i) < tau
%        C_p(i,1)=0;
%    else
%        C_p(i,1)= ((A_1*(t(i)-tau)-A_2-A_3)*exp(Lamda_1.*(t(i)-tau)))  +  (A_2*exp(Lamda_2*(t(i)-tau)))  +  (A_3*exp(Lamda_3*(t(i)-tau)));
%    end
%end

% for testing (Raw type for YData)
%for i=1:1:size(t,2)
%    if t(i) < tau
%        C_p(1,i)=0;
%    else
%        C_p(1,i)= ((A_1*(t(i)-tau)-A_2-A_3)*exp(Lamda_1.*(t(i)-tau)))  +  (A_2*exp(Lamda_2*(t(i)-tau)))  +  (A_3*exp(Lamda_3*(t(i)-tau)));
%    end
%end

% Function Type for using the "nlinfit" function ==> Xdata & Parameters & Ouput : Column data!
%C_p=zeros(size(x,1),1);
for i=1:1:size(t,1) % (Column type for YData)
    C_p(i,1)= A*(t(i,1)^(P))*exp(-1*b*t(i,1));
end

end