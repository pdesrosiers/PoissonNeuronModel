function [ data ] = PoissonSpikes( nbNeurons, firingRate, ...
                                                    totalTime, options )
% Simulate the random emission of spikes.

% INPUT:
%   nbNeurons       positive integer
%                   the number of neurons that will be simulated
%   firingRate      positive real
%                   the firing rate of the neurons in Hz, i.e., the expected
%                   number of spikes per second
%   totalTime       positive real
%                   time upper bound; the time will run from 0 to totalTime
%   options         structure array that describes the optional parameters
%                   the fields are described below
%               
% OUTPUT:
%   data            structure array with fields:
%                   time    1 x N mat, where N = nb of time steps
%                           time(j) = value of time (in seconds) at step j                                                                          
%                   spikes  P x N mat, where P = nb of neurons
%                           spikes(i,j) = nb of spikes emitted by neuron i 
%                           at time step j                                 
%% Check inputs
    if nargin<4
        options = struct;
    end
    if ~isfield(options,'timeStep')
        options.timeStep = 0.001;   % 1ms time step
    end
%% Simulate spikes with a Poison point processes
   PoissonData = simulatePoissonProcess(firingRate, totalTime, ...
                                              options.timeStep, nbNeurons);
%% Save ouputs
   data.spikes = PoissonData.timeSeries;
   data.time = PoissonData.timeValues;
   data.spikingTimes = PoissonData.occurrenceTimes;
end

