
%kernel is done by 
%exp(-((x_val-i).^2)/2*sig.^2)


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
resp1 = responses.(1);
resp2 = responses.(2);
values = []
for i=1:400
    k = kernel_try1(i,t, resp1, resp2);
    values(end+1) = k(:,1);
    
end

function [out,z] = kernel_try1(z,t1, respons1, respons2)
    %iqr for silverman
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

    %calculate the nominator and denominator without sums
    kernel_nom = ksdensity(inside_kernel,'Bandwidth',h)*p_ind;
    kernel_denom = ksdensity(inside_kernel,'Bandwidth',h);
    %these should then be 5000x1 s
    %then sum over the rows
    kernel_nom_sum = sum(kernel_nom,2);
    kernel_denom_sum = sum(kernel_nom,2);
    out = kernel_nom_sum/kernel_denom_sum
    %the whole kernel
    %ksdensity(inside_kernel,'Bandwidth',h)*p_ind/ksdensity(inside_kernel,'Bandwidth',h);
end






%rho is responses.(2)
%tau is responses.(1)

%Silverman:
%iqr 

% 
% h = std(data)*(4/3/numel(data))^(1/5);
% 
% 
% 
% % True
% phi = @(x) exp(-.5*x.^2)/sqrt(2*pi);       % Normal Density
% % Kernel
% h = std(data)*(4/3/numel(data))^(1/5);     % Bandwidth estimated by Silverman's Rule of Thumb
%kernel = @(x) mean(phi((x-data)/h)/h);     % Kernel Density
% kpdf = @(x) arrayfun(kernel,x);            % Elementwise application
% % Plot
% figure(2), clf, hold on
% x = linspace(-25,+25,1000);                % Linear Space
% plot(x,tpdf(x))                            % Plot True Density
% plot(x,kpdf(x))                            % Plot Kernel Density with Silverman's Rule of Thumb
% kde(data)                                  % Plot Kernel Density with Solve-the-Equation Bandwidth