%% Turbulence: Ch9 Turbulent Mixing - Plume eddy diffusivity
% Last updated 28/07/2021 by C. Vanderwel
% This exercise is about determining the turbulent diffusivity of a plume.
% Details of the experiment are provided by Vanderwel & Tavoularis (2014). 
% Measurements of turbulent diffusion in uniformly sheared flow. 
% Journal of fluid mechanics, 754, 488-514.
%
% In this exercise we will load two data files:
% PlumeData1.txt - acquired at y = 16.1mm above the plume centreline
% PlumeData2.txt - acquired at y = 18.5mm above the plume centreline
% 
% Each file contains 1000 independent samples of:
% C, concentration normalised by the source concentration (unitless)
% U, streamwise velocity (mm/s)
% V, vertical velocity in the direction of the shear (mm/s)
% W, spanwise velocity (mm/s)

clear all;
close all;

% preview the data file format
opts = detectImportOptions('PlumeData1.txt','FileType','text');
preview('PlumeData1.txt',opts)

% load the data
[C_pt1,U_pt1,V_pt1,W_pt1] = readvars('PlumeData1.txt',opts);
Y_pt1 = 16.1;

% preview the data file format
opts = detectImportOptions('PlumeData2.txt','FileType','text');
preview('PlumeData2.txt',opts)

% load the data
[C_pt2,U_pt2,V_pt2,W_pt2] = readvars('PlumeData2.txt',opts);
Y_pt2 = 18.5;


%% a) Calculate the mean concentration at each point. 
% From this, determine the vertical gradient of the mean concentration 
% between these two points.

AvgC1 = mean(C_pt1)
AvgC2 = mean(C_pt2)
dCdy = (AvgC1 - AvgC2)/(Y_pt1 - Y_pt2)

%% b) Plot a scatter plot of the concentration fluctuations versus fluctuations 
% in the vertical velocity component at both points. Does this indicate a 
% positive, negative, or neutral correlation?

AvgV1 = mean(V_pt1);
AvgV2 = mean(V_pt2);

figure; scatter((V_pt1 - AvgV1),(C_pt1 - AvgC1))
hold on; scatter((V_pt2 - AvgV2),(C_pt2 - AvgC2),'r')
xlabel('v (mm/s)')
ylabel('C / C_S')
grid on
corrcoef((C_pt1 - AvgC1),(V_pt1 - AvgV1))
corrcoef((C_pt2 - AvgC2),(V_pt2 - AvgV2))

%% c) Calculate vertical turbulent concentration flux cv at both points 
% and report the average. Explain the significance of this term.

cv1 = mean((C_pt1 - AvgC1) .* (V_pt1 - AvgV1))
cv2 = mean((C_pt2 - AvgC2) .* (V_pt2 - AvgV2))
cv = mean([cv1,cv2])

%% d) Using the first-order gradient transport model, determine the turbulent 
% diffusivity, ?T (including units). The intermittency of the concentration 
% signal creates some uncertainty in the result - estimate the range of 
% confidence in this result.

D = -cv ./ dCdy
