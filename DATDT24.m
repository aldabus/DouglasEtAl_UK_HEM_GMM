function acc=DATDT24(Mw,Rjb,T,model,branch,weightopt)
%% Returns 5%-damped PGA and PSA predictions for the horizontal component of the ground motion in units of m/s^2
% for the hybrid-empirical model for the UK (Douglas et al. (2024) - Ground motion models for earthquakes occurring
% in the United Kingdom. Bulletin of Earthquake Engineering.

%% Input data
% Mw - Moment magnitude
% Rjb - Joyner-and-Boore site-to-source distance definition
% T - Period in seconds. Coefficients are available for the following periods:0.01 (PGA), 0.025, 0.05, 0.075,
%    0.10, 0.15, 0.20, 0.30, 0.40, 0.50, 0.75, 1.0, 1.5, 2.0, 3.0, 4.0, 5.0, 7.5, 10.0.
% model - Number of branches in the selected model (e.g. 3 for the 3-branch model, or 5 for the 5-branch model)
% branch - Branch number (e.g., for the 3-branch model this can be either 1 (upper branch), 2 (middle branch) or 3 (lower branch))
% weightopt - "original" for the default (original) weights in the logic tree, or "reweighted" for weights updated using a Bayesian approach. 

% Coded by G Aldama-Bustos 04/06/2024 (guillermo.aldama-bustos@jacobs.com)
% Corresponding author: J Douglas (john-douglas@gmx.com)

%%
if T == 0
    T = 0.01;
end

varname = ['DATDT24_Coefficients',num2str(model),'b'];
load(strcat(cd,"\FinalCoefficients\DATDT24_Coefficients.mat"),varname)
if model == 3
    DATDT24_Coefficients = DATDT24_Coefficients3b;
elseif model == 5
    DATDT24_Coefficients = DATDT24_Coefficients5b;
elseif model == 216
    DATDT24_Coefficients = DATDT24_Coefficients216b;
end

Widx = strcmp(DATDT24_Coefficients.("Weighting Option"),weightopt);
DATDT24_CoefficientsAux = DATDT24_Coefficients(Widx,:);
idx = find(cell2mat(DATDT24_CoefficientsAux.("Period (s)"))==T...
    & cell2mat(DATDT24_CoefficientsAux.Branch)==branch);
if isempty(idx)
    error('No coefficients available for the desired period')
end

coeff = DATDT24_CoefficientsAux(idx,:);

b = cell2mat([coeff.b1,coeff.b2,coeff.b3,coeff.b4,coeff.b5,coeff.b6,coeff.b7,coeff.b8,coeff.b9,coeff.b10]);
func1 = @attfuncampbell;
[acc,~] = feval(func1,[Mw,Rjb],b);
acc = exp(acc);
