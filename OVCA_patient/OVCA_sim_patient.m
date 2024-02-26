
function results_pre = OVCA_sim_patient(parameters)
%% -- Perform simulation of one patient
% INPUTS - model parameters
% OUTPUT - patient 
%% --

    while true
        % - draw model parameters & set initial conditions
        parameters = draw_parameters(parameters);
        system = set_initial_conditions(parameters);
        system.Cancer = containers.Map('0,0',1); 
        % - simulate pre-treatment phase
        sim_preTreatment=OVCA_sim_n_steps(parameters,system);

        
        results_pre = getPreTreatment(sim_preTreatment);
       
%         %== here treatment starts
%            parameters.phase = 2;
%         % - simulate primary debulking surgery and resting phase after surgery
%           system = get_current_system(results_pre);
%           results_PDS = sim_PDS(system,parameters);     
%  
%         % - simulate adjuvant platinum-based chemotherapy
% %         system = get_current_system(results_PDS); 
% %         parameters.d_cisplatin = (parameters.cisplatin_dose * .06) / 459.7;
% %         results_cx = sim_cx(parameters,system,false);
% %         TumorBurdenBeforeCX=results_PDS.total_cancer_cells(end);
% %         TumorBurdenAfterCX=results_cx.total_cancer_cells(end);
% %         results_cx.Cx_response =100- 100*(TumorBurdenAfterCX/TumorBurdenBeforeCX); 
% %         if results_cx.total_cancer_cells(end) >= parameters.M_relapse
% %             continue
% %         end
%         % - simulate PARPi maintainance
%         if parameters.PARPi == 1
% %             parameters.u_cross_resistance = parameters.u_cross_resistance_during_PARPi;
% %             parameters.T_max = 0.5;
% %             system = get_current_system(results_cx);  
% %             results_parpi = sim_parpi(parameters,system);
% % 
% %             if isequal(parameters.mode,'standard')
% %                 system = get_current_system(results_parpi); 
% %                 parameters.T_max = parameters.T_followup; 
% %                 results_first_recurrence = OVCA_sim_n_steps(parameters,system);
% %             end
% %             parameters.u_cross_resistance = parameters.u_cross_resistance_no_PARPi;
% %             parameters.d_cisplatin = (parameters.cisplatin_dose * .06) / 459.7;
% %             system = get_current_system(results_first_recurrence); 
% %             results_cx_second = sim_cx(parameters, system,true);
% %             parameters.T_max = 5*365 ; 
% %             system = get_current_system(results_cx_second); 
% %             results_second_recurrence = OVCA_sim_n_steps(parameters,system);
%             patient_merged = merge(results_pre, results_PDS); %results_parpi, results_first_recurrence, results_cx_second, results_second_recurrence);
%             disp([numel(patient_merged.WBC), numel(patient_merged.time)])
%             patient.cisplatin = patient_merged.cisplatin;
%             patient.olaparib = patient_merged.parpi;
%             patient.WBC = patient_merged.WBC;
%             patient.sensitive_cells = patient_merged.SensCells;
%             patient.resistant_cells = patient_merged.ResCells;
%             patient.platinum_resistant_cells = patient_merged.PtResCells;
%             patient.olaparib_resistant_cells = patient_merged.PARPiResCells;
%             patient.total_cancer_cells  = patient_merged.total_cancer_cells;
%             patient.time = patient_merged.time;
% %             patient.WBC_nadir = results_cx.nadir;
% %             patient.WBC_time_to_nadir = results_cx.T;
% %             patient.PARP_toxicity = results_parpi.disc_toxicity;
% %             patient.PFS1 = results_first_recurrence.time(end)-results_parpi.time(1);
% %             patient.PFS2 = results_second_recurrence.time(end) - results_cx_second.time(end);
% %             patient.response = results_cx.Cx_response;
% %             patient.tumor_composition_diagnosis = results_pre.Cancer;
% %             patient.tumor_composition_after_chemotherapy_first_line = results_cx.Cancer;
% %             patient.tumor_composition_first_relapse = results_cx.Cancer;
% %             patient.tumor_composition_after_chemotherapy_second_line  = results_cx_second.Cancer;
% %             patient.tumor_composition_first_relapse = results_first_recurrence.Cancer;
% %             patient.K_wbc = parameters.K_wbc;
% %             patient.M_diagnosis = parameters.M_diagnosis;
% %             patient.selection = parameters.s;
% 
% 
%         else
%             system = get_current_system(results_cx);  
%             results_first_recurrence = OVCA_sim_n_steps(parameters,system);
%             system = get_current_system(results_first_recurrence); 
%             results_cx_second = sim_cx(parameters, system,true);
%             parameters.T_max = 5*365 ; 
%             system = get_current_system(results_cx_second); 
%             results_second_recurrence = OVCA_sim_n_steps(parameters,system);
%             patient_merged = merge(results_pre, results_PDS, results_cx, results_first_recurrence, results_cx_second, results_second_recurrence);
%             patient.cisplatin = patient_merged.cisplatin;
%             patient.olaparib = patient_merged.parpi;
%             patient.WBC = patient_merged.WBC;
%             patient.sensitive_cells = patient_merged.SensCells;
%             patient.resistant_cells = patient_merged.ResCells;
%             patient.platinum_resistant_cells = patient_merged.PtResCells;
%             patient.olaparib_resistant_cells = patient_merged.PARPiResCells;
%             patient.total_cancer_cells  = patient_merged.total_cancer_cells;
%             patient.time = patient_merged.time;
%             patient.WBC_nadir = results_cx.nadir;
%             patient.WBC_time_to_nadir = results_cx.T;
%             patient.PARP_toxicity = nan;
%             patient.PFS1 = results_first_recurrence.time(end)-results_cx.time(end);
%             patient.PFS2 = results_second_recurrence.time(end) - results_cx_second.time(end);
%             patient.response = results_cx.Cx_response;
%             patient.tumor_composition_diagnosis = results_pre.Cancer;
%             patient.tumor_composition_after_chemotherapy_first_line = results_cx.Cancer;
%             patient.tumor_composition_first_relapse = results_cx.Cancer;
%             patient.tumor_composition_after_chemotherapy_second_line  = results_cx_second.Cancer;
%             patient.tumor_composition_first_relapse = results_first_recurrence.Cancer;
%             patient.K_wbc = parameters.K_wbc;
%             patient.M_diagnosis = parameters.M_diagnosis;
%             patient.selection = parameters.s;
%    
%         end




