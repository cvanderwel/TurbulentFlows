%% Turbulence: Exercise3 from Ch8 External Flows
% Last updated 04/08/2021 by C. Vanderwel
% This exercise is about exploring the properties of a turbulent boundary 
% layer formed over a rough wall. Data curtesy of Karen Flack from Flack, 
% Schultz, Barros, & Kim (2016). Int. J. Heat and Fluid Flow, 61:21-30.

clear all;
close all;

% Load the data
opts = detectImportOptions('RoughWallData.txt','FileType','text');
preview('RoughWallData.txt',opts)
[y,U,uv] = readvars('RoughWallData.txt',opts);

% convert y from mm to m
y = y /1000;

% Flow properties:
h = 12.61/1000; % channel half height (m)
Ucl = 3.222; % centreline velocity in the channel (m/s)
nu = 0.995 * 10^(-6); % kinematic viscosity of water (m^2/s)

%% a) Given the measurements of $U/U_{cl}$ versus $y/h$, assuming $u_\tau$ is unknown, 
% try to fit a log-law by adjusting the values of ut, d, and (A - DeltaUplus).

% plot the raw velocity profile to get an idea of what it looks like
plot(U/Ucl,y/h,'o') 
ylabel('y/h'); xlabel('U/U_{cl}')

% estimate the boundary layer thickness and roughness height and fit 
% the data only in the range of Y > 2H and Y < 0.25 delta
BL = h; % for a channel let's assume the log-law extends to the centre of the channel
H = 30*10^-6; % (m) sandgrit 320 has grains approx 30 um
indexlow = find(y > 2*H,1,'first')
indexup = find(y > 0.25*BL, 1, 'first')

% determine the best fit
loglawfit = fit(y(indexlow:indexup),U(indexlow:indexup),...
    'u_t/0.387*log((x-d).*u_t./(0.995 * 10^(-6))) + C*u_t',...
    'StartPoint',[5 0.1*H 0.155],...
    'Lower',[0 0 0],...
    'Upper',[10 1*H 10])

% This loglaw fit estimates:
utau_guess = loglawfit.u_t % utau (m/s)
d_guess = loglawfit.d; % the displacement height (m)
C_guess = loglawfit.C; % this part corresponds with A - Delta U +

% add the best fit line to the plot
figure(1); hold on;
plot(loglawfit(y(indexlow:indexup))/Ucl,(y(indexlow:indexup)/h),'b-');

% plot the data in plus-units
Uplus = U ./ utau_guess;
yplus = y .* utau_guess ./ nu;
figure(2); clf(2); figure(2);
plot(yplus,Uplus,'o');
hold on;
plot((y(indexlow:indexup)) .* utau_guess ./ nu, loglawfit(y(indexlow:indexup))./ utau_guess,'b-');
set(gca,'Xscale','log')
xlabel('y+')
ylabel('U+')

% Figure 2 shows that the log law fits the data well although the lower
% bound is a bit optimistic. When fitting three coefficients there is
% necessariliy some uncertainty. 

%% b) Plot the Reynolds stress and get a second estimate of U_tau from the 
% plateau of uv in the inertial (log) layer as -uv_plateau = U_tau^2.

% plot the raw velocity profile to get an idea of what it looks like
figure(3);
plot(uv,y/h,'o') 
ylabel('y/h'); xlabel('{uv} (m^2 / s^2)')

% from the plot, the peak value of uv is
uv_peak = -0.0226; %(m^2/s^2)
utau_guess2 = sqrt(-uv_peak)

%% c) In these experiments, the wall shear stress was measured directly 
% from the pressure drop in the channel and U_tau was found to be 0.155 m/s. 
% Replot the log law and compare the results with a smooth wall channel flow 
% (with kappa = 0.387, A = 4.5; ex 7.4) to determine DeltaU+.

utau = 0.155; % measured frictional velocity (m/s)

% determine the best fit
loglawfit2 = fit(y(indexlow:indexup),U(indexlow:indexup),...
    '0.155/0.387*log((x-d).*0.155./(0.995 * 10^(-6))) + C*0.155',...
    'StartPoint',[5 0.1*H],...
    'Lower',[0 0],...
    'Upper',[10 1*H])

% This loglaw fit estimates:
d_guess = loglawfit2.d; % the displacement height (mm)
C_guess = loglawfit2.C; % this part corresponds with A - Delta U +

% plot the data in plus-units
Uplus = U ./ utau;
yplus = y .* utau ./ nu;
figure(4); clf(4); figure(4);
plot(yplus,Uplus,'o');
hold on;
plot((y(indexlow:indexup)) .* utau ./ nu, loglawfit2(y(indexlow:indexup))./ utau,'b-');
set(gca,'Xscale','log')
xlabel('y+')
ylabel('U+')

% compare with smooth wall channel data 
hold on;
plot(30:400, 1/0.387*log(30:400) + 4.5,'r-');

% Estimate DeltaUplus as the downwards shift
DeltaUplus = C_guess - 4.5;



