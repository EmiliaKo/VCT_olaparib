function sim_results = simulate_n_steps(parameters,system_current)
%% -- Perform n steps of the simulation
% INPUTS - model parameters
%        - system struct 
% OUTPUT - various simulation results as a struct
%% --
    sim_results = create_output();
    system = system_current; % fetch current system
    time_init = system.time; % fetch current time

    time = time_init; 
    while true     
        % simulate step
        system = simulate_step(system,parameters);
        sim_results = add_simulation_results(sim_results, system);
        % update necessary parameters
        parameters.d_carboplatin_sensitive =  compute_d_carboplatin(system,parameters);
        parameters.d_olaparib_sensitive = compute_d_olaparib(system,parameters);
        if parameters.olaparib_on == true || parameters.chemotherapy_on == true
            parameters.treatment_duration = parameters.treatment_duration + parameters.t_step;
        end

        % simulation termination conditions
        if parameters.phase == 1 && (sim_results.total_cancer_cells(end)> parameters.M_diagnosis || time > parameters.T_pre)
            break 
        elseif parameters.phase ~= 1 && (sim_results.total_cancer_cells(end)>= parameters.M_relapse || (time-time_init)>=parameters.time_max) 
            break 
        end

        % start from scratch if cancer extinction in the first phase
        if sim_results.total_cancer_cells(end)== 0 && parameters.phase ==1 
            sim_results = create_output();
            system = set_initial_conditions(parameters); 
            continue
        end
         
        time = time + parameters.t_step;
    end    
end


