# DouglasEtAl_UK_HEM_GMM
This software evaluates the earthquake ground motion models, derived using the hybrid empirical-stochastic method (HEM), proposed in the following article:

Ground-motion models for earthquakes occurring in the United Kingdom

John Douglas, Guillermo Aldama-Bustos, Sarah Tallett-Williams, Manuela Daví, Iain J. Tromans Bulletin of Earthquake Engineering, 2024, https://doi.org/10.1007/s10518-024-01943-8


## Contact people
John Douglas (john-douglas@gmx.com)

Guillermo Aldama Bustos (guillermo.aldama-bustos@jacobs.com)

Sarah Tallett-Williams (sarah.tallettwilliams@jacobs.com)

Manuela Davi (manuela.davi@jacobs.com)

Iain Tromans (iain.tromans@jacobs.com)


## Features and Functionality

All versions of the model are currently coded in Matlab and Excel, but we will be producing equivalent codes in Python and Fortran in the near future.


#DATDT24.m (Matlab script) and DATDT24_ModelEvaluation.xlsx (Excel file)

Returns pseudo-spectral accelerations for the Douglas et al. (2024) UK HEM model given the following input parameters:

Mw - Moment magnitude

Rjb or Rrup - Joyner-and-Boore site-to-source distance or rupture distance (in km)

T - Period in seconds between 0 (PGA) and 10s. PGA can be inputted as "0" or "0.01".

model - Number of branches in the selected model (e.g. 3 for the 3-branch model, or 5 for the 5-branch model)

branch - Branch number (e.g., for the 3-branch model this can be either 1 (upper branch), 2 (middle branch) or 3 (lower branch))

weightopt - "original" for the default (original) weights in the logic tree, or "reweighted" for weights updated using a Bayesian approach.

Coefficients are available for the following periods:

T = 0.01 (PGA), 0.025, 0.05, 0.075, 0.10, 0.15, 0.20, 0.30, 0.40, 0.50, 0.75, 1.0, 1.5, 2.0, 3.0, 4.0, 5.0, 7.5, 10.0.


#branchweight.m

Returns the weight to be used in the logic tree for the selected branch and model. 

This is particularly useful when combining results from the 162-branch model (either ground-motion predictions or hazard estimates) in a logic tree framework.


#CHEEP output files
The output files from the CHEEP calculations are provided in 'CHEEP output files'. 

A detailed description of the programe and outputs can be find at: https://pureportal.strath.ac.uk/en/datasets/cheep-composite-hybrid-equation-estimation-program


## Notes
Although all codes have gone through a QA process, bugs may still be present. Please let us know if you find any. We do not take any responsibility for the validity of this software.




