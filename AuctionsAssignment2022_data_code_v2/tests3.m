
%kernel is done by 
%exp(-((x_val-i).^2)/2*sig.^2)


load response_times_data.mat
t=10

%vector to store values
values = []

resp1 = responses.(1);
resp2 = responses.(2);

for i=1:400
    k = kernel_try1(i,t, resp1, resp2);
    values(end+1) = k(:,1);
end

function [out,z] = kernel_try1(z,t1, respons1, respons2)
    
    %calculate silverman h
    %like shown in https://en.wikipedia.org/wiki/Kernel_density_estimation#A_rule-of-thumb_bandwidth_estimator  
    %interq range
    iqr_data = iqr(respons1);
    %silverman h
    h= 0.9*min(std(respons1),iqr_data/1.34)*numel(respons1)^(-1/5);
    %what goes inside the kernel density function(?)
    inside_kernel = (respons1-t1)/h;
    %indicator element
    p_ind = 0;
    if (respons1-respons2 < z) 
        p_ind = 1;
    end
    values = [];
    inside_kernel = (respons1-t1)/h;
    phi = @(x) exp(-.5*(x-mean(inside_kernel)).^2)/(std(inside_kernel)*sqrt(2*pi));       % Normal Density
    kernel = @(x) phi((x-t1)/h)/h;
    kpdf = @(x) arrayfun(kernel,x);
    
    kernel_nom = kpdf(inside_kernel)*p_ind;
    kernel_denom = kpdf(inside_kernel);
    sum(kernel_denom,1)
    
    %sum over the vectors
    kernel_nom_sum = sum(kernel_nom,1);
    kernel_denom_sum = sum(kernel_nom,1);
    % divide the sums
    out = kernel_nom_sum/kernel_denom_sum
end

