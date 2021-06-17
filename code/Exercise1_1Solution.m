%% Turbulence: Exercise1 from Ch1 Overall Introduction
% Last updated 28/04/2021 by C. Vanderwel
% This exercise is about getting acquainted with a turbulence data signal. 
% We will look at hot-wire anemometry data of the streamwise velocity 
% measured in a wind tunnel sampled at 60 kHz for a total time of 30 s. 

clear all;
close all;

% Load the data
U = readmatrix('WindtunnelSample1.txt');

% Set up a time variable
acq_freq = 60000; %sampling frequency is 60kHz
dt = 1./acq_freq; %time interval between successive data points
t = 0:dt:(length(U)-1)*dt; %time of each sample

%% 1. Plot the velocity signal versus time.
plot(t,U) %plot the velocity time-series
xlabel('t (s)'); ylabel('U (m/s)')

%% 2. Calculate the mean of the signal.
Um = mean(U) %calculate the mean of the signal

%% 3. Create a new variable that represents the velocity fluctuation signal and equals the velocity signal minus the mean.
u = U-Um; %calculate the fluctuation of the signal

%% 4. Calculate the variance, skewness, and kurtosis of the velocity fluctuation signal.
variance_u = sum(u.^2)/length(u)
skewness_u = (sum(u.^3)/length(u)) / ((sum(u.^2)/length(u)).^(3/2))
kurtosis_u = (sum(u.^4)/length(u)) / ((sum(u.^2)/length(u)).^(2))

%% 5.Plot the probability density function of the fluctuation signal.
ax = [-6:.01:6]; %set up the bins for the pdf
ay = hist(u,ax); %calculate the histogram of u
ay = ay./trapz(ax,ay); %normalise so that the integral of the pdf is 1
figure; %open a new figure
plot(ax,ay,'b-'); %plot the pdf of u
xlabel('u (m/s)'); ylabel('p(u)')

