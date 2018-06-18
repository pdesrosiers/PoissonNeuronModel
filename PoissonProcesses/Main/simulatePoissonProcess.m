function [dataStruct] = simulatePoissonProcess(rate, ...
                                            maxTime, timeStep, nbProcesses)
% Simulate Poisson processes of a given rate
%
% INPUT:
%
%   rate            postive real (default 10)
%                   the expected number of events per unit time
%   maxTime         positive real (default 1)
%                   the upper bound (in unit time) of the time interval
%   timeStep        positive real less than totalTime (default 0.1)
%                   the size (in unit time) of each time step
%   nbProcesses     positive integers (default 1)
%                   the number P of Poisson processes simulated
%
% OUTPUT:
%
%   dataStruct      structure array with fields:
%                   timeSeries  PxN matrix, where N = nb of time steps
%                               timeSeries(i,j) is the nb of events of 
%                               process i at time step j                              
%                   nbEvents    Px1 matrix
%                               nbEvents(j) = nb of events that occured
%                               in process j
%                   occurrenceTimes     cell array
%                                       occurrenceTimes{i}(j) is the occurrence
%                                       time of event j in process i
%                   occurrenceIntervals cell array
%                                       occurrenceIntervals{i}(j) is the
%                                       time between events j and j-1 in process i
%                   timeValues  1 x N matrix, where N = nb of time steps
%                               timeValues(j) is the mid-time in time step j
%                   timeEdges   1 x (N+1) matrix, where N = nb of time steps
%                               timeSequence(j) is the time at which ends time step
%                               j-1 and at which begins time step j.
%%  Check inputs
    if nargin<1
        rate = 10;
    elseif isempty(rate)
        rate = 10;
    end
    if nargin<2
        maxTime = 1;
    elseif isempty(maxTime)
        maxTime = 1;
    end
    if nargin<3
        timeStep = 0.1;
    elseif isempty(timeStep)
        timeStep = 0.1;
    end
    if nargin<4
        nbProcesses = 1;
    elseif isempty(nbProcesses)
        nbProcesses = 1;
    end
    
%%  Generate a random number of events per procces
%   The number of events per process is a Poisson random variable of
%   parameter lambda = rate*maxTime.
    nbEvents = poissrnd( rate*maxTime, [nbProcesses,1] );

%%  Randomly select the occurence times
%   The time between consecutive events is an exponential random variable
%   of mean mu = 1/rate
    [occurrenceTimes,occurrenceIntervals] = ...
                                getPoissonOccurenceTimes( rate, nbEvents );
    
%% Generate time series
    [timeSeries, timeValues, timeEdges] = getPoissonTimeSeries( maxTime,...
                                                timeStep, occurrenceTimes);
%% Save results in a struct
    dataStruct = struct;
    dataStruct.nbEvents =nbEvents;
    dataStruct.timeSeries = timeSeries;
    dataStruct.timeValues = timeValues;
    dataStruct.timeEdges = timeEdges;
    dataStruct.occurrenceTimes = occurrenceTimes;
    dataStruct.occurrenceIntervals = occurrenceIntervals;
    
end

