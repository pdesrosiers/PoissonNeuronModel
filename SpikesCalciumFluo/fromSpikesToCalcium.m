function [ calcium ] = fromSpikesToCalcium( time, spikingTimes, parameters)

%   Set Parameters
    nbNeurons = numel(spikingTimes);
    nbTimeSteps = numel(time);
    calcium = zeros(nbNeurons, nbTimeSteps);

%   Generate a calcium trace for each neuron
    for neuron = 1:nbNeurons
        calcium(neuron,:) = singleNeuronCalciumActivity(time, ...
                                       spikingTimes{neuron}, parameters);
    end
    
%   Normalize the calcium concentration
    maxCalcium = max(calcium(:));
    if maxCalcium ~= 0
        calcium = calcium./maxCalcium;
    end
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