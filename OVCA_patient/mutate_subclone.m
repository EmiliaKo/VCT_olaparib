function new_subclone = mutate_subclone(subclone_name, resistance_idx)
%% -- mutate cancer cell
% INPUTS - subclone_name - name of a subclone that mutate to a new one
%          resistance_idx - index of type of mutation
% OUTPUT - name of a new subclone
%% --
    new_subclone = subclone_name;
    switch resistance_idx
        case 1 % resistance to pt-chemotherapy
            new_subclone(1) = new_subclone(1)+1;
        case 2 % resistance to olaparib
            new_subclone(2) = new_subclone(2)+1;
        case 3 % reversion-mutation
            new_subclone(1) = new_subclone(1)+1; 
            new_subclone(2) = 250;
        case 4 % cross-resistance
            new_subclone = new_subclone+1;
        otherwise % throw error
            error('unknown mutation type!')
    end
end