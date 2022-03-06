load response_times_data.mat
t=10
%vector to store values
values = [];
resp1 = responses.(1);
resp2 = responses.(2);
%run the function
%specified below
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
    
    %p_ind = [];
    values = [];
    inside_kernel = (respons1-t1)/h;
    phi = @(x) exp(-.5*(x-mean(inside_kernel)).^2)/(std(inside_kernel)*sqrt(2*pi));       % Normal Density
    k_dens = [];
    p_ind = [];
    kernel_denom = [];
    kernel_nom = [];
    for i=1:5000
        %indicator element
        if (respons1(i)-respons2(i) < z) 
            p_ind(i) = 1;
        else
            p_ind(i) = 0;
        end
        %then calculate the kernel values for each responses vector element
        %& sum later
        kernel_denom(i)=phi(inside_kernel(i));
        kernel_nom(i)=phi(inside_kernel(i))*p_ind(i);
    end
    %sum over the vectors
    kernel_nom_sum = sum(kernel_nom,2);
    kernel_denom_sum = sum(kernel_denom,2);
    % divide the sums
    out = kernel_nom_sum/kernel_denom_sum;
end