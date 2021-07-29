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

%% a) Plot the velocity signal versus time.
plot(t,U) %plot the velocity time-series
xlabel('t (s)'); ylabel('U (m/s)')

%% b) Calculate the mean of the signal.
Um = mean(U) %calculate the mean of the signal
