function system = set_initial_conditions(parameters)
%% -- set initial conditions
% INPUTS - param -  struct with the model parameters
% OUTPUT - whole system (cancer cells, drugs concentration, WBC level) in form of struct
%% --
        system.Cancer = containers.Map('0,0',1);   
        system.WBC = parameters.K_wbc;
        system.carboplatin = 0;
        system.parpi = 0;
        system.time = 0;
end