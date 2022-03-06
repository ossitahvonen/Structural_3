
load response_times_data.mat
t=10



inside_kernel = (responses.(1)-t)/h;
phi = @(x) exp(-.5*(x-mean(inside_kernel)).^2)/(std(inside_kernel)*sqrt(2*pi));       % Normal Density
k_dens = [];
for i=1:5000
    k_dens(i)=phi(inside_kernel(i));
end
kernel_nom = k_dens*p_ind;
kernel_denom = k_dens;
%sum over the vectors
kernel_nom_sum = sum(kernel_nom,2);
kernel_denom_sum = sum(kernel_denom,2)
% divide the sums
out = kernel_nom_sum/kernel_denom_sum;