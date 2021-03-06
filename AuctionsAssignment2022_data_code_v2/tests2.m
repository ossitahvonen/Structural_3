
load response_times_data.mat
t=10
% 
% iqr_data = iqr(responses.(1))
% h= 0.9*min(std(responses.(1)),iqr_data/1.34)*numel(responses.(1))^(-1/5);
% 
% inside_kernel = (responses.(1)-t)/h;
% 
% kissa = ksdensity(inside_kernel,'Bandwidth',h)*(P)/ksdensity(inside_kernel,'Bandwidth',h);




%vector to store values
respons1 = responses.(1);
respons2 = responses.(2);


%calculate silverman h
%like shown in https://en.wikipedia.org/wiki/Kernel_density_estimation#A_rule-of-thumb_bandwidth_estimator  
%interq range
iqr_data = iqr(respons1);
%silverman h
h= 0.9*min(std(respons1),iqr_data/1.34)*numel(respons1)^(-1/5);
% %what goes inside the kernel density function(?)
% inside_kernel = (respons1-t)/h;
%indicator element
p_ind = 0;
if (respons1-respons2 < 100) 
    p_ind = 1;
end
p_ind
h




values = [];

inside_kernel = (responses.(1)-t)/h;

phi = @(x) exp(-.5*(x-mean(inside_kernel)).^2)/(std(inside_kernel)*sqrt(2*pi));       % Normal Density


%kernel = @(x) phi((x-t)/h);

%%testi
k_dens = [];
for i=1:5000
    k_dens(i)=phi(inside_kernel(i))
end
kernel_nom = k_dens*p_ind;
kernel_denom = k_dens;


% 
% kpdf = @(x) arrayfun(kernel,x);
% 
% kernel_nom = kpdf(inside_kernel)*p_ind;
% kernel_denom = kpdf(inside_kernel);
% sum(kernel_denom,1)

%sum over the vectors
kernel_nom_sum = sum(kernel_nom,2);
kernel_denom_sum = sum(kernel_denom,2)
% divide the sums
out = kernel_nom_sum/kernel_denom_sum;
% 
% 
% 
% 
% 
% 
% 
% 
% % 
% % kernel_nom = mean(phi((respons1-t)/h)/h)*p_ind;
% % kernel_denom = mean(phi((respons1-t)/h)/h)*p_ind;
% 
% % % calculate the nominator and denominator without sums
% % kernel_nom = ksdensity(inside_kernel,'Bandwidth',h)*p_ind;
% % kernel_denom = ksdensity(inside_kernel,'Bandwidth',h);
% % %these should then be 5000x1 
% % % then sum over the rows