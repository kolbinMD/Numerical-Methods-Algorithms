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
t0=0;
e=100;
iter=0;
t(1)=0;
y(1)=y0;
if nargin<4
    error("At least four arguments are required.");
elseif nargin<5
    maxit=50;
    es=.001;
elseif nargin<6
    maxit=50;
end
iterationNumber=floor(tspan/h);
for i=1:iterationNumber
    slope_left=dydt(y0,t0);
    predictor=y0+h*dydt(y0,t0);
    slope_right=dydt(predictor,t0+h);
    corrector=y0+(h/2)*(slope_left+slope_right);
    while e>es && iter<=maxit
        correctorNew=y0+(h/2)*(slope_left+(dydt(corrector,t0+h)));
        e=(abs((correctorNew-corrector))/correctorNew)*100;
        corrector=correctorNew;
        iter=iter+1;
    end
    t(i+1)=t0+h;
    y(i+1)=corrector;
    y0=correctorNew;
    t0=t0+h;
    iter=0;
    e=100;
end
end

