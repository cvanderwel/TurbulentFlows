%% Turbulence: Ch8 Internal Flows - Channel Flow
% Last updated 28/05/2021 by C. Vanderwel
% This exercise is about exploring channel flow.
% The DNS data is from S. Hoyas and J. Jimenez, (2006) "Scaling of velocity
% fluctuations in turbulent channels up to $Re_{\tau} =2000$", 
% Phys. of Fluids, vol 18, 011702. available at 
% https://torroja.dmt.upm.es/channels/data/statistics/Re2000/profiles/Re2000.prof
%
% In this exercise we will use:
% 2nd column of data = y+
% 3rd column of data = U+

clear all;
close all;

% preview the data file format
opts = detectImportOptions('Exercise8_5Data.txt','FileType','text');
opts.SelectedVariableNames = [2 3]; % In this exercise we just need column 2 and 3
preview('Exercise8_5Data.txt',opts)

% load the data
[yplus,Uplus] = readvars('Exercise8_5Data.txt',opts);


%% a) Plot the velocity profile Uplus vs. yplus in linear axes. 
% Zoom in to the near wall region and compare the profile with U+ = y+
% which we expect to see in the viscous sub-layer. To what value of $y+$ is
% this valid?

figure;
plot(yplus,Uplus,'k.');
xlabel('y+')
ylabel('U+')

y1 = 0:10; % make another variable covering the viscous sublayer range
U1 = y1; % U+=y+ in the viscous sublayer
hold on; plot(y1,U1,'r-')
axis([0 15 0 15])

%% b) Zoom out and adjust the axes to display this plot of Uplus vs. yplus in log-linear axes.
% Fit the log law eq (8.27) using Kappa = 0.387 and A = 4.5.

axis auto % zoom out to see all the data
set(gca,'XScale','log') % set the x-axis to be logarithmic

y2 = 50:1100; % make another variable covering the inertial sublayer range
U2 = 1/0.387 * log(y2) + 4.5; % U+=1/kappa ln(y+) + A in the log-law region
hold on; plot(y2,U2,'b-')

%% c) Plot the Karman measure \Pi vs. yplus. Confirm the approximate extent
% of the inertial sublayer and the value of Kappa.

dUdy = gradient(Uplus,yplus); % numerical derivative estimating d Uplus / d yplus
Pi = Uplus .* dUdy;

figure;
semilogx(yplus,Pi,'k.'); 
xlabel('y+')
ylabel('\Pi')

hold on; plot([1,2000], [2.58,2.58],'--')