%         if isequal(param_opt.mode,'discontinuation')
%             if param.T_parpi-numel(results_parpi.time)/2<=0 || ...
%                 results_parpi.TotalCancerCells(end)==0 
%                 continue
%             end
%             param.u_cross_resistance = param_opt.u_cross_resistance;
%             param.T = param_opt.T_discontinuation;
%             system = get_current_system(results_parpi);  
%             results_discontinuation = OVCA_sim_n_steps(param,system);
%             results_discontinuation.time = results_discontinuation.time + results_parpi.time(end);
% 
%             param.u_cross_resistance = param_opt.u_cross_resistance_during_PARPi;
%             param.T = 0.5;
%             param.T_parpi = param.T_parpi-numel(results_parpi.time)/2;
%             system = get_current_system(results_discontinuation); 
%             results_parpi_after_discontinuation = sim_parpi(param,system,results_discontinuation);
% 
%             param.T = 5*365; % observe the patient for max 5 years from start treatment with Olaparib
%             param.u_cross_resistance = param_opt.u_cross_resistance;
%             system = get_current_system(results_parpi_after_discontinuation); 
%             results_first_recurrence = OVCA_sim_n_steps(param,system);
%             results_first_recurrence.time = results_first_recurrence.time + results_parpi_after_discontinuation.time(end); 
% 
%         elseif isequal(param_opt.mode,'standard')
%             param.u_cross_resistance = param.u_cross_resistance;
%             if isstruct(results_parpi)
%                 system = get_current_system(results_parpi); 
%                 param.T = 5*365 - numel(results_parpi)/2; 
%                 results_first_recurrence = OVCA_sim_n_steps(param,system);
%                 results_first_recurrence.time = results_first_recurrence.time + results_parpi.time(end);
%             else
%                 param.T = 5*365; 
%                 system = get_current_system(results_cx); 
%                 results_first_recurrence = OVCA_sim_n_steps(param,system);
%                 results_first_recurrence.time = results_first_recurrence.time + results_cx.time(end); 
%             end  
%         elseif isequal(param_opt.mode,'reduction')
%             if param.T_parpi-numel(results_parpi.time)/2<=0 || ...
%                 results_parpi.TotalCancerCells(end) == 0 
%                 continue
%             end
%             param.u_cross_resistance = param.u_cross_resistance_during_PARPi;
%             param.T = 0.5;
%             param.T_parpi = param.T_parpi-numel(results_parpi.time)/2;
%             param.d_parpi = param_opt.reduction * param.d_parpi;
%             system = get_current_system(results_parpi); 
%             results_parpi_dose_reduction = sim_parpi(param,system,results_parpi);
% 
%             param.u_cross_resistance = param_opt.u_cross_resistance;
%             system = get_current_system(results_parpi_dose_reduction); 
%             param.T = 5*365; 
%             results_first_recurrence = OVCA_sim_n_steps(param,system);
%             results_first_recurrence.time = results_first_recurrence.time + results_parpi_dose_reduction.time(end);
% 
%         elseif isequal(param_opt.mode,'discontinuation_reduction')
%             if param.T_parpi-numel(results_parpi.time)/2<=0 || ...
%                 results_parpi.TotalCancerCells(end)==0 
%                 continue
%             end
% 
%             param.u_cross_resistance = param.u_cross_resistance;
%             param.T = param_opt.T_discontinuation;
%             system = get_current_system(results_parpi);  
%             results_discontinuation = OVCA_sim_n_steps(param,system);
%             results_discontinuation.time = results_discontinuation.time + results_parpi.time(end);
% 
%             param.u_cross_resistance = param.u_cross_resistance_during_PARPi;
%             param.T = 0.5;
%             param.T_parpi = param.T_parpi-numel(results_parpi.time)/2;
%             system = get_current_system(results_discontinuation); 
%             param.d_parpi = param_opt.reduction * param.d_parpi;
%             results_parpi_after_discontinuation = sim_parpi(param,system,results_discontinuation);
% 
%             param.T = 5*365; 
%             param.u_cross_resistance = param_opt.u_cross_resistance;
%             system = get_current_system(results_parpi_after_discontinuation); 
%             results_first_recurrence = OVCA_sim_n_steps(param,system);
%             results_first_recurrence.time = results_first_recurrence.time + results_parpi_after_discontinuation.time(end); 
% 
%         end
%  
%      %% - simulate the second-line cx treatment 
%         param.u_cross_resistance = param.u_cross_resistance;
%         param.T = param.T_blood; 
%         system = get_current_system(results_first_recurrence); 
%         results_cx_second = sim_cx(param,system,true);
%         results_cx_second.time = results_cx_second.time + results_first_recurrence.time(end); 
% 
%     % simulate time to the second relapse
%         param.T = 10*365 - (results_cx_second.time(end)-results_cx.time(end)); 
%         system = get_current_system(results_cx_second); 
%         results_second_recurrence = OVCA_sim_n_steps(param,system);
%         results_second_recurrence.time = results_second_recurrence.time + results_cx_second.time(end);
% 
% %% - merge results  & get model outputs       
%         if isstruct(results_parpi)
%             if isequal(param_opt.mode,'standard')
%                 patient = merge(results_pre,results_PDS,results_cx,results_parpi,results_first_recurrence,results_cx_second,results_second_recurrence);
%             elseif isequal(param_opt.mode,'discontinuation')
%                 patient = merge(results_pre,results_PDS,results_cx,results_parpi,results_discontinuation, results_parpi_after_discontinuation,results_first_recurrence);
%             elseif isequal(param_opt.mode,'reduction')
%                 patient = merge(results_pre,results_PDS,results_cx,results_parpi, results_parpi_dose_reduction,results_first_recurrence,results_cx_second,results_second_recurrence);
%             elseif isequal(param_opt.mode,'discontinuation_reduction')
%                 patient = merge(results_pre,results_PDS,results_cx,results_parpi,results_discontinuation, results_parpi_after_discontinuation,results_first_recurrence);
%             end
%         else
%             patient = merge(results_pre,results_PDS,results_cx,results_first_recurrence,results_cx_second,results_second_recurrence);
%         end
%        patient = get_model_outputs(patient, param, results_pre, results_PDS, results_cx, results_parpi,results_first_recurrence, results_cx_second,results_second_recurrence);
%         patient.maintenance_time = numel(results_parpi.time)/2;
        break
    end
 

end


