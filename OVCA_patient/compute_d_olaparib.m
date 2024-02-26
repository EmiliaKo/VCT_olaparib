function d_olaparib_sensitive = compute_d_olaparib(system,parameters)
%% -- create empty results from simulation struct 
% INPUTS - system -current system
% OUTPUT - d_olaparib_sensitive - death rate of olaparib-sensitive cancer cells
%% --
    d_olaparib_sensitive = (system.parpi * 0.004) / parameters.olaparib_dose;
end