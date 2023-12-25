function y=test_fit(params, x)
slope=params(1);
intercept=params(2);

for i=1:1:size(x,1)
    y(i,1)=slope*x(i,1)+intercept;
end


end