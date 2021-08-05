%% Turbulence: Ch5 Canonical flows - HIT data
% Last updated 05/08/2021 by C. Vanderwel
% 
% This exercise looks at the proerties of decaying homogeneous isotropic turbulence 
% 
% The data was created by A.A.Wray (1997)
%
% Data is available from https://torroja.dmt.upm.es/turbdata/agard/chapter3/HOM02/CB512.f_t

clear all;
close all;

% preview the data file format
opts = detectImportOptions('HITData.txt');
preview('HITData.txt',opts)

% load the data
[t,k,Enstrophy,L,Sk] = readvars('HITData.txt');

viscosity = 3.5014006E-04;

%% (a)	Plot the Energy vs time and determine the exponent of the best power law fit.

% Plot the data on log-log axes 
figure; plot(t,k,'o')
set(gca,'XScale','log','YScale','log')
xlabel('t'); ylabel('k')
grid on

% Fit a power law
range = [160:242];
P = polyfit(log10(t(range)),log10(k(range)),1);
kf = 10.^(polyval(P,log10(t(range))));
hold on; plot(t(range),kf, 'k-')

% The best fit shows that the power law exponent is:
P(1)

%% (b)  Determine the rate of turbulent kinetic energy dissipation as 
% (i) epsilon = dk/dt and as (ii) viscosity * enstrophy

% (i) In HIT, epsilon = dk/dt
epsilon = -gradient(k,t);
figure; plot(t,epsilon,'o')
set(gca,'XScale','log','YScale','log')
xlabel('t'); ylabel('\epsilon')
grid on

% (ii) In HIT, epsilon can also be estimated as viscosity * enstrophy
hold on; plot(t,viscosity*Enstrophy,'x')

%% (c) Plot the development of the integral lengthscale scale in time.

% Plot the data on log-log axes 
figure; plot(t,L,'o')
set(gca,'XScale','log','YScale','log')
xlabel('t'); ylabel('L')
grid on

% Fit a power law
range = [160:242];
PL = polyfit(log10(t(range)),log10(L(range)),1);
Lf = 10.^(polyval(PL,log10(t(range))));
hold on; plot(t(range),Lf, 'k-')

% The best fit shows that the power law exponent is:
PL(1)

%% (d) Explore the validity of the equilibrium dissipation law (eq 5.26) and estimate C_epsilon

% Plot the data on log-log axes 
figure; plot(t,epsilon .* k.^(-3/2) .* L,'o')
set(gca,'XScale','log','YScale','linear')
xlabel('t'); ylabel('C_\epsilon')
grid on

