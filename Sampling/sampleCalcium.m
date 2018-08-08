function sampleData = sampleCalcium( samplingRate, spikingTimes, parameters)

%   Set Parameters
    nbNeurons = numel(spikingTimes);
    nbTimeSteps = samplingRate*parameters.totalTime;
    samples = zeros(nbNeurons, nbTimeSteps);
    time = (0:nbTimeSteps-1)/samplingRate;
    
%   Generate a calcium trace for each neuron
    for neuron = 1:nbNeurons
        samples(neuron,:) = singleNeuronCalciumActivity(time, ...
                                       spikingTimes{neuron}, parameters);
    end
    
    sampleData.time = time;
    sampleData.samples = samples;
end


function [ calcium ] = singleNeuronCalciumActivity(time, spikingTimes, ...
                                                                parameters)                                                           
 %  Remark: Symbols are used to ease the reading of the formula below                                                           
 %  Get parameters                                                           
    alpha = parameters.growthRate;
    beta = parameters.decreaseRate;
    T = length(time);
    N = length(spikingTimes);
    
 %  Build a time matrix of size N x T
    t  = repmat(time, N,1);
    t = t - repmat(spikingTimes', 1, T);
    t(t < 0) = -1; % Prevents -Inf in the next step for long durations
    
 %  Build a calcium matrix of size N x T
    calcium =  (1-exp(-alpha.*t)).*exp(-beta.*t).*heaviside(t);
    
 %  Build trace of size 1 x T
    calcium =  sum(calcium, 1);
end
