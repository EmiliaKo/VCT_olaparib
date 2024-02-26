addpath("OVCA_patient/")
addpath("SOLO1_simulator/")
addpath("data/")
addpath("msc/")
parpi = true;
T_maintanance = 2*365;
olaparib_dose = 300;
mode = 'all';
value = nan;
tic
results_olaparib = sim_cohort(50,parpi,T_maintanance,olaparib_dose,mode,value);
toc

parpi = false;
tic
results_placebo = sim_cohort(50,parpi,T_maintanance,olaparib_dose,mode,value);
toc

[PFS1, PFS1_cens,PFS2, PFS2_cens] = getEndPoints(results_placebo);
[PFS1_Olaparib, PFS1_cens_Olaparib,PFS2_Olaparib, PFS2_cens_Olaparib] = getEndPoints(results_olaparib);
[data_Placebo, data_Olaparib] = getData('PFS1_Olaparib.txt','PFS1_Placebo.txt');

p1 = plotKaplanMeier(PFS1_Olaparib, ...
     PFS1_cens_Olaparib, ...
     PFS1, ...
     PFS1_cens, ...
     data_Placebo, ...
     data_Olaparib, ...
     43, ...
     1);
ylim([0 1])

PFS2_Olaparib = PFS2_Olaparib(~isnan(PFS2_Olaparib));
PFS2_cens_Olaparib = PFS2_cens_Olaparib(~isnan(PFS2_Olaparib));
[data_Placebo, data_Olaparib] = getData('data/PFS2_Olaparib.txt','data/PFS2_Placebo.txt');
p2 = plotKaplanMeier(PFS2_Olaparib, ...
     PFS2_cens_Olaparib, ...
     PFS2, ...
     PFS2_cens, ...
     data_Placebo, ...
     data_Olaparib, ...
     24, ...
     2);
ylim([0 1])
