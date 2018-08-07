function [occurrenceTimes,occurrenceIntervals,nbEvents] =...
                                getPoissonOccurenceTimes( rate, nbProcesses, totalTime )
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
    occurrenceTimes = cell(nbProcesses,1);
    occurrenceIntervals = cell(nbProcesses,1);
    nbEvents = zeros(nbProcesses,1);
    for processID = 1:nbProcesses
        occurrenceIntervals{processID} = exprnd(1/rate);
        occurrenceTimes{processID} = cumsum(occurrenceIntervals{processID});
        while occurrenceTimes{processID}(end) < totalTime
            occurrenceIntervals{processID} = [occurrenceIntervals{processID},...
                exprnd(1/rate)];
            occurrenceTimes{processID} = cumsum(occurrenceIntervals{processID});
        end
        if occurrenceTimes{processID}(end) > totalTime
            occurrenceTimes{processID}(end) = [];
            occurrenceIntervals{processID}(end) = [];
        end
        nbEvents(processID) = length(occurrenceTimes{processID});
    end
end

