function propensities = event_propensity(subclone,parameters)
%% -- compute events propensities
% INPUTS - subclone - a subclone name, vector with two elements 
%          parameters -  struct with the model parameters
% OUTPUT - propensity of each possible event
%% --
    %% get drug-induced death rate for a given subclone
    if parameters.chemotherapy_on == true
        d_carboplatin = parameters.d_carboplatin_sensitive.*parameters.d_carboplatin(subclone(1)+1);
    else 
        d_carboplatin = 0;
    end
    if parameters.olaparib_on == true
        d_parpi = parameters.d_parpi_sensitive.*parameters.d_parpi(subclone(2)+1);
    else
        d_parpi = 0;
    end

    %% probabilities of each event
    % symmetric division rate
    b = .5*(1+parameters.s)*(1-parameters.u_carboplatin-parameters.u_parpi-parameters.u_cross_resistance-parameters.u_reversion) - d_carboplatin-d_parpi; 
    % death rate
    d = 1-.5*(1+parameters.s)+d_carboplatin+d_parpi; 

    % asymmetric division leading to resistance to pt-based chemotherapy
    b_carboplatin = .5*(1+parameters.s)*parameters.u_carboplatin;  
    % asymmetric division leading to resistance to olaparib
    b_parpi     = .5*(1+parameters.s)*parameters.u_parpi;   
    % asymmetric division leading to resistance to olaparib and pt-based chemotherapy
    b_cross_resistance = .5*(1+parameters.s)*parameters.u_cross_resistance; 
    % asymmetric division leading to reversion mutation that cause resistance to olaparib
    b_reversion = .5*(1+parameters.s)*parameters.u_reversion;  
    %% compute events propensities
    propensities = [b,d,b_carboplatin, b_parpi, b_cross_resistance, b_reversion];

end