%% Turbulence: Exercise4_4 from Ch4 Statistical functions and tools
% Last updated 02/02/2022 by C. Vanderwel
% This exercise is about how to calculate the autocorrelation of a signal
% and to use that to estimate the Integral lengthscale and Taylor
% microscale.
%
% The example data set is obtained using hot-wire anemometry to measure the
% streamwise velocity in a wind tunnel sampled at 60 kHz for a total time 
% of 30 s. 

clear all;
close all;

% Load the data
U = readmatrix('TurbulenceSample.txt');

% Set up a time variable
acq_freq = 60000; %sampling frequency is 60kHz
dt = 1./acq_freq; %time interval between successive data points
t = 0:dt:(length(U)-1)*dt; %time of each sample

% We usually want to focus on the PDF of the velocity fluctuations
Um = mean(U); %calculate the mean of the signal
u = U-Um; %create a new signal that represents just the fluctuations

%% 1.	Calculate and plot the autocorrelation coefficient function for the streamwise velocity signal. 
[R,lags] = xcorr(u,u,'unbiased');
R = R./(std(u).*std(u)); % normalise the correlation by the variance
plot(lags.*dt,R);
xlabel('\tau (s)')
ylabel('R(\tau)')
grid on

% Note how the autocorrelation curve extends from -30s to +30s and is
% symmetrical. It also peaks at 1 at zero time lag.

xlim([0 1]) % Zoom in to see the relevant part of the curve. 

%% 2.	Compare with that from white an pink noise 
% (Note that the noise data samples are not the same length as the
% turbulence sample so we need a new time lags variable but will assume
% that the acquisition rate is the same.)

% Load the data
[W,P1,P2] = readvars('NoiseSample.txt');

% Determine the autocorrelation of the white noise
[RW,lags2] = xcorr(W,W,'unbiased');
RW = RW./(std(W).*std(W)); % normalise the correlation by the variance
hold on; plot(lags2.*dt,RW);

% Determine the autocorrelation of the white noise
[RP,lags2] = xcorr(P1,P1,'unbiased');
RP = RP./(std(P1).*std(P1)); % normalise the correlation by the variance
hold on; plot(lags2.*dt,RP);

xlim([0 0.1]) % Zoom in to see the relevant part of the curve. 
legend('turbulence','white noise','pink noise') % add a legend to the plot

%% 3.	Using the autocorrelation coefficient function, calculate the Integral length scale. 
% Integral timescale (try integrating from 0 to infinity)
integral_T = (trapz(lags.*dt, R)/2)
% This method gives a non-sensical negative result as it integrates all the
% noise at large time lags (which should be zero)!

% Integral timescale (try integrating from 0 to first zero crossing)
izero = (length(lags)-1)/2 + 1; % index of zero lag, R(izero)=1
icrossing = izero + find(R(izero:end)<0, 1, 'first') - 1; % index of the first zero crossing, R(icrossing)~0
int_range = izero:icrossing; % the integration range
integral_T = (trapz(lags(int_range).*dt, R(int_range))) % (UNITS = seconds)

% using Taylor's hypothesis (assuming turbulence intensity < 10%) we can
% convert this to a lengthscale (UNITS = metres):
integral_L = integral_T * Um


%% 4.	Calculate the Taylor microscale
% Estimate the second derivative at zero to obtain Taylor's microscale
d2Rdt2 = (R(izero+1) -2*R(izero) + R(izero-1))/(dt*dt);
taylorT = sqrt(-2.0/d2Rdt2) % (UNITS = seconds)

% using Taylor's hypothesis (assuming turbulence intensity < 10%) we can
% convert this to a lengthscale (UNITS = metres):
taylorL = taylorT * Um

