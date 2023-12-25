function resi_sq=Multiple_Fit(Params, x, y, num_data_points, num_fits)
%x= horzcat([1,2,3],[1,2,3], [1,2,3]);
%y= horzcat([1,2,3], [4,5,6], [7,8,9]);
%initial_params=[1,0,1,0,1,0];

%for i=1:1:3
%    resi_sq_1(i)=( (Params(1)*x(i)+Params(2))-y(i) )^(2);
%    resi_sq_2(i+3)=( (Params(3)*x(i+3)+Params(4))-y(i+3) )^(2);
%    resi_sq_3(i+6)=( (Params(5)*x(i+6)+Params(6))-y(i+6) )^(2);
%end

%resi_sq_sum= sum(resi_sq_1) + sum(resi_sq_2) + sum(resi_sq_3);

%end

% for lsqnonlin function
%options = optimoptions(@lsqnonlin,'Algorithm','levenberg-marquardt','UseParallel', true);
%params=lsqnonlin(@(Params) Multiple_Fit(Params, x,y, num_data_points, num_fits), initial_params,[],[], options);

%x=repmat([1:1:16], 1, 256);
%y=repmat([2:1:17], 1, 256);
%initial_params=repmat([1,0], 1, 256);

for i=1:1:(num_data_points*num_fits)
    p=2*ceil(i/num_data_points) - 1;
    resi_sq(i,1)=( (Params(p)*x(i)+Params(p+1))-y(i) )^(2);
end

end

% WB Test!
%for i=1:1:256*409
%params=lsqnonlin(@(Params) Multiple_Fit(Params, x,y, 16, 256), initial_params,[],[], options);
%end