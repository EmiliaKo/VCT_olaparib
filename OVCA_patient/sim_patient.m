function patient = sim_patient(parameters)
%% -- Perform simulation of one patient
% INPUTS - model parameters
% OUTPUT - patient struct
%% --
    while true
        % - draw model parameters & set initial conditions
            parameters = draw_parameters(parameters);
            system = set_initial_conditions(parameters);
            parameters.phase = 1;
        
        % - simulate pre-treatment phase
            parameters.treatment_duration = 0;
            sim_preTreatment=simulate_n_steps(parameters,system);
            if sim_preTreatment.total_cancer_cells(end) < parameters.M_diagnosis
                continue
            end
            results_pre = get_pre_treatment(sim_preTreatment);

        %== here treatment starts
            parameters.phase = 2;
            % - simulate primary debulking surgery and resting phase after surgery
            system = get_current_system(results_pre);
            results_PDS = sim_PDS(system,parameters);     

            % - simulate adjuvant platinum-based chemotherapy
            system = get_current_system(results_PDS); 
            parameters.chemotherapy_on = true;
            results_cx = sim_cx(parameters,system,'first');
            parameters.chemotherapy_on = false;
            M_before_cx=results_PDS.total_cancer_cells(end);
            M_after_cx=results_cx.total_cancer_cells(end);
            results_cx.cx_response =100- 100*(M_after_cx/M_before_cx); 
            if results_cx.cx_response < 0 % if not complete response/partial response
                continue
            end
        
        patient_until_randomization = merge_results_struct(results_pre,results_PDS, results_cx);
        % % - simulate PARPi maintainance
        if parameters.PARPi == true
            parameters.olaparib_on = true;
            parameters.u_cross_resistance = parameters.u_cross_resistance_during_PARPi;
            parameters.u_reversion = parameters.u_reversion_during_PARPi;
            system = get_current_system(results_cx);  
            results_parpi = sim_parpi(parameters,system);
            parameters.u_cross_resistance = parameters.u_cross_resistance_no_PARPi;
            parameters.u_reversion = parameters.u_reversion_no_PARPi;

           if results_parpi.discontinuation_toxicity == 1 % handle olaparib toxicity
              parameters.olaparib_on = true;
              parameters.u_cross_resistance = parameters.u_cross_resistance_during_PARPi;
              parameters.u_reversion = parameters.u_reversion_during_PARPi;
              results_parpi = sim_toxicity_management(parameters,'all',results_parpi); 
              parameters.u_cross_resistance = parameters.u_cross_resistance_no_PARPi;
              parameters.u_reversion = parameters.u_reversion_no_PARPi;
           end
             system = get_current_system(results_parpi);
             parameters.phase = 3;
             parameters.time_max = parameters.T_followup;
             results_remission=simulate_n_steps(parameters,system);
             patient = merge_results_struct(results_pre,results_PDS, results_cx, results_parpi, results_remission);
        elseif parameters.PARPi == false % placebo arm 
             system = get_current_system(results_cx);
             parameters.phase = 3;
             parameters.time_max = parameters.T_followup;
             results_remission=simulate_n_steps(parameters,system);
             patient = merge_results_struct(patient_until_randomization, results_remission);
       end        


 if patient.total_cancer_cells> 0
     PFS1 = patient.time(end)-patient_until_randomization.time(end);
     PFS1_cens = 0;
     system = get_current_system(patient); 
     parameters.chemotherapy_on = true;
     parameters.M_relapse = 2*10^10;
     results_cx_second = sim_cx(parameters,system,'second');
     parameters.chemotherapy_on = false;
    if isempty(results_cx_second.WBC)
        disp("HERE")
        disp(patient.total_cancer_cells(end))
        return
    else
     system = get_current_system(results_cx_second);
    end
     parameters.phase = 3;
     parameters.time_max = parameters.T_followup;
     parameters.M_relapse = 10^10;
     results_remission_second=simulate_n_steps(parameters,system);
     PFS2_start = patient.time(end);
     patient = merge_results_struct(patient, results_cx_second, results_remission_second);
     PFS2 = patient.time(end) - PFS2_start;
     PFS2_cens = 0;
 else
     PFS1 = 50*30;
     PFS1_cens = 1;
     PFS2 = nan;
     PFS2_cens = nan;
 end

 patient.nadir = results_cx.nadir;
 patient.time_to_nadir = results_cx.time_to_nadir;
 if parameters.PARPi ==1
    patient.discontinuation_toxicity = results_parpi.discontinuation_toxicity;
 else 
     patient.discontinuation_toxicity = nan;
 end
 patient.Cancer_dx = sim_preTreatment.Cancer;
 patient.Cancer_cx = patient_until_randomization.Cancer;
 patient.WBC_nadir = min(patient_until_randomization.WBC);

 patient.cx_response = 1-(results_cx.total_cancer_cells(1)/results_cx.total_cancer_cells(1));   
 patient.residual_tumor = 1-(results_PDS.total_cancer_cells(1)/results_PDS.total_cancer_cells(1));  
  if parameters.PARPi ==1
    patient.maintenance_time = results_parpi.time(end) - results_parpi.time(end);
  else
    patient.maintenance_time = nan;
  end
 patient.M_diagnosis = parameters.M_diagnosis;
 patient.fitness = parameters.s;
 patient.PFS1 = PFS1;
 patient.PFS1_cens = PFS1_cens;
patient.WBC_naive = parameters.K_wbc;

 patient.PFS2 = PFS2;
 patient.PFS2_cens = PFS2_cens;
 break
end

