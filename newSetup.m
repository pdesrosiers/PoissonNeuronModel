% Script for adding paths and checking function duplicates.
%
% Antoine Légaré & Patrick Desrosiers
% Created 2018-08-14 / Modified 2018-08-15
% DCC Lab

%% Adding paths to matlab

root = fileparts(mfilename('fullpath'));
addpath(genpath(root));
savepath;
fprintf('Paths added to Matlab.\n')

%% Getting all file names in current folder and below

fileNames = getFileNames(pwd);

%% Compiling duplicate fonctions

[~, ia, ~] = unique(fileNames);
duplicatedNames = cell(0);

for i = 1:length(fileNames)
    if ~ismember(i,ia)
        duplicatedNames{end+1} = fileNames{i};
    end
end

%% Announcing duplicate functions, if any

if ~isempty(duplicatedNames)
    duplicatedNames = unique(duplicatedNames);
    fprintf('--------------------------------------------\n')
    fprintf('WARNING : THE FOLLOWING FILES ARE DUPLICATED\n\n')
    for name = duplicatedNames
        disp(name)
    end
    disp('--------------------------------------------')
end

%% Clearing variables

clear fileNames duplicatedNames i ia  name

%% Defining local function

function fileNames = getFileNames(upPath)
% Recursive function which collects all the file names in a single folder,
% and calls itself into each subfolder. Returns a cell array of file names.

    folderInfo = dir(upPath);
    fileNames = cell(0);
    
    for i = 1:length(folderInfo)
        if ~any(strcmp(folderInfo(i).name,{'.','..','.git','.DS_Store',...
                'readme.txt','readme.md','example.m'}))
                if folderInfo(i).isdir == false
                    fileNames(end+1) = {folderInfo(i).name};
                else
                    downPath = strcat(upPath,'\',folderInfo(i).name);
                    downFileNames = getFileNames(downPath);
                    fileNames(end+1:end+length(downFileNames)) = downFileNames;
                end
        end
    end
end