%% Turbulence: Exercise4_7 from Ch4 Statistical functions and tools
% Last updated 07/02/2022 by C. Vanderwel
% This exercise is about investigating the spectrum of turbulence

clear all;
close all;

% load the data
U = readmatrix('TurbulenceSample.txt');

% Set up a time variable
acq_freq = 60000; %sampling frequency is 60kHz
dt = 1./acq_freq; %time interval between successive data points
t = 0:dt:(length(U)-1)*dt; %time of each sample

Ubar = mean(U);
u = U - Ubar;

%% 1. Calculate the energy spectra using an FFT. 

% Spectra (using the whole sample)
N = length(u); % number of samples
f = [0:N-1]./(N*dt); % determine the frequency range
uh = fft(u)/N; % do the FFT
eh = (conj(uh).*uh)*dt*N; % translate this into a spectrum (multiplying by N*dt ensures that the units are correct)
f = f(1:(N-1)/2); eh = eh(1:(N-1)/2); % cut off the data at the aliasing frequency
figure; loglog(f,eh); % plot the data on a log log scale
xlabel('frequency [Hz]')
ylabel('power spectral density')

% check that the area under the curve here should be equal to the variance of the signal
fprintf('area under S(f) = %f\n', trapz(f,eh));
fprintf('variance of signal = %f\n', var(u));

%% 2. Change the period and sampling rate to see what happens

% a. Reduce the sampling period (restrict the range of the data processed)
range = 1:floor(length(U)/2); % select a subrange of the data
N = length(u(range)); % number of samples
f = [0:N-1]./(N*dt); % determine the frequency range
uh = fft(u(range))/N; % do the FFT
eh = (conj(uh).*uh)*dt*N; % translate this into a spectrum (multiplying by N*dt ensures that the units are correct)
f = f(1:(N-1)/2); eh = eh(1:(N-1)/2); % cut off the data at the aliasing frequency
hold on; loglog(f,eh,'g'); % plot the data on a log log scale
legend('FFT','Reduced Period')

% Comments: Reducing the sampling period limits the accuracy of the short 
% frequencies (long wavelength motions) and the spectra plot does not 
% extend as far to the left.

% b. change the sampling rate (take every other data point)
factor = 2; % choose factor by which to reduce data
range = 1:factor:length(U); % select a subrange of the data
dtf = dt*factor; % update the time interval between successive data points
N = length(u(range)); % number of samples
f = [0:N-1]./(N*dtf); % determine the frequency range
uh = fft(u(range))/N; % do the FFT
eh = (conj(uh).*uh)*dtf*N; % translate this into a spectrum (multiplying by N*dt ensures that the units are correct)
f = f(1:(N-1)/2); eh = eh(1:(N-1)/2); % cut off the data at the aliasing frequency
hold on; loglog(f,eh,'c'); % plot the data on a log log scale
legend('FFT','Reduced Period','Reduced Sampling Rate')

% Comments: Reducing the sampling rate means the spectra plot does not 
% extend as far to the right as the aliasing frequency is SR/2.

%% 3. Try matlab's built-in function pwelch to split the data and calculate the spectra. 

integral_T =  0.0067; % Input the integral timescale of the flow (previously calculated in Ex4.4)

% Spectra (using windowing)
windowSize = round(50*integral_T/dt); % window length, [n samples]
overlapSize = round(windowSize/4); % overlap length [n samples]
[Pxx,F] = pwelch(u, windowSize, overlapSize, [], acq_freq);
hold on; loglog(F,Pxx,'r');
legend('FFT','Reduced Period','Reduced Sampling Rate','PWelch')

% check that the area under the curve here should be equal to the variance of the signal
% fprintf('area under S(f) = %f\n', trapz(F,Pxx));

% Comments: Note how the windowing and averaging significantly reduces the 
% scatter of the results but reduced the extent of the plot at low
% frequencies because it effectively reduced the sampling period.

%% BONUS: Use Taylor's hypothesis to convert the frequency spectra to a wavenumber spectra

% convert the power spectral density with respect to wavenumber
% Umean = mean(U);
% k = 2.*pi.*F/Umean;
% Pkk = Pxx*(Umean/(2*pi));

% check power in Fourier wavenumber domain
% fprintf(1, 'Fourier Power sum (k-domain) %f\n', trapz(k,Pkk));

%% 4. Compare the spectra with white and pink noise

% Load the data
[W,P1,P2] = readvars('NoiseSample.txt');

% Determine the spectra of the white noise
[Pxx,F] = pwelch(W, windowSize, overlapSize, [], acq_freq);
hold on; loglog(F,Pxx,'y');

% Determine the spectra of the pink noise
[Pxx,F] = pwelch(P1, windowSize, overlapSize, [], acq_freq);
hold on; loglog(F,Pxx,'m')

legend('FFT','Reduced Period','Reduced Sampling Rate','PWelch','White Noise','Pink Noise','Location','Best')