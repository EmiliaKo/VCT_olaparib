function Cancer = update_cancer(system,parameters)
%% -- update cancer cells
% INPUTS - system - current systems as struct
%          parameters -  struct with the model parameters
% OUTPUT - updated cancer cells composition
%% --
    CancerCells_global = containers.Map('KeyType','char','ValueType','double');  
    for subclone = keys(system.Cancer) % iterate over subclones
        subclone_name = sscanf(char(subclone),'%f,%f');  
        propensities = event_propensity(subclone_name,parameters);
        event = sample_hist(propensities',system.Cancer(char(subclone)));
        amount =  system.Cancer(char(subclone)) + event(1) - event(2);
        check= isKey(CancerCells_global, subclone);
        if check == 1
            CancerCells_global(char(subclone)) = CancerCells_global(char(subclone))+amount;
        else 
            CancerCells_global(char(subclone)) = amount;
        end
        % perform asymmetric division
        event_asymmetric = event(3:end);
        for resistance_idx = 1:numel(event_asymmetric) % for each type of mutation
            if event_asymmetric(resistance_idx) > 0 
                new_subclone = mutate_subclone(subclone_name, resistance_idx);     
                key = sprintf('%d,%d',new_subclone(1),new_subclone(2));
                if isKey(CancerCells_global, key) == 0 
                    CancerCells_global(key) = event_asymmetric(resistance_idx);
                else  % if new subclone is  already in the system
                    CancerCells_global(key) = CancerCells_global(key) + event_asymmetric(resistance_idx);
                end
                % we need to increase also the number of cells of the subclone!
                CancerCells_global(char(subclone)) = CancerCells_global(char(subclone)) + event_asymmetric(resistance_idx); 
            end
        end

    end


    Cancer = CancerCells_global;
end