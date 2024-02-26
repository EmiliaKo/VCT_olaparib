function results = get_pre_treatment(results)
%% -- get results from pre-treatment phase, i.e., extract the last 90 data points
% INPUTS - results struct
% OUTPUT - modified results struct
%% --
    number_of_elements = numel(results.carboplatin);
    results.carboplatin = results.carboplatin(number_of_elements-90:end);
    results.olaparib = results.olaparib(number_of_elements-90:end);
    results.WBC = results.WBC(number_of_elements-90:end);
    results.time = results.time(number_of_elements-90:end);
    results.sensitive_cells = results.sensitive_cells(number_of_elements-90:end);
    results.platinum_parpi_resistant_cells = results.platinum_parpi_resistant_cells(number_of_elements-90:end);
    results.platinum_resistant_cells = results.platinum_resistant_cells(number_of_elements-90:end);
    results.parpi_resistant_cells = results.parpi_resistant_cells(number_of_elements-90:end);
    results.total_cancer_cells =results.total_cancer_cells(number_of_elements-90:end);
    results.time = -45:.5:0;
