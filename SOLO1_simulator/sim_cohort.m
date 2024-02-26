function results = sim_cohort(patients,parpi,T_maintanance,olaparib_dose,mode,value)
%% -- simulate a cohort of virtual patients
% INPUTS - parpi -olaparib maintenence is ON/OFF
%        - T_maintanance - duration of olaparib maintenance in days
%        - mode - mode of dealing with olaparib toxicity:
%           * 'all' - all type of management strategies according to SOLO-1 clinical trial
%           * 'reduction' - only dose reduction 
%           * 'interruption' - only dose interruption
%        - value - if 'reduction'- olaparib dose after dosereduction, if 'interruption' - duration of drug holiday in days
% OUTPUT - results - results struct wth results from simulation of 1000 virtual patients
%% --

    results = init_results();
    parfor i = 1:patients
        parameters = set_parameters(parpi,olaparib_dose);
        if isequal(mode,'reduction')
            parameters.reduction_olaparib_dose = value;
        elseif isequal(mode,'interruption')
            parameters.discontinuation_time = value;
        end
        parameters.T_parpi = T_maintanance;
        patient = sim_patient(parameters);
        results(i) = patient;
    end

end