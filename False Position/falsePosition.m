function [root, fx, ea, iter] = falsePosition(func,xl,xu,es,maxiter)
%falsePosition A root finding function
%   Coded by: Kolbin Dahley
%   INPUTS:
%       func: A symbolic single variable function
%       xl: The lower "guess" bracketing the root
%       xu: The upper "guess" bracketing the root
%       es: The desired relative error (defaults to .0001%)
%       maxiter: The maximum number of iterations (defaults to 200)
%   OUTPUTS:
%       root: The approximate root of the function (func)
%       fx: The function evaluated at the approximated root
%       ea: The relative error approximation
%       iter: The number of iterations the computation took
% 
%   Using the false position method, this function will approximate the
%   roots of a given function as long as the given brackets (xl and xu)
%   bracket a root. If computation time is long, reselect brackets that
%   more closely surround the approximate root
tic
format long
iter=0; %Initiates the variable "iteration"
ea=100; %Initializes the variable ea
xGuessOld=abs(((xu-xl)/2))+xl; %Calculates the first guess of the root, right in the middle of the brackets
if nargin<3 %Checks for proper number of inptus
    error("At least three inputs are required.") 
elseif nargin<4 %If the user only inputs 3 arguments, sets es and maxiter to their defaults
    es=.0001;
    maxiter=200;
elseif nargin<5 %If the user only inputs 4 arguments, sets maxiter to its default
    maxiter=200;
end
if sign(func(xl))== sign(func(xu)) %Checks to make sure the selected brackets actually surround a root
    fprintf("There is no root, please pick new brackets. \n")
elseif xu<=xl %Checks to ensure the brackets are in the proper order
    error("Please be sure that you input your brackets in the proper order.")
elseif func(xl)==0||func(xu)==0 %Just in case somebody guessed the root
    fprintf('One of your brackets is the root!!')
else
    while iter<maxiter && ea >= es %Ensures that the root is only approximated while the error and iteration conditions are met
        root= xu-(func(xu)*(xu-xl)/(func(xu)-func(xl))); %Approximates the root using the false position method
        iter=iter+1; %Adds one to the iteration counter
        if root==0 %If the root is zero, then ea can't be computed, and this will tell the user that. 
            fprintf("Can't determine ea, division by zero.\n")
        end
        ea=abs(((root-xGuessOld))/root)*100; %Calculates the relative approximate error
        xGuessOld=root; %Changes the xGuessOld to the root approximation for the last iteration
        if sign(func(root))<0 %Decides if the root approximation should be the lower bound or the upper bound
            xl=root;
        else
            xu=root;
        end
    end
root=double(root); %Converts the root variable to a double
fx=func(root); %Evaluates the given function (func) at the root approximation
fx=double(fx); %Converts the fx variable to a double 
fprintf('The approximate error is %6.8f percent, the computation completed in %1.0f iterations, and the function evaluated to %6.4f at the root %6.4f \n', ea,iter,fx,root)    
end
toc
end