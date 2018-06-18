function [ vectorWithRepeatedValues ] = ...
                                    vectorsToMultiset( values, occurrences)
% Build a multiset from two vectors of the same length, the 1st vector is 
% the set of possible values and the second vector gives the number of times 
% each value must be repeated.
%    
% Example: vectorsToMultiset([1,2,3],[4,0,1]) returns [1,1,1,1,3];

%% Check inputs
    if length(values)~=length(occurrences)
        error('The two arguments must be vectors of the same length')
    end
%% Set global parameter
    nbValues = length(values);
    sizeMultiset = sum(occurrences);   
%% Build multiset
    vectorWithRepeatedValues = zeros(1,sizeMultiset);
    multisetID = 1;
    for valueID = 1:nbValues
        if occurrences(valueID)>0
            multisetIDs = multisetID : multisetID+occurrences(valueID)-1;
            vectorWithRepeatedValues(multisetIDs) = values(valueID);
            multisetID = multisetID+occurrences(valueID);
        end
    end  
end

