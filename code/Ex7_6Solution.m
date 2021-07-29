%% Turbulence: Ch7 Internal Flows - Pipe Flow
% Last updated 28/05/2021 by C. Vanderwel
%
% This exercise is about exploring pipe flow.
%
% The experimental data is from Zagarola, M.V. and Smits, A.J., "Scaling of
% the Mean Velocity Profile for Turbulent Pipe Flow." Physical Review 
% Letters, Vol. 78, No. 1, pp.239-242, 1997. available at 
% http://www.princeton.edu/~gasdyn/Superpipe_data/1.0238E+06.txt
%
% The data file corresponds to the data set at Re = 1.0238E+06 and 
% contains the following information in columns:
%      ys/R
%      rs/R
%      udef
%      y+
%      u+  
%
% For the purposes of this exercise we can neglect the recommended Pitot 
% probe velocity gradient corrections as they result in only a difference
% of approximately 0.15% in the average velocity profiles.

clear all;
close all;

% preview the data file format
opts = detectImportOptions('PipeData.txt','FileType','text');
preview('PipeData.txt',opts)

% load the data
[ys,rs,udef,yplus,Uplus] = readvars('PipeData.txt',opts);


%% a) Plot the velocity profile Uplus vs. yplus in linear axes. 
% Zoom in to the near wall region and compare the profile with U+ = y+
% which we expect to see in the viscous sub-layer. Determine the location 
% of the closest measurement to the wall in physical units to get a sense 
% of the physical extent of the viscous sublayer?

figure;
plot(yplus,Uplus,'k.');
xlabel('y+')
ylabel('U+')

y1 = 0:10; % make another variable covering the viscous sublayer range
U1 = y1; % U+=y+ in the viscous sublayer
hold on; plot(y1,U1,'r-')

% What was the location of the closest measurement to the wall in physical units?
D = 1.2936E-01; % (m)
display(['The closest measurement to the wall was ' num2str(ys(1)*D/2*1000), ' mm.'])
% The closest measurement to the wall was approximately 0.5 mm. This means
% that the viscous sublayer is even smaller than this!!

%% b) Zoom out and adjust the axes to display this plot of Uplus vs. yplus in log-linear axes.
% Fit the log law eq (8.27) using Kappa = 0.41 and A = 5.2.

axis auto % zoom out to see all the data
set(gca,'XScale','log') % set the x-axis to be logarithmic

y2 = 600:10000; % make another variable covering the inertial sublayer range
U2 = 1/0.42 * log(y2) + 5.2; % U+=1/kappa ln(y+) + A in the log-law region
hold on; plot(y2,U2,'b-')

pause(1)
%% c) Adjust the axes to log-log scaling and consider whether a power law 
% of the form U+ = C(y+)^gamma provides a better fit to the data in the 
% near-wall overlap layer.

set(gca,'XScale','log','YScale','log') % set the x-axis to be logarithmic
axis([min(yplus) max(yplus) min(Uplus) max(Uplus)]) % zoom out to see all the data

y3 = 100:5000; % make another variable covering the overlap range
C = 9.9; % Guess and check to determine the coefficient that provides the best fit
gamma = 0.115; % Guess and check to determine the exponent that provides the best fit
hold on; plot(y3,C*y3.^gamma,'-')



