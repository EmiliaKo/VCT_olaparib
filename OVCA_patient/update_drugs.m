function [carboplatin, parpi] = update_drugs(system,parameters)
%% -- update drug's concentration
% INPUTS - system - current system as struct
%          parameters -  struct with the model parameters
% OUTPUT - updated drugs concentration
%% --
    carboplatin = system.carboplatin*exp(-parameters.k_carboplatin*parameters.treatment_duration);
    parpi =     system.parpi    *exp(-parameters.k_parpi*parameters.treatment_duration);
end