clear all;
close all;
clc;
format long;

fID = fopen("TraceA-IV.txt", 'r');
Tr = fscanf(fID, "%f\n",[1 Inf]);
Tr = Tr';

Dim = size(Tr, 1);
FirstMoment = mean(Tr)
SecondMoment = sum(Tr.^2)/Dim
ThirdMoment = sum(Tr.^3)/Dim
cv = std(Tr)/FirstMoment;
X_axes = (0:(floor(max(Tr))+1)*10)/10;
plot(sort(Tr), (1:Dim)/Dim, ".", 'DisplayName', 'Empirical');
title("CDF comparison");
hold on;


% Uniform
a = FirstMoment - sqrt(12*(SecondMoment - FirstMoment^2))/2;
b = FirstMoment + sqrt(12*(SecondMoment - FirstMoment^2))/2;
plot(X_axes, Unif_cdf(X_axes, [a,b]), "Red", 'DisplayName', 'Uniform');

% Exponential
lambdaExp = 1/FirstMoment;
plot(X_axes, Exp_cdf(X_axes, lambdaExp), "Green", 'DisplayName', 'Exponential');

% Erlang, deve avere cv <= 1
% cv = 1/(k^(1/2))
k = round((FirstMoment^2)/(SecondMoment-FirstMoment^2));
lambdaErl = k/FirstMoment;
plot(X_axes, Erlang_cdf(X_axes, [lambdaErl,k]), "Black", 'DisplayName', 'Erlang');
%plot(X_axes, cdf("Gamma", X_axes, k, 1/lambdaErl), "Yellow");

global M1
global M2
M1 = FirstMoment;
M2 = SecondMoment;

% Weibull
ParametersWeibull = fsolve(@(params)Weibull_momentsEquation(params), [1, 1]);
%plot(X_axes, cdf("Weibull", X_axes, ParametersWeibull(1), ParametersWeibull(2)), "Yellow");
plot(X_axes, Weibull_cdf(X_axes, [ParametersWeibull(1), ParametersWeibull(2)]), "Cyan", 'DisplayName', 'Weibull');

% Pareto
ParametersPareto = fsolve(@(params)Pareto_momentsEquation(params), [10, 10]);
plot(X_axes, Pareto_cdf(X_axes, [ParametersPareto(1), ParametersPareto(2)]), "Magenta", 'DisplayName', 'Pareto');

% Hyper exponential, deve avere cv >= 1
ParametersHyperExp = mle(Tr, "pdf", @(x, lambda1, lambda2, prob)HyperExp_pdf(x, [lambda1, lambda2, prob]), "Start", [0.8/FirstMoment, 1.2/FirstMoment, 0.4]);
%plot(X_axes, HyperExp_cdf(X_axes, ParametersHyperExp), "Yellow", 'DisplayName', 'HyperExp');

% Hypo exponential, deve avere cv < 1
% cv = ((lambda1^2 + lambda2^2)^(1/2)) / (lambda1+lambda2)
ParametersHypoExp = mle(Tr, "pdf", @(x, lambda1, lambda2)HypoExp_pdf(x, [lambda1, lambda2]), "Start", [1/(0.3*FirstMoment), 1/(0.7*FirstMoment)]);
plot(X_axes, HypoExp_cdf(X_axes, ParametersHypoExp), 'DisplayName', 'HypoExp');

legend;


figure;
plot(sort(Tr), (1:Dim)/Dim, ".", 'DisplayName', 'Empirical', 'Color', [0 1 0]);
title("CDF comparison");
hold on;
plot(X_axes, Erlang_cdf(X_axes, [lambdaErl,k]), "-", 'DisplayName', 'Erlang', 'Color', [0 0 0]);

legend;