function [data_Placebo, data_Olaparib] = getData(Olaparib_file, Placebo_file)
%% --  extract survival data from input files
% INPUTS - Olaparib_file - file name with Olaparib arm
%        - Placebo_file - file name with Placebo arm
% OUTPUT - data_Placebo - survival data for Placebo arm
%        - data_Olaparib - survival data for Olaparib arm
%% --

    data_Placebo = csvread( Placebo_file,1,0 );
    data_Olaparib = csvread( Olaparib_file,1,0 );
end