function results = sim_cx(parameters,system_current,line)
%% -- Perform platinum-based chemotherapy
% INPUTS - parameters - model parameters, 
%        - system -current state of the system, 
%        - line - line of cx - "first", "second"
% OUTPUT - results struct
%% --
    results=create_output();
    parameters.time_max = 21;
    system = system_current;
    results.treatment_start = 1;
    for cycle_idx = 1:6
        parameters.treatment_duration = 0;
        system.carboplatin = parameters.carboplatin_dose + system.carboplatin;
        parameters.d_carboplatin_sensitive =  compute_d_carboplatin(system,parameters);
        results_week=simulate_n_steps(parameters, system);
        results = merge_results_struct(results, results_week); 
        results.treatment_start =[results.treatment_start numel(results.time)];

        if isempty(results.total_cancer_cells)
            break
        end
        system = get_current_system(results);
        switch cycle_idx
            case 1
                results.Cancer_first_cycle = results.Cancer;
                results.Cancer_first_cycle_duration = parameters.treatment_duration;
            case 2
                results.Cancer_second_cycle = results.Cancer;
                results.Cancer_second_cycle_duration = parameters.treatment_duration;
            case 3
                results.Cancer_third_cycle = results.Cancer;
                results.Cancer_third_cycle_duration = parameters.treatment_duration;
            case 4
                results.Cancer_fourth_cycle = results.Cancer;
                results.Cancer_fourth_cycle_duration = parameters.treatment_duration;
            case 5
                results.Cancer_fifth_cycle = results.Cancer;
                results.Cancer_fifth_cycle_duration = parameters.treatment_duration;
            case 6
                results.Cancer_sixth_cycle = results.Cancer;
                results.Cancer_sixth_cycle_duration = parameters.treatment_duration;
        end
    end

   
    if line == "first"
        nadir = zeros(6,1);
        time_to_nadir = zeros(6,1);
        for idx = 1:parameters.Cx_cycles
            t_start = results.treatment_start(idx);
            t_stop = t_start+21*2;
            WBC = results.WBC(t_start:t_stop);
            [~,col]=find(WBC == min(WBC));
            nadir(idx) = WBC(col(1));
            time_to_nadir(idx) = col(1)/2;
        end
        results.nadir = nadir;
        results.time_to_nadir = time_to_nadir;  
   end
end