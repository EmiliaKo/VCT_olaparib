
function  [p1,p2] = SOLO1_simulator(parameters)
%% --  simulate SOLO-1 clinical trial
% INPUTS - structure with the model parameters
% OUTPUT - figures of the 1st and 2nd PFS
%% --

% Initiation of the cohort variables
    cohort_Olaparib = init_results();
    cohort_Placebo  = init_results();

    parfor i = 1:parameters.n_patients    
        % Simulation of the olaparib 
        parpi = 1;
        cohort_Olaparib(i) = OVCA_sim_patient(parameters,parpi);

        % Simulation of placebo
        parpi = 0;
        cohort_Olaparib(i) = OVCA_sim_patient(parameters,parpi);
    end

    % extract PFS from results struct
    [PFS1_Olaparib,PFS2_Olaparib] = getEndPoints(cohort_Olaparib,par2.n_patients);
    [PFS1_Placebo,PFS2_Placebo] = getEndPoints(cohort_Placebo, par2.n_patients);

    % get data and plot Kaplan_Meier together for data and simulations (the first PFS)
    [data_Placebo, data_Olaparib] = getData(par2.PFS1_Olaparib_file,par2.PFS1_Placebo_file);
    p1 = plotKaplanMeier(PFS1_Olaparib, PFS1_Placebo, data_Placebo, data_Olaparib,par2.PFS1_length,1);

    % get data and plot Kaplan_Meier together for data and simulations (the second PFS)
    [data_Placebo, data_Olaparib] = getData(par2.PFS2_Olaparib_file,par2.PFS2_Placebo_file);
    p2 = plotKaplanMeier(PFS2_Olaparib, PFS2_Placebo, data_Placebo, data_Olaparib,par2.PFS2_length,2);
end



