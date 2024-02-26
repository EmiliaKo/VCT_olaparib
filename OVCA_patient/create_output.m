function sim_results = create_output()
%% -- create empty results from simulation struct 
% INPUTS - subclone - a subclone name, vector with two elements 
%          parameters -  struct with the model parameters
% OUTPUT - propensity of each possible event
%% --
    sim_results.carboplatin = [];
    sim_results.olaparib = [];
    sim_results.WBC = [];
    sim_results.time = [];
    sim_results.sensitive_cells = [];
    sim_results.platinum_parpi_resistant_cells = [];
    sim_results.platinum_resistant_cells = [];
    sim_results.parpi_resistant_cells = [];
    sim_results.total_cancer_cells =[];

end