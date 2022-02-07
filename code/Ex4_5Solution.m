%% Turbulence: Exercise4_5 from Ch4 Statistical functions and tools
% Last updated 02/02/2022 by C. Vanderwel
% This exercise is about investigating the correlation between the U and V 
% components of a shear flow by examining the joint PDF 

clear all;
close all;

% load the data
[t,U,V,W] = readvars('TurbulenceSample2.txt');

%% (a) Joint PDF 
Um = mean(U); % calculate the mean of the signal
u = U-Um; % create a new signal that represents just the fluctuations
urms = std(u); % calculate the standard deviation of the fluctuations

Vm = mean(V); % calculate the mean of the signal
v = V-Vm; % create a new signal that represents just the fluctuations
vrms = std(v); % calculate the standard deviation of the fluctuations

% Plot a scatter plot
figure; %open a new figure
scatter(u/urms, v/vrms,'r.')
xlabel('u/u_{rms}');ylabel('v/v_{rms}')
title('Joint PDF')
axis equal
grid on 

% Determine the joint PDF (a 2D array)
[n,c] = hist3([u/urms, v/vrms],[10,11]); % adjust the bins as desired
jpdf = n ./ (trapz(c{2},trapz(c{1},n,1))); % normalise the counts so it integrates to 1

% add contour lines of the JPDF
hold on;
contour(c{2}, c{1}, jpdf)

% Add a line of best fit of data
coefficients = polyfit(u/urms, v/vrms, 1)
XFit = linspace(min(u/urms), max(u/urms), 1000);
YFit = polyval(coefficients, XFit);
hold on; 
plot(XFit, YFit, 'b-', 'Linewidth', 2)

% Note: The plot is scattered and not fully converged due to limimted data. 
% Nonetheless, it looks like a negative correlation: the slope of -0.4307 
% should equal the correlation coefficient between u and v.

%% (b) Calculate the Reynolds shear stress

% (i) Calculate the Reynolds stress by integrating the joint PDF
[m2,m1]=meshgrid(c{2},c{1});
R12 = trapz(c{2},trapz(c{1},jpdf.*m1.*m2,1));
R12 = R12 .* urms .*vrms

% (ii) Calculate the Reynolds stress by averaging u .* v (ie. covariance)
uv_bar = sum(u.*v) ./ length(u)

% results are close but not perfectly equal because the jpdf is not
% perfectly converged with this limited data set
