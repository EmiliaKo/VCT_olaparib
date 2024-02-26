function results_parpi = sim_toxicity_management(parameters,mode,results_parpi) 

      if isequal(mode,'all')
        type_of_toxicity = sample_hist(parameters.toxicity_management',1);
        idx =  find(type_of_toxicity==1);
      elseif isequal(mode,'reduction')
          idx =1;
      elseif isequal(mode,'discontinuation')    
          idx = 2;
      elseif isequal(mode,'interruption')
         idx = 3;
      end

      switch idx
          case 1 % dose reduction
                olaparib_dose = parameters.reduction_olaparib_dose;
                duration = results_parpi.parpi_time;
                for i =1:numel(olaparib_dose)
                        system = get_current_system(results_parpi); 
                        parameters.olaparib_dose = olaparib_dose(i);   

                        parameters.T_parpi = 2*365 - duration;
                        results_parpi_toxicity = sim_parpi(parameters,system);
                        duration = duration + results_parpi_toxicity.parpi_time;
                        results_parpi = merge_results_struct(results_parpi, results_parpi_toxicity);

                        if results_parpi.total_cancer_cells(end)>=parameters.M_relapse || ...
                           duration >= parameters.T_parpi
                            break
                        end
                end    
          case 3 % dose interruption
            system = get_current_system(results_parpi);
            parameters.phase = 3;
            parameters.time_max = parameters.discontinuation_time;
            results_discontinuation=simulate_n_steps(parameters,system);
            system = get_current_system(results_discontinuation);
            parameters.phase = 2;
            parameters.T_parpi = 2*365 - results_parpi.parpi_time;
            results_parpi_after_discontinuation = sim_parpi(parameters,system);
            results_parpi = merge_results_struct(results_parpi, results_discontinuation, results_parpi_after_discontinuation);                      
      end
