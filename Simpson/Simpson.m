function [I] = Simpson(x,y)
%Simpson Applies the 1/3 Simpson's Rule to approximate the integral of 
%user defined experimental data.
%   Written By: Kolbin Dahley
%
%   INPUTS: 
%       x- an array containing the independent experimental data
%       y- an array containing the dependent experimental data
%   OUTPUTS:
%       I- the approximate integral of the experimental data
if length(x)~= length(y) %checks to make sure both input vectors are the same length
    error('Inputs are not the same length')
end
if (max(diff(x))- min(diff(x)))>=.0000001%checks for equal spacing in x vector 
    error('The specified x vector is not evenly spaced')
end
interval=length(x)-1; %sets the number of intervals 
if mod(interval,2)==1 %checks to see if number of intervals is odd
    I=0;
    for i=1:2:interval-1 %applies the Simpson's 1/3 rule for all intervals but the last one
        b=x(i+2); 
        a=x(i);
        I=I+(b-a)*(y(i)+(4*y(i+1))+y(i+2))/6;
    end
    I=I+(x(length(x))-x(length(x)-1))*((y(length(y))+y(length(y)-1))/2); %applies the trapezoid rule for the last interval
    fprintf('Warning: The trapezoid rule was used to calculate the integral of the final interval') %warns the user that the trapezoid rule was used for the last interval
end
if mod(interval,2)==0 %checks to see if number of intervals is even
    I=0;
    for i=1:2:interval %applies the Simpson's 1/3 rule for all intervals
        b=x(i+2);
        a=x(i);
        I=I+(b-a)*(y(i)+(4*y(i+1))+y(i+2))/6;
    end
end
end