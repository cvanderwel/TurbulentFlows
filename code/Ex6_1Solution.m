%% Turbulence: Ch6 Free shear flows - 2D mixing layer data
% Last updated 30/04/2021 by C. Vanderwel
% 
% This exercise is about analyzing the self-similarity of a 2D mixing layer.
% The experimental data is interpolated from the data of Delville & Bonnet
% of a plane mixing layer generated in a wind tunnel and measured using
% hot-wire. The data in this example is from a distance of x1 = 800 mm 
% downstream of the splitting plate, which separates two flows with 
% freestream velocities of 41.54 m·s-1 (upper) and 22.40 m·s-1 (lower).
% 
% Full details of the experiment and all raw data is available at
% https://torroja.dmt.upm.es/turbdata/agard/chapter6/SHL04/
%
% Y is in mm
% U is in m/s
% uv is in m^2/s^2
% k is in m^2/s^2
% epsilon is in m^2/s^3

clear all;
close all;

% preview the data file format
opts = detectImportOptions('MixingLayerData.txt');
preview('MixingLayerData.txt',opts)

% load the data
[Y, U, uv, k, epsilon] = readvars('MixingLayerData.txt');


%% (a)	Plot the velocity profile along with the expected self-similar solution on the same axes, and comment on your observations.
% The self-similar solution is an error function. Be careful that y=0 is
% not the centre.

% Plot
figure; plot(Y,U,'o')
xlabel('y (mm)'); ylabel('U (m/s)')
grid on

% Self-similar solution
y2 = -40:.1:50;
curve = fit(Y,U,'a*erf((x-b)/c)+d','StartPoint',[9, 4, 24, 32])
hold on; plot(y2,curve(y2))
legend('data','self-similar fit','Location','NorthWest')

%% (b)	Determine a suitable definition for the width of the mixing layer and calculate it's value. 
% There are several posibilities here and multiple possible correct solutions.
% One option is : Y(U = UA + 0.9*(UB-UA)) - Y(U = UA + 0.1*(UB-UA))

Uhigh = 22.40  + 0.9*(41.54 - 22.40);
Ulow = 22.40  + 0.1*(41.54 - 22.40);

% From our velocity plot we can see that these occur at y = +25.5 and -16.6
width = 25.5+16.6;


%% Assuming self-similarity, how far downstream would one expect the width of the mixing layer to double? 
% Solution: The width of the mixing layer grows linearly so we would expect
% it to double the width in double the distance.
% Bonus: if you consider that there might be a virtual origin that we can't
% account for.


%% (c)	Plot the Reynolds stress and explain why they are shaped as they are.
% Explanation: In a shear layer the u and v fluctuations are expected to
% be anti-correlated and produce Reynolds stresses. The sign of the
% Reynolds stress would be opposite when the shear was in the opposite
% direction. The peak is at the point of maximum shear.

figure; plot(Y,uv,'d-')
xlabel('y (mm)'); ylabel('uv (m/s)^2')


%% Plot the turbulent kinetic energy profiles and explain why they are shaped as they are.
% Explanation: The turbulent kinetic energy is zero outside of the mixing layer. 
% The maximum production of turblent kinetic energy occurs at the location of
% the highest rate of shear, which is at centre of the jet, this is why
% the highest turbulent kinetic energy occurs at the centre and
% not along the centreline. It tends to slightly skew towards the side with
% the higher velocity because there is more energy there.

figure; plot(Y,k,'d-')
xlabel('y (mm)'); ylabel('k (m/s)^2')

%% (d)	Compute and plot the production and dissipation profiles. 
% Explanation: Production and dissipation of turbulent kinetic energy both
% peak at the centre of the mixing layer. Production is positive and 
% dissipation is negative. 

dUdy = [diff(U) ./ diff(Y/1000); 0]; %(m/s)*(1/m) = (1/s) 
Production = -uv .* dUdy; %(m^2/s^3)

figure; plot(Y,Production,'d-',Y,-epsilon,'d-')
xlabel('y (mm)'); ylabel('(m^2/s^3)')
legend('Production','Dissipation','Location','NorthWest')





