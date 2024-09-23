function F = Weibull_cdf(x, p)
	lambda = p(1);
	k = p(2);
	
    F = (x>0) .* (1-exp(-(x/lambda).^k));
end
