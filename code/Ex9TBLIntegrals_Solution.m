%% Turbulence: Ch9 External Wall-bounded Flows - Integral parameters
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
%
% Note: 
% Re_{\theta}   =       4061.378
% Re_{\delta^*} =       5633.318
% Re_{\tau}     =      1271.5350
% H_{12}        =       1.387046
% c_f           =    0.002970989

clear all;
close all;

% preview the data file format
opts = detectImportOptions('vel_4060_dns.prof','FileType','text','NumHeaderLines',14);
opts.SelectedVariableNames = [1 2 3]; % In this exercise we just need columns 1, 2 and 3
%preview('vel_4060_dns.prof',opts)

% load the data
[ynorm, yplus,Uplus] = readvars('vel_4060_dns.prof',opts);

%% a) Integrate the velocity profile to confirm that the normalised 
% displacement thickness is Re_{d^*} =  5633.318, that the normalised 
% momentum thickness is Re_{\theta} = 4061.378, and that H = 1.3871. For
% this data set cf = 0.002970989 which means utau/Uinfty = 0.0385.

utau = sqrt(0.002970989/2) % utau/Uinfty = sqrt(cf/2)

Re_dstar = -trapz((1/utau-Uplus),yplus) % normalised displacement thickness
Re_theta = -utau*trapz(Uplus.*(1/utau-Uplus),yplus) % normalised momentum thickness
H = Re_dstar/Re_theta % shape factor

%% b) Determine the normalised value of the Rotta-Clauser integral thickness 
% and the ratio of this value to the normalised boundayr layer thickness
% (Re_delta_99 = delta_99^+ *(Uinfty/utau))

Re_Delta = 1/utau * Re_dstar % normalised Rotta-Clauser integral thickness
Re_delta = yplus(213) /utau % normalise boundary layer thickness (delta_99)
I1 = Re_Delta/Re_delta % ratio
