function outputs = get_outputs(patient)

outputs.subclones_cx = numel(values(patient.Cancer_cx));
outputs.subclones_dx = numel(values(patient.Cancer_dx));

TumorComposition_dx = cancer_composition(patient.Cancer_dx);
composition   =[TumorComposition_dx.platinum_parpi_resistant_cells,
    TumorComposition_dx.platinum_resistant_cells,
    TumorComposition_dx.parpi_resistant_cells,
    TumorComposition_dx.sensitive_cells];

outputs.fraction_diagnosis = sum(composition(1:3))/sum(composition);
outputs.WBC_nadir = patient.WBC_nadir;
outputs.cx_response=patient.cx_response;
outputs.residual_tumor = patient.residual_tumor;
outputs.maintenance_time=patient.maintenance_time;
outputs.toxicity_to_parpi = patient.discontinuation_toxicity;
outputs.M_diagnosis=patient.M_diagnosis;
outputs.fitness = patient.fitness;
outputs.WBC_naive = patient.WBC_naive;



    Subclones_dx = keys(patient.Cancer_dx);
    selection_olaparib = 0;
    system.parpi =300;
    d_olaparib=compute_d_olaparib(system,parameters);
    for row = 1 : numel(Subclones_dx)
        subclone = Subclones_dx{row};
        subclone = sscanf(char(subclone),'%f,%f')';  
        
        death_parpi = d_olaparib.*parameters.d_parpi(subclone(2)+1);
   
        b = .5*(1+patient.fitness) - death_parpi; 
        d = 1-.5*(1+patient.fitness) + death_parpi;                       
        selection_olaparib = selection_olaparib+(b-d);
    end
 outputs.selection_olaparib = selection_olaparib./numel(Subclones_dx);


outputs.PFS=patient.PFS1;
outputs.PFS_cens = patient.PFS1_cens;


end




