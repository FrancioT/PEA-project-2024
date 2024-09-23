function F = Pareto_cdf(x, p)
	alfa = p(1);
	m = p(2);
	
    F = max(0, (x>=m) .* (1 - (m./x).^alfa));
end