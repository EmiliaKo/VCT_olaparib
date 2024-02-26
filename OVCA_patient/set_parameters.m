function parameters = set_parameters(PARPi, olaparib_dose)
%% -- create struct with all model prameters
% INPUTS - parpi -olaparib maintenence is ON/OFF
% OUTPUT - olaparib_dose - dose of olaparib in mg
%% --
 
%% Parameters related to cancer growth and resistance accumulation
parameters.DT_min = 300;    % doubling time in days (maximum value)
parameters.DT_max = 18;                   % doubling time in days (minimum value)
parameters.s_min = (70/parameters.DT_min)/200;  % selection advanatge of cancer cells (minimum)
parameters.s_max = (70/parameters.DT_max)/200;  % selection advanatge of cancer cells (maximum)
parameters.u_carboplatin = 1*10^-9;           % rate of accumulation of resistance to carboplatin
parameters.u_parpi     = 1*10^-9;           % rate of accumulation of resistance to olaparib
parameters.u_cross_resistance = 10^-12;   % current rate of cross-resistance accumulation without olaparib treatment
parameters.u_reversion = 10^-12;           %  current rate of reversion of the BRCA1/2 mutation without olaparib treatment
parameters.u_cross_resistance_no_PARPi = parameters.u_cross_resistance; % rate of cross-resistance accumulation without olaparib treatment
parameters.u_reversion_no_PARPi = parameters.u_reversion; %r ate of reversion of the BRCA1/2 mutation without olaparib treatment
parameters.u_cross_resistance_during_PARPi = 3*10^-7;  % rate of cross-resistance accumulation during olaparib treatment
parameters.u_reversion_during_PARPi = 2.5*10^-7;    % rate of reversion of the BRCA1/2 mutation during olaparib treatment
    
%% parameters related to OVCA treatment
parameters.PARPi = PARPi;
parameters.carboplatin_dose = 459.7;        % carboplatin dose resulting from Clavert equation
parameters.olaparib_dose = 300;           % olaparib dose in mg
parameters.T_parpi=2*365;                 % duration of the olaparib treatment
parameters.Cx_cycles = 6;                 % number of cycles of pt-based chemotherapy
parameters.M_relapse = 10^10;             % tumor burden at relapse (number of cells)
parameters.T_PDS = 30;                    % resting phase after primary debulking surgery in days
parameters.beta = .999;                   % fraction of cancer cells removed by surgery
parameters.carboplatin_dose = 459.7;
parameters.olaparib_dose = olaparib_dose;
parameters.reduction_olaparib_dose =[250, 200, 150, 100];
parameters.d_carboplatin_sensitive =  (parameters.carboplatin_dose * .027) / parameters.carboplatin_dose; %(parameters.cisplatin_dose * 1*10^-12) / 459.7;     % for scaling purposes; cisplatin-induced death rate on sensitive cells
parameters.d_parpi_sensitive = (parameters.olaparib_dose * 0.004) / parameters.olaparib_dose;   %olaparib-induced death rate on sensitive cells
parameters.chemotherapy_on = false;
parameters.olaparib_on = false;


%% Pharmacokinetics parameters
parameters.k_carboplatin = 0.005;               % carboplatin decay rate
parameters.k_parpi = 137 * parameters.k_carboplatin;   % olaparib decay rate
parameters.alpha_carboplatin = .5;             % decrease rate of response to carboplatin due to drug resistance    
parameters.alpha_parpi = .5;                % decrease rate of response to olaparib due to drug resistance    

%% Lymphocyte parameters
parameters.wbc_scale = 5*10^6;                 % for scaling of the WBC 
parameters.K_wbc_min = 4500*parameters.wbc_scale;    % minimal normal level of Lymphocytes in adult female 
parameters.K_wbc_max = 10500*parameters.wbc_scale;   % maximal normal level of Lymphocytes in adult female 
parameters.leukopenia = 1000*parameters.wbc_scale;       % WBC threshold assumed for toxicity
parameters.s_WBC = (70/(14))/200;             % selection advantage of white blood cells assuming doubling time equal to 14 days
parameters.gamma_carboplatin = .6*10^-14;        % effect of carboplatin on Lymphocytes
parameters.gamma_parpi = .261*10^-14;          % effect of olaparib on Lymphocytes

%% Toxicity management parameters
dose_reduction = .52;  % proportion of patient that undergo dose reductinon after olaparib toxicity detection                     
dose_interruption = .28; % proportion of patient that undergo dose interruption after olaparib toxicity detection                     
dose_discontinuation = .12; % proportion of patient that undergo dose discontinuation after olaparib toxicity detection                     
parameters.toxicity_management = [dose_reduction dose_interruption dose_discontinuation];
parameters.toxicity_management = parameters.toxicity_management./sum(parameters.toxicity_management);
parameters.discontinuation_time = 7; % discontinuation time in days

%% Miscellaneous parameters
parameters.t_step = 0.5;          % time step is every 12h so it is 0.5 day 
parameters.T_pre = 20*365;        % max time of simulation of pre-tretment phase in days 
parameters.T_blood = 7;           % time between two consecutive measurement of Lymphocytes  in days
parameters.T_followup = 50*30;    % max followup time from diagnosis in days
parameters.phase = 1;             % phase of simulation - we start from the first phase
parameters.n_patients = 1000;     % number of virtual patients in the cohort
parameters.M_logmean  = 26.5934;  % parameter of log-normal prob. dist. fun.: Log mean
parameters.M_logsigma = 0.4709;   % parameter of log-normal prob. dist. fun.: Log standard deviation
parameters.PFS1_olaparib_file = "PFS1_Olaparib.txt";
parameters.PFS1_placebo_file = "PFS1_Placebo.txt";
parameters.PFS2_olaparib_file = "PFS2_Olaparib.txt";
parameters.PFS2_placebo_file = "PFS2_Placebo.txt";
