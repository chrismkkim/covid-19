# covid-19

Code and data to model the Covid-19 progression in a given population.

Code in SIRmcmc.jl is used to repeat the SIR analysis of Lourenco et al. (2020). SIRmcmc.jl contains the function mcmc(data,r,total) to run a Metropolis-Hastings MCMC on the model parameters, where data is the cumulative death time series starting from the first death, r is the set of 4 SIR ODE model parameters, and total is the number of MCMC samples. The SIR ODE model is implemented in two versions of the function oxford(zinit,yinit,total,dt,beta,sigma,rtheta,psi), which use different numerical integration methods. The function mcmc outputs the sample series for the loglikelihood and parameters as well as the maximum likelihood parameters.  The parameter guess at each step is implemented in sampleparams!(rt,r), which uses a lognormal guess distribution.  The loglikelihood is computed in the function loss(data,r) which uses a Poisson likelihood function with rate given by the predicted death number from the model.  The model can be called to directly fit all four parameters with model(r) or three parameters with R0 constrained to 2.25 with modelconstrained(r).

SIRcasedeath.jl is a model that includes cases, deaths, and recovered cases.  It is an SIRC model where infected people become cases C and uninfected (which could include those that recover and those that die but are not counted).  Cases can recover or die.  The data is then fit to Cases, deaths and recovered cases.

