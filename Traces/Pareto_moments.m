function F = Pareto_moments(p)
	alfa = p(1);
	m = p(2);
	
	F = [];
    if alfa<=2
        F(2) = Inf;
        if alfa<=1
            F(1) = Inf;
        else
            F(1) = alfa*m/(alfa-1);
        end
    else
        F(1) = alfa*m/(alfa-1);
        F(2) = alfa*(m^2)/(alfa-2);
    end
end