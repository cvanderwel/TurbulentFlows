%% Turbulence: Ch8 External Wall-bounded Flows - Smooth-wall TBL 
% Last updated 14/06/2021 by C. Vanderwel
% This exercise is about exploring a smooth-wall turbulent boundarr layer
% The DNS data is from Schlatter and Orlu, 2010, J. Fluid Mech., 659, 116-126 
% available at 
% https://www.mech.kth.se/~pschlatt/DATA/vel_4060_dns.prof
%
% In this exercise we will use:
% 1st column of data = y/delta
% 2nd column of data = y+
% 3rd column of data = U+

clear all;
close all;

% preview the data file format
opts = detectImportOptions('TBLData.txt','FileType','text','NumHeaderLines',14);
opts.SelectedVariableNames = [1 2 3]; % In this exercise we just need columns 1, 2 and 3
%preview('vel_4060_dns.prof',opts)

% load the data
[ynorm, yplus,Uplus] = readvars('TBLData.txt',opts);


%% a) Plot the velocity profile Uplus vs. yplus in linear axes. 
% Zoom in to the near wall region and compare the profile with U+ = y+
% which we expect to see in the viscous sub-layer. To what value of y+ is 
% this valid? What percentage of the boundary layer depth (in terms of $\delta$) does this region cover?


figure;
plot(yplus,Uplus,'k.');
xlabel('y+')
ylabel('U+')

y1 = 0:10; % make another variable covering the viscous sublayer range
U1 = y1; % U+=y+ in the viscous sublayer
hold on; plot(y1,U1,'r-')
axis([0 15 0 15])

% from the plot it looks like this is a good fit until about y+-5 (index 14)
display(['limit of viscous regions is about ' num2str(ynorm(14)*100) '% of delta'])

%% b) Zoom out and adjust the axes to display this plot of Uplus vs. yplus in log-linear axes.
% Fit the log law eq (9.22) using Kappa = 0.384 and A = 4.173.

axis auto % zoom out to see all the data
set(gca,'XScale','log') % set the x-axis to be logarithmic

y2 = 40:800; % make another variable covering the inertial sublayer range in inner units
U2 = 1/0.384 * log(y2) + 4.173; % U+=1/kappa ln(y+) + A in the log-law region
hold on; plot(y2,U2,'b-')


%% c) Plot the velocity profile against outer units (ie. U+ vs. y/delta) 
% Plot the log-law with the wake function (9.27). Note how this fits well 
% in the outer region (and clearly doesn't apply beyond y/delta=1).

figure;
plot(ynorm,Uplus,'k.');
xlabel('y/\delta')
ylabel('U+')

% Calculate the predicted velocity profile (Ulog+Uwake) spanning the whole data range 
Ulog = 1/0.384 * log(yplus) + 4.173; % note y is in inner units
Uwake = 0.55/0.384 * 2 * (sin(pi/2*ynorm)).^2; % note y is in outer units

hold on; plot(ynorm,Ulog,'b--') % plot just the loglaw part
hold on; plot(ynorm,Uwake,'m:') % plot just the wake part
hold on; plot(ynorm,Ulog+Uwake,'r--') % plot the full equation


