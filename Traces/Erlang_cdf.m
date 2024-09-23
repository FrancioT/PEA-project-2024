function F = Erlang_cdf(x, p)
	lambda = p(1);
	k = p(2);
	
    F = zeros(size(x));
    for index = 0:k-1
        F = F + min(1, max(0, (1/factorial(index))*exp(-lambda*x).*((lambda*x).^index)));
    end
    F = (x>0) .* (1-F);
end
