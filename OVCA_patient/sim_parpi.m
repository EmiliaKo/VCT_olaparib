function results = sim_parpi(parameters,system)
%% -- Perform treatment with olaparib
% INPUTS - parameters - model parameters, 
%        - system -current state of the system, 
% OUTPUT - results struct
%% --
    results=create_output();
    parameters.u_cross_resistance = parameters.u_cross_resistance_during_PARPi;    
    parameters.u_reversion = parameters.u_reversion_during_PARPi;
    parameters.time_max = .5;
    parameters.treatment_duration = .5;
    time_parpi = .5;
   while true
        system.parpi = system.parpi + parameters.olaparib_dose;
        parameters.d_parpi_sensitive =  compute_d_olaparib(system,parameters);
        results_step = simulate_step(system,parameters);
        results = add_simulation_results(results, results_step);
        system = results_step;

        if results.total_cancer_cells(end)>=parameters.M_relapse % patient relapse
            results.discontinuation_toxicity = 0;
            break
         end

         if time_parpi >= parameters.T_parpi % maintenance time ends
            results.discontinuation_toxicity = 0;
             break
         end

        if results.WBC(end) < parameters.leukopenia % toxicity detected  
            results.discontinuation_toxicity = 1;
            break;
        end
        time_parpi=time_parpi+parameters.time_max;
    end
    results.parpi_time = time_parpi;
    results.Cancer = system.Cancer;
    parameters.u_cross_resistance = parameters.u_cross_resistance_no_PARPi;    
    parameters.u_reversion = parameters.u_reversion_no_PARPi;

end