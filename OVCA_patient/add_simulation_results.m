function sim_results = add_simulation_results(sim_results, system)
%% -- Get part of the output during simulation
% INPUTS - sim_results - results struct
%        - system - results from a single step of simulation
% OUTPUT - results struct
%% --
    sim_results.Cancer = system.Cancer;
    composition = cancer_composition(system.Cancer);
    sim_results.sensitive_cells = [sim_results.sensitive_cells composition.sensitive_cells];
    sim_results.platinum_parpi_resistant_cells = [sim_results.platinum_parpi_resistant_cells composition.platinum_parpi_resistant_cells];
    sim_results.platinum_resistant_cells = [sim_results.platinum_resistant_cells composition.platinum_resistant_cells];
    sim_results.parpi_resistant_cells = [sim_results.parpi_resistant_cells composition.parpi_resistant_cells];
    sim_results.total_cancer_cells = [sim_results.total_cancer_cells sum(cell2mat(struct2cell(composition)))];
    sim_results.WBC = [sim_results.WBC system.WBC]; 
    sim_results.carboplatin = [sim_results.carboplatin system.carboplatin];
    sim_results.olaparib = [sim_results.olaparib system.parpi];
    sim_results.time = [sim_results.time system.time];
end