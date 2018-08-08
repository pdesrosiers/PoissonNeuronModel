function [occurrenceTimes,occurrenceIntervals,nbEvents] =...
                                getPoissonOccurenceTimes( rate, nbProcesses, totalTime )
%   Randomly select a time for each event that occurred in Poisson  
%   processes of a given rate.
%
%   INPUT: 
%       rate         positive real - corresponds to the expected number of 
%                    events per unit time in a Poisson process                   
%       nbProcesses  positive integer - the number of Poisson processes to
%                    be generated
%       totalTime    positive real - the time length of the time series
%
%   OUPUT: 
%       occurrenceTimes     cell array
%                           occurrenceTimes{i}(j) is the occurrence
%                           time of event j in process i
%       occurrenceIntervals cell array
%                           occurrenceIntervals{i}(j) is the
%                           time between events j and j-1 in process i
%       nbEvents            Nx1 matrix containing the number of events in
%                           each time series
%
%  REMARK: 
%       In a Poisson process of rate lambda, the time between consecutive 
%       events is an exponential random variable of mean mu = 1/lambda.
%
%% Generating output variables
    occurrenceTimes = cell(nbProcesses,1);
    occurrenceIntervals = cell(nbProcesses,1);
    nbEvents = zeros(nbProcesses,1);

%% Generating spike times with exprnd
    for processID = 1:nbProcesses
        % First event for a given process
        occurrenceIntervals{processID} = exprnd(1/rate);
        occurrenceTimes{processID} = cumsum(occurrenceIntervals{processID});
        % Generates events until total time is reached
        while occurrenceTimes{processID}(end) < totalTime
            occurrenceIntervals{processID} = [occurrenceIntervals{processID},...
                exprnd(1/rate)];
            occurrenceTimes{processID} = cumsum(occurrenceIntervals{processID});
        end
        % Verifies the last time value doesn't exceed total time
        if occurrenceTimes{processID}(end) > totalTime
            occurrenceTimes{processID}(end) = [];
            occurrenceIntervals{processID}(end) = [];
        end
        nbEvents(processID) = length(occurrenceTimes{processID});
    end
end

