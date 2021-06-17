%% Turbulence: Ch6 Canonical flows - HSF data
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
opts = detectImportOptions('Exercise6_2Data.txt');
preview('Exercise6_2Data.txt',opts)

% load the data
[Tau,uu,vv,ww,uv] = readvars('Exercise6_2Data.txt');


%% (a)	Calculate the turbulent kinetic energy. Plot it on semilog axes to see how it varies downstream. 
% Determine whether it grows or decays. 

k = 1/2*(uu+vv+ww);

% Plot the data on semilog axes 
figure; semilogy(Tau,k,'o')
xlabel('Tau'); ylabel('k (m^2/s^2)')
grid on

%% (b) Determine the exponent of the exponential function that best describes the variation 
% (refering to equation (6.39) where here Tau replaces beta t)?

% Fit a power law
P4 = polyfit(Tau(2:end),log(k(2:end)),1);
Tf = 7:27;
kf = exp(polyval(P4,Tf));
hold on; semilogy(Tf,kf, 'k-')

% The best fit shows that the power law exponent is:
P4(1)

%% (c)  Determine the anisotropy coefficients using equation (6.38).

% Plot all the rest of the data to visualise what it looks like
hold on;
semilogy(Tau,uu,'v');
semilogy(Tau,vv,'^')
semilogy(Tau,ww,'s')
semilogy(Tau,-uv,'x')
xlabel('Tau'); ylabel('u_i u_j (m^2/s^2)')
grid on

b11 = mean(uu./(2*k))-1/3
b22 = mean(vv./(2*k))-1/3
b33 = mean(ww./(2*k))-1/3
b12 = mean(uv./(2*k))
