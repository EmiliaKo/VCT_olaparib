function d_carboplatin_sensitive = compute_d_carboplatin(system,parameters)
%% -- create empty results from simulation struct 
% INPUTS - system -current system
% OUTPUT - d_carboplatin_sensitive - death rate of carboplatin-sensitive cancer cells
%% --

    d_carboplatin_sensitive =  (system.carboplatin * .027) / parameters.carboplatin_dose;
end