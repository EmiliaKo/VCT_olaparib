function [PFS1, PFS1_cens, PFS2, PFS2_cens] = getEndPoints(cohort)
%% --  get PFS as an endpoint
% INPUTS - cohort - array struct with simulation output
%        - n_patients - number of patients in a cohort
% OUTPUT - Olaparib-induced death rate
%% --
    n_patients =size(cohort,2);
    PFS1 = zeros(n_patients,1);
    PFS2 = zeros(n_patients,1);
    PFS1_cens = zeros(n_patients,1);
    PFS2_cens = zeros(n_patients,1);
    for i = 1:n_patients
        PFS1(i) = cohort(i).PFS1/30; 
        PFS2(i) = cohort(i).PFS2./30; 
        PFS1_cens(i) = cohort(i).PFS1_cens; 
        PFS2_cens(i) = cohort(i).PFS2_cens; 
    end
end