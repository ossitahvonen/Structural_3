
load response_times_data.mat
t=10

%interq range
iqr_data = iqr(respons1);
%silverman h
h= 0.9*min(std(respons1),iqr_data/1.34)*numel(respons1)^(-1/5);
%what goes inside the kernel density function(?)
inside_kernel = (responses.(1)-t)/h;


exp(-.5*(x-mean(inside_kernel)).^2)/(std(inside_kernel)*sqrt(2*pi));       % Normal Density
