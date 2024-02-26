function [TumorComposition] = cancer_composition(S)
%% -- get composition of cancer cells
% INPUTS - struct with cancer cells
% OUTPUT - struct with cancer cell composition
%% --
    sensitive_cells = 0;
    platinum_parpi_resistant_cells = 0;
    platinum_resistant_cells = 0;
    parpi_resistant_cells = 0;

    for subclone = keys(S)
       subclone_name = sscanf(char(subclone{1}),'%f,%f');
       if all(subclone_name==0)
               sensitive_cells = sensitive_cells +  S(subclone{1});
       elseif subclone_name(1)>=1 && subclone_name(2) < 1 
               platinum_resistant_cells = platinum_resistant_cells + S(subclone{1});
       elseif subclone_name(1)<1 && subclone_name(2) >= 1
               parpi_resistant_cells = parpi_resistant_cells + S(subclone{1});    
       elseif subclone_name(1)>=1 && subclone_name(2)>=1
               platinum_parpi_resistant_cells = platinum_parpi_resistant_cells+S(subclone{1});
       end
    end

    TumorComposition.sensitive_cells=sensitive_cells;
    TumorComposition.platinum_parpi_resistant_cells=platinum_parpi_resistant_cells;
    TumorComposition.platinum_resistant_cells=platinum_resistant_cells;
    TumorComposition.parpi_resistant_cells = parpi_resistant_cells;
end