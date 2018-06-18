function [timeSeries, timeValues, timeEdges] = ...
                  getPoissonTimeSeries( maxTime, timeStep, occurrenceTimes)
%   Build time series from the occurrence times of events in Poisson
%   processes.  Each series correcponds to one Poisson process.
%
%   INPUT: 
%       maxTime         positive real (default 1)
%                       the upper bound (in unit time) of the time interval
%       timeStep        positive real less than totalTime (default 0.01)
%                       the size (in unit time) of each time step
%       occurrenceTimes cell array
%                       occurrenceTimes{i}(j) is the occurrence
%                       time of event j in process i
%   OUPUT: 
%       timeSeries      P x N matrix, where P = nb of processes, N = nb of 
%                       time steps in each series
%                       timeSeries(i,j) is the nb of events of process i 
%                       at time step j 
%       timeValues      1 x N matrix, where N = nb of time steps
%                       timeValues(j) is the mid-time in time step j
%       timeEdges       1 x (N+1) matrix, where N = nb of time steps
%                       timeSequence(j) is the time at which ends time step
%                       j-1 and at which begins time step j.
%
%%
    timeEdges = 0 : timeStep : maxTime ;
    timeValues = timeEdges(1:end-1) + timeStep/2;
    nbProcesses = size(occurrenceTimes,1);
    timeSeries = zeros(nbProcesses,length(timeEdges)-1);
    for processID = 1:nbProcesses
        timeSeries(processID,:) = histcounts(occurrenceTimes{processID},...
                                                            timeEdges);
    end
end

