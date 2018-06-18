function [occurrenceTimes,occurrenceIntervals] =...
                                getPoissonOccurenceTimes( rate, nbEvents )
%   Randomly select a time for each event that occurred in Poisson  
%   processes of a given rate.
%
%   INPUT: 
%       rate        positive real
%                   corresponds to the expected number of events per unit 
%                   time in a Poisson process
%       nbEvents    vector of size Px1 of non-negative integers
%                   nbEvents(i) is the number of events that occurred in
%                   process i
%   OUPUT: 
%       occurrenceTimes     cell array
%                           occurrenceTimes{i}(j) is the occurrence
%                           time of event j in process i
%       occurrenceIntervals cell array
%                           occurrenceIntervals{i}(j) is the
%                           time between events j and j-1 in process i
%  REMARK: 
%       In a Poisson process of rate lambda, the time between consecutive 
%       events is an exponential random variable of mean mu = 1/lambda.
%%
    nbProcesses = length(nbEvents);
    occurrenceTimes = cell(nbProcesses,1);
    occurrenceIntervals = cell(nbProcesses,1);
    for processID = 1:nbProcesses
        occurrenceIntervals{processID} = exprnd(1/rate,1,nbEvents(processID));
        occurrenceTimes{processID} = cumsum(occurrenceIntervals{processID});
    end
end

