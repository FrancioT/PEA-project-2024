function F = Weibull_moments(p)
	lambda = p(1);
	k = p(2);
	
	F = [];
	F(1) = lambda*gamma(1+1/k);
	F(2) = (lambda^2)*gamma(1+2/k);
end