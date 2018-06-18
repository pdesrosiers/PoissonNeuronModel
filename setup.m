fprintf('\nPREPARATION: ADDING PATHS TO MATLAB\n\n');

root = fileparts(mfilename('fullpath'));
addpath(genpath(root));
savepath;                          


