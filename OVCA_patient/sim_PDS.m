function results = sim_PDS(system,parameters)
%% -- Perform PDS
% INPUTS - system - current state of the system as struct
%        - parameters - model parameters
% OUTPUT - results struct
%% --
        
    % perform PDS
    system_before_PDS = system;
    cells = cell2mat(values(system_before_PDS.Cancer));
    cells = round((1-parameters.beta).*cells);
    cells(isinf(cells)) = 0;
    
    system_after_PDS = system;
    idx = 1;
    for key = keys(system_before_PDS.Cancer)
        system_after_PDS.Cancer(char(key)) = cells(idx);
        idx = 1+idx;
    end

    results=init_outputs();
    results=add_simulation_results(results,system_before_PDS);
    results=add_simulation_results(results,system_after_PDS);

    results.time = [0 0];

    % resting phase after PDS
    parameters.time_max = 30;
    results_resting_phase = simulate_n_steps(parameters,system_after_PDS);
   
    results = merge_results_struct(results,results_resting_phase);
end