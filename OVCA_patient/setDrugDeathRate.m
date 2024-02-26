function [d_cisplatin,d_parpi] = setDrugDeathRate(parameters)
%% -- compute drug-induced death rate for all possible subclones
% INPUTS - parameters -  struct with the model parameters
% OUTPUT - cisplatin-induced & PARPI-induced death rate for each subclone
%% --
    n_max  = 500; % maximal number of resistance mechanisms to one drug (assumption)
    n = 1:n_max;
    d_cisplatin = parameters.alpha_carboplatin.^(n-1);
    d_parpi     = parameters.alpha_parpi.^(n-1);
end
