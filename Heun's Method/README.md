# Heun's Method Function Documentation
### Description  
The program `Heun.m` uses Heun's Method to approximate the integration of a user defined 
differential equation. It will display these estimates and plot the estimated curve. 

**`Inputs`**  
  * dydt- user defined differential equation  
  * tspan- 2 element vector input for time to integrate across  
  * y0- initial condition  
  * h- the step size used to evaluate Heun's method  
  * es- stopping criterion error (defaults to .001)  
  * maxit- maximum number of iterations (defaults to 50)  
  
  
**`Outputs`**  
  * t- an array containing the t values  
  * y- an array containing the numerical approximation at said t value  
  
This program was written by Kolbin Dahley in March, 2018