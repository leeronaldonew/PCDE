function C_p=Feng(params, x) % for using "lsqcurvefit" or 'nlinfit'function
%% Parameters for the Feng's model #2: [Tau, A_1, A_2, A_3, Lamda_1, Lamda_2, Lamda_3] ==> 7 parameters
tau=params(1); 
A_1=params(2);
A_2=params(3);
A_3=params(4);
Lamda_1=params(5);
Lamda_2=params(6);
Lamda_3=params(7);

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
for i=1:1:size(t,2) % (Column type for YData)
    if t(i) < tau
        C_p(i,1)=0;
    else
        C_p(i,1)= ((A_1*(t(i)-tau)-A_2-A_3)*exp(-1*Lamda_1*(t(i)-tau)))  +  (A_2*exp(-1*Lamda_2*(t(i)-tau)))  +  (A_3*exp(-1*Lamda_3*(t(i)-tau)));
    end
end

end
