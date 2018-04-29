function [t,y] = Heun(dydt,tspan,y0,h,es,maxit)
%Heun This function uses Heun's method to 
%   The Heun function uses Heun's method to model the differential equation
%   using numerical estimation. 
%   
%   INPUTS: 
%       dydt- differential equation (input as anonymous function)
%       tspan- the time window to differentiate across
%       y0- the initial condition, assumed at time t=0
%       h- the step size used to evaluate Heun's method
%       es- stopping criterion error COME BACK
%       maxit- maximum number of iterations (defaults to 50)
%   OUTPUTS:
%       t-an array containing the t values
%       y-an array containing the numerical approximation at said t value

t0=tspan(1); %initializes variables, and sets the first values of t and y
e=100;
iter=0;
t(1)=t0;
y(1)=y0;
if nargin<4 %checks for valid number of input arguments 
    error("At least four arguments are required.");
elseif nargin<5 %sets defaults for maxit and es if not defined by user
    maxit=50;
    es=.001;
elseif nargin<6 %sets default for maxit if not defined by user
    maxit=50;
end
iterationNumber=floor((tspan(2)-tspan(1))/h); %defines number of times to use Heun's method
for i=1:iterationNumber
    slope_left=dydt(t0,y0); %calculates slope left
    predictor=y0+h*dydt(t0,y0); %predicts y(i+1) 
    slope_right=dydt(t0+h,predictor); %predicts slope right using y(i+1)
    corrector=y0+(h/2)*(slope_left+slope_right); %corrects using Heun's method
    while e>es && iter<=maxit %iterates until maxit or stopping error is achieved
        correctorNew=y0+(h/2)*(slope_left+(dydt(t0+h,corrector)));
        e=(abs((correctorNew-corrector))/correctorNew)*100;
        corrector=correctorNew;
        iter=iter+1;
    end
    t(i+1)=t0+h; %stores time value in array t
    y(i+1)=corrector; %stores the predicted y(i+1) 
    y0=corrector; %resets y0 for new left slope
    t0=t0+h; %resets t0 for
    iter=0; %resets iter
    e=100; %resets error
end
%the if statement below does exactly what the one above does, but for an
%extra interval of h that is not the same as the h above (see readME for
%more info)
if iterationNumber*h~=tspan(2)
    t0=tspan(2);
    h=tspan(2)-iterationNumber*h;
    slope_left=dydt(t0,y0);
    predictor=y0+h*dydt(t0,y0);
    slope_right=dydt(t0+h,predictor);
    corrector=y0+(h/2)*(slope_left+slope_right);
    while e>es && iter<=maxit
        correctorNew=y0+(h/2)*(slope_left+(dydt(t0+h,corrector)));
        e=(abs((correctorNew-corrector))/correctorNew)*100;
        corrector=correctorNew;
        iter=iter+1;
    end
    t(i+2)=t0;
    y(i+2)=corrector;
end
plot(t,y,'ro--') %plots the final results 
end