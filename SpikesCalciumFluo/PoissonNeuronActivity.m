function [ data ] = PoissonNeuronActivity( nbNeurons, firingRate, ...
                                                totalTime, parameters )
% Simulate the activity (spikes, calcium, and fluorencence) of independent 
% Poissonian neurons.
%
% INPUT:
%   nbNeurons       positive integer
%                   the number of neurons that will be simulated
%   firingRate      positive real
%                   the firing rate of the neurons in Hz, i.e., the expected
%                   number of spikes per second
%   totalTime       positive real
%                   time upper bound; the time will run from 0 to totalTime
%   parameters      structure array that describes the optional parameters
%               
% OUTPUT:
%   data            structure array that contains the simulation results
%                   the fields are:
%                       time        1 x N mat, where N = nb of time steps
%                                   time(j) = value of time (in seconds)
%                                   at step j                                        
%                       spikes      P x N mat, where P = nb of neurons
%                                   spikes(i,j) = nb of spikes emitted by
%                                   neuron i at time step j
%                       calcium     P x N mat, where P = nb of neurons
%                                   calium(i,j) = normalized concentration                                 
%                                   of calcium in neuron i at time step j
%                       fluo        P x N mat, where P = nb of neurons
%                                   fluo(i,j) = normalized fluorescence                                 
%                                   created by neuron i at time step j
%                       
%% Check inputs
    if nargin<4
        parameters = struct;
    end
    % Time step size
    if ~isfield(parameters,'timeStep')
        parameters.timeStep = 0.001;   % 1ms time step
    end
     % Baseline
    if ~isfield(parameters,'baseline')
        parameters.baseline = @(time) 0.5.*cos(0.1.*time); % default baseline 
    end
    % Growth rate alpha after a spike
    if ~isfield(parameters,'growthRate')
        parameters.growthRate = 32; 
    end
    % Decrease rate beta after a spike
    if ~isfield(parameters,'decreaseRate')
        parameters.decreaseRate = 8;
    end
    % Signal-to-noise ratio
    if ~isfield(parameters,'SNR')
        parameters.SNR = 10;
    end
    
%% Generate Poissonian spikes
   data = PoissonSpikes(nbNeurons, firingRate, totalTime, parameters);
                                            
%% Transform spikes into calcium 
   data.calcium = fromSpikesToCalcium(data.time, data.spikingTimes, ...
                                                            parameters);
%% Transform calcium into fluorescence
   data.fluo = fromCalciumToFluo(data.time, data.calcium, parameters );
   
end