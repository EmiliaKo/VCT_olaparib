function parameters = draw_parameters(parameters)
    parameters.s = parameters.s_min + (parameters.s_max-parameters.s_min)*rand(); 
    parameters.M_diagnosis = lognrnd(parameters.M_logmean,parameters.M_logsigma); 
    parameters.K_wbc = parameters.K_wbc_min + (parameters.K_wbc_max-parameters.K_wbc_min)*rand();  

    [parameters.d_carboplatin, parameters.d_parpi] = setDrugDeathRate(parameters);
end