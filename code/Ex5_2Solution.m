%% Turbulence: Ch5 Canonical flows - HSF data
% Last updated 30/04/2021 by C. Vanderwel
% 
% This exercise looks at the growth rate of TKE and the anistropy of the 
% normal stresses and in Homogeneous Shear Flow. 
% 
% The data is extracted from the paper by Tavoularis and Karnik (1989) 
% "Further experiments on the evolution of turbulent stresses and scales in
% uniformly sheared turbulence," J. Fluid Mech, 204:457?478.
%
% Data is available from https://torroja.dmt.upm.es/turbdata/agard/chapter3/HOM22/HOM22KT/
%
% This data is for case A, where Uc = 13 m/s, Shear = 84 s^-1.
% Tau is the non-dimensional downstream distance from the grid representing the total strain
% uu, vv, ww are the normal stresses (m^2/s^2)
% uv is the Reynolds stress (m^2/s^2)

clear all;
close all;

% preview the data file format
opts = detectImportOptions('HSFData.txt');
preview('HSFData.txt',opts)

% load the data
[tau,uu,vv,ww,uv] = readvars('HSFData.txt');

beta = 84; % shear rate (s^-1)

%% (a)	Calculate the turbulent kinetic energy. Plot it on semilog axes to see how it varies downstream. 
% Determine whether it grows or decays. 

k = 1/2*(uu+vv+ww);

% Plot the data on semilog axes 
figure; semilogy(tau,k,'o')
xlabel('\tau'); ylabel('k (m^2/s^2)')
grid on

%% (b) Determine the exponent of the exponential function that best describes the variation 
% (refering to equation (6.39) where here Tau replaces beta t)?

% Fit a power law
P4 = polyfit(tau(2:end),log(k(2:end)),1);
kf = exp(polyval(P4,tau));
hold on; semilogy(tau,kf, 'k-')

% The best fit shows that the power law exponent is:
P4(1)

% estimate the value of 'a' from (1/beta)(epsilon/k)(P_k/epsilon-1)
Pr = -uv .* 84; % Production = -uv * Beta
epsilon = Pr - beta*gradient(k,tau); % Dissipation = Pr - dk/dt
a = 1/beta * epsilon./k .* (Pr./epsilon-1)

%% (c)  Determine the anisotropy coefficients using equation (6.38).

% Plot all the rest of the data to visualise what it looks like
hold on;
semilogy(tau,uu,'v');
semilogy(tau,vv,'^')
semilogy(tau,ww,'s')
semilogy(tau,-uv,'x')
xlabel('t'); ylabel('u_i u_j (m^2/s^2)')
grid on

b11 = mean(uu./(2*k))-1/3
b22 = mean(vv./(2*k))-1/3
b33 = mean(ww./(2*k))-1/3
b12 = mean(uv./(2*k))
