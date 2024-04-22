# DouglasEtAl_UK_HEM_GMM
Ground-motion models for earthquake occurring in the UK derived using the hybrid stochastic-empirical method (Douglas et al., 2024)


## Contact people
John Douglas (john-douglas@gmx.com)

Guillermo Aldama Bustos (guillermo.aldama-bustos@jacobs.com)

Sarah Tallett-Williams (sarah.tallettwilliams@jacobs.com)

Manuela Davi (manuela.davi@jacobs.com)

Iain Tromans (iain.tromans@jacobs.com)


## Features and Functionality

All scripts are coded in Matlab, but we will be producing equivalent codes in Python.

#raeng_backbone_model

Returs pseudo-spectral accelerations for the Douglas et al. (2024) UK HEM model given the following input parameters:

Mw - Moment magnitude

Rjb - Joyner-and-Boore site-to-source distance definition

T - Period in seconds. PGA can be inputted as "0" or "0.01". 

branch - Branch number (e.g., for the 3-branch model this can be either 1 (upper branch), 2 (middle branch) or 3 (lower branch))

model - Number of branches in the selected model (e.g. 3 for the 3-branch model, or 5 for the 5-branch model)

weightopt - "original" for the default (original) weights in the logic tree, or "reweighted" for weights updated using a Bayesian approach. 

Coefficients are available for the following periods:

T = 0.01 (PGA), 0.025, 0.05, 0.075, 0.10, 0.15, 0.20, 0.30, 0.40, 0.50, 0.75, 1.0, 1.5, 2.0, 3.0, 4.0, 5.0, 7.5, 10.0.


## Notes

Although most of the codes have gone through a QA process, bugs can be present. 
Please let us know any bugs you may find.

Coefficients for the full (128-branch) model are not yet available, but we are hoping to upload these soon.


