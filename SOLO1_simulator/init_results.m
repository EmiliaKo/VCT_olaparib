function results = init_results()
%% --  initiate results struct
% INPUTS - 
% OUTPUT - empty results struct
%% --
    results.carboplatin = [];
    results.olaparib = [];
    results.WBC = [];
    results.time = [];
    results.sensitive_cells = [];
    results.platinum_parpi_resistant_cells = [];
    results.platinum_resistant_cells = [];
    results.parpi_resistant_cells = [];
    results.total_cancer_cells  = [];
    results.Cancer =[];
    results.nadir = [];
    results.time_to_nadir = [];
    results.discontinuation_toxicity = [];
    results.Cancer_dx = [];
    results.Cancer_cx = [];
    results.WBC_nadir = [];
    results.cx_response = [];   
    results.residual_tumor = [];  
    results.maintenance_time = [];
    results.M_diagnosis = [];
    results.fitness = [];
    results.PFS1 = [];
    results.PFS1_cens = [];
    results.WBC_naive = [];
    results.PFS1 = [];
    results.PFS1_cens = [];
    results.PFS2 = [];
    results.PFS2_cens = [];    
end