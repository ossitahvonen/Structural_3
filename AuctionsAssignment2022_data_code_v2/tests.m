
%kernel is done by 
%exp(-((x_val-i).^2)/2*sig.^2)


load response_times_data.mat
t=10

inside_kernel = (responses.(1)-t)/
kissa = ksdensity(,'Bandwidth',0.05);

%rho is responses.(2)
%tau is responses.(1)

%Silverman:
%iqr 
iqr_data = iqr(responses.(1))
h = std(data)*(4/3/numel(data))^(1/5);



% True
phi = @(x) exp(-.5*x.^2)/sqrt(2*pi);       % Normal Density
% Kernel
h = std(data)*(4/3/numel(data))^(1/5);     % Bandwidth estimated by Silverman's Rule of Thumb
kernel = @(x) mean(phi((x-data)/h)/h);     % Kernel Density
kpdf = @(x) arrayfun(kernel,x);            % Elementwise application
% Plot
figure(2), clf, hold on
x = linspace(-25,+25,1000);                % Linear Space
plot(x,tpdf(x))                            % Plot True Density
plot(x,kpdf(x))                            % Plot Kernel Density with Silverman's Rule of Thumb
kde(data)                                  % Plot Kernel Density with Solve-the-Equation Bandwidth