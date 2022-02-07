%% Turbulence: Exercise4_3 from Ch4 Statistical functions and tools
% Last updated 02/02/2022 by C. Vanderwel
% This exercise is about how to plot a probability density function of a 
% turbulence data signal. 
%
% The example data set is obtained using hot-wire anemometry to measure the
% streamwise velocity in a wind tunnel sampled at 60 kHz for a total time 
% of 30 s. 
%
% The questions asks to estimate the probability density function of the 
% data, by plotting the histogram of the data choosing appropriate bin sizes.

clear all;
close all;

% Load the data
U = readmatrix('TurbulenceSample.txt');

% We usually want to focus on the PDF of the velocity fluctuations
Um = mean(U); %calculate the mean of the signal
u = U-Um; %create a new signal that represents just the fluctuations

% Determine the histogram of the data
ax = [-6:.01:6]; %set up the bins for the pdf (this spans from -6 to 6 in steps of 0.01)
ay = hist(u,ax); %calculate the histogram of u, ie the number of samples in each bin
ay = ay./trapz(ax,ay); %normalise so that the integral of the pdf is 1

% Plot the probability density function
figure; %open a new figure
plot(ax,ay,'b-'); %plot the pdf of u
xlabel('u (m/s)'); ylabel('p(u)')

