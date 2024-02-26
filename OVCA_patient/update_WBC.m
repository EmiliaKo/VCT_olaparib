function WBC = update_WBC(system,parameters)
%% -- update WBC
% INPUTS - WBC - number of WBC 
%          param -  struct with the model parameters
%          cisplatin - cisplatin concentration
%          parpi - PARPi concentration
% OUTPUT - updated drugs concentration
%% --
    WBC = system.WBC;
    cisplatin = system.carboplatin;
    parpi = system.parpi;

    b_WBC   = .5*(1+parameters.s_WBC*(1-WBC/parameters.K_wbc)) - ...
              WBC*parameters.gamma_parpi*parpi-cisplatin*WBC*parameters.gamma_carboplatin;
    d_WBC   = 1-b_WBC;
    events  = sample_hist([b_WBC d_WBC]',WBC);
    WBC = WBC + events(1) - events(2);
end