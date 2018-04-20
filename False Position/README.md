# False Position Function Documentation
### Description  
The program `falsePosition.m` uses the False Position method to estimate roots of an input function.  

**`Inputs`**  
  * func- a single variable function input by the user  
  * xl- the lower "guess" bracketing the root  
  * xu- the upper "guess" bracketing the root  
  * es- the desired realtive error (defaults to .001%)  
  * maxiter- the maximum number of iterations (defaults to 200)  
  
**`Outputs`**  
  * root- the approximate root of the function  
  * fx- the function evaluated at the approximate root  
  * ea- the relative error approximation  
  * iter- the number of iterations the computation took  
  
This program was written by Kolbin Dahley in March 2018  
