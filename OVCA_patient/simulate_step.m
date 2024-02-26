function system = simulate_step(system,parameters)
%% -- Perform one step of the simulation
% INPUTS - system struct
%          parameters -  struct with the model parameters
% OUTPUT - updated system struct
%% --
% update cancer cells    
    system.Cancer = update_cancer(system,parameters);
% update drugs concentration
    [system.carboplatin, system.parpi] = update_drugs(system,parameters);
% update white blood cells    
    system.WBC =update_WBC(system,parameters);
% update current time    
    system.time = system.time + parameters.t_step;
end











