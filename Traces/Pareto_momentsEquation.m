function F = Pareto_momentsEquation(p)
	global M1
	global M2
	
	F = Pareto_moments(p);
	F(1) = F(1) / M1 - 1;
	F(2) = F(2) / M2 - 1;
end