%% Turbulence: Ch6 Free shear flows - 2D planar wake data
% Last updated 28/04/2021 by C. Vanderwel
% This exercise is about analyzing the self-similarity of a planar wake flow.
% The experimental data is from Nakayama, A. "Characteristics of the flow around 
% conventional and supercritical airfoils." J. Fluid Mech 160 (1985): 155-179.
% available at https://turbmodels.larc.nasa.gov/airfoilwake_val.html
%
% y is in inches (airfoil chord=24 inches); to get y/c use y/24
% u is u/Uinf
% v is v/Uinf 
% uu is u'u'/Uinf**2
% vv is v'v'/Uinf**2
% -uv is -u'v'/Uinf**2 (the negative of u'v'/Uinf**2)

clear all;
close all;

% preview the data file format
opts = detectImportOptions('WakeData.txt');
preview('WakeData.txt',opts)

% load the data
[index, y_list, U_list, V_list, uu_list, vv_list, uv_list] = readvars('WakeData.txt');

% manually parse the data into cell arrays delineating each downstream station
x = {1.01, 1.05, 1.20, 1.40, 1.80, 2.19, 3.00}; % location x/c

endpoints = [0; find(isnan(index)); length(index)+1];
for i = 1:length(endpoints)-1
    datarange = (endpoints(i)+1):(endpoints(i+1)-1);
    y{i} = y_list(datarange)./24;  %normalise y as y/c
    U{i} = U_list(datarange);
    V{i} = V_list(datarange);
    uu{i} = uu_list(datarange);
    vv{i} = vv_list(datarange);
    uv{i} = -uv_list(datarange); % correct the sign of the Reynolds stress
end

clear index y_list U_list V_list uu_list vv_list uv_list datarange endpoints


%% a)	Plot the velocity profile U/Uinf versus the vertical position y/c.
figure; 
for i = 1:7
    plot(y{i},U{i},'o'); hold on;
end
title('(a)')
xlabel('y/c')
ylabel('U/U_\infty')

%% b)	Define a new variable, U_def, which is equal to the velocity deficit function and plot that.
figure;
for i = 1:7
    U_def{i} = 1-U{i};
    plot(y{i},U_def{i},'o'); hold on;
end
title('(b,c)')
xlabel('y/c')
ylabel('f = (U_\infty - U)/U_\infty')

%% c) See if you can fit a function of the same form as the self-similar solution to the velocity deficit data. 

% Define a new y-variable with finer detail
y2 = -.15:.001:0.15;

% Fit the expected self-similar profile using Matlab best fit
for i = 1:7
    curve{i} = fit(y{i},U_def{i},'a*exp(b*(x-c).^2)','StartPoint',[0.1,-100,0]);
    hold on; plot(y2,curve{i}(y2),'-')

    % Note that curve{i}.a represents U_S
    U_S{i} = curve{i}.a;

    % Note that curve{i}.b can be related to delta by inspection of the 
    % definition of a Gaussian ie. (exp(-(x-c).^2/(2*sigma^2))
    delta{i} = sqrt(-1/(2*curve{i}.b));
    
    % Apply a factor of sqrt(2ln(2)) to convert this value of delta to the 
    % Half Width-Half Max (HFHM) definition (ie. f=1/2 when eta =1).
    delta{i} = sqrt(2*log(2)) * delta{i};
   
    % Note that curve{i}.c represents the shift in the centreline
    y0{i} = curve{i}.c;
    
end

%% d) What is the halfwidth of this wake? 
% Compare the halfwidth with the value of delta found from the curve fit above

for i = 1:7
    % Determine the halfwidth from the second-central moment of the profile.
    halfwidth{i} = sqrt( sum(U_def{i}.*(y{i}-curve{i}.c).^2)./sum(U_def{i}) );
    
    % Apply a factor of sqrt(2ln(2)) to convert this value of delta to the 
    % Half Width-Half Max (HFHM) definition (ie. f=1/2 when eta =1).
    halfwidth{i} = sqrt(2*log(2)) * halfwidth{i};
    
    % Notice that the halfwidth calculated this way is very similar to the
    % value of delta calculated from the best fit. You might consider the
    % difference to reflect the uncertainty in the result.
    
end



%% e) Now that we know the fit parameters, re-plot the velocity data using the self-similar variables. 
%ie. f = (Uinf-U)/(Uinf-U)_max and eta = (y-c)/delta
figure
for i = 1:7
    f{i} = U_def{i}/U_S{i};
    eta{i} = (y{i} - y0{i})/(delta{i});
    plot(eta{i},f{i},'o'); hold on;
end
title('(f)')
xlabel('\eta = (y-y_0)/\delta')
ylabel('f = (U_\infty - U)/U_S')

% Compare with the self-similar solution
eta2 = -5:.1:5; % Define a new eta-variable with finer detail
plot(eta2, exp(-log(2)*eta2.^2),'k-')



%% f) Check whether delta grows as x^(1/2) and U_S decays as x^(-1/2). Check whether U_S*delta and Beta = U_infty/U_S * d delta / dx are constant.

figure
subplot(2,2,1)
plot([x{:}],[delta{:}],'o')
powerlaw = fit([x{:}]',[delta{:}]','a*(x-b).^(1/2)+c','StartPoint',[0.1,1,.01])
hold on; plot([0:0.1:4],powerlaw([0:0.1:4]),'-')
title('(e (i))')
xlabel('$x/c$','Interpreter','LaTeX')
ylabel('$\delta/c$','Interpreter','LaTeX')

subplot(2,2,2)
plot([x{:}],[U_S{:}],'o')
powerlaw = fit([x{:}]',[U_S{:}]','a*(x-b).^(-1/2)','StartPoint',[0.1,1])
hold on; plot([0:0.1:4],powerlaw([0:0.1:4]),'-')
title('(e (ii))')
xlabel('$x/c$','Interpreter','LaTeX')
ylabel('$U_S/U_\infty$','Interpreter','LaTeX')

subplot(2,2,3)
plot([x{:}],[U_S{:}].*[delta{:}],'o')
title('(e (iii))')
xlabel('$x/c$','Interpreter','LaTeX')
ylabel('$(U_S / U_\infty) (\delta / c)$','Interpreter','LaTeX')

subplot(2,2,4)
Beta = 1./[U_S{:}] .* gradient([delta{:}],[x{:}]);
plot([x{:}],Beta,'o')
title('(e (iv))')
xlabel('$x/c$','Interpreter','LaTeX')
ylabel('$\beta = (U_\infty / U_S) (d \delta / dx)$','Interpreter','LaTeX')

% From these plots, it is clear that this wake flow is not yet fully
% self-similar. Beta fluctuates


%% g) Plot the shear stress profiles using self-similar variables as well.

figure;
for i = 1:7
    plot(eta{i},-uv{i}./U_S{i}^2,'o'); hold on;
end
title('(g)')
xlabel('\eta = (y-y_0)/\delta')
ylabel('-uv/U_S^2')

% Compare with the self-similar solution (assuming g = -1/R_T * f', assuming R_T = 12.5)
R_T = 12.5; % alternatively you can try R_T = 2*log(2)/Beta(end);
g = -1/R_T * -2*log(2) * eta2 .* exp(-log(2) * eta2.^2);
plot(eta2, g,'k-')

% Note that the shear stress profiles don't collapse because Beta and hence
% R_T are not yet constant and this wake flow is not yet fully self-similar.
