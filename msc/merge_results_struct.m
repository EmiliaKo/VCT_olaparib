function R = merge_results_struct(varargin)
%% -- Merge the results from different phases of simulation
% INPUTS - results structs to merge
% OUTPUT - merged results struct
%% --
    if nargin == 1
       error('You need at least two results structures to merge');
    else 
        n = nargin;
        R = varargin{1};
        fields = fieldnames(R);
        to_extract = ["carboplatin", "olaparib", "WBC", "time", "sensitive_cells", "platinum_parpi_resistant_cells", "platinum_resistant_cells", "parpi_resistant_cells", "total_cancer_cells"];                        

        for i =2:n
            for field_idx = 1:numel(fields)
                if ismember(fields(field_idx),to_extract)
                    R.(string(fields(field_idx))) = [R.(string(fields(field_idx))) varargin{i}.(string(fields(field_idx)))(2:end)];
            
                end
            end
        end  
        R.('Cancer') = varargin{n}.('Cancer');


    end
end


