function [ fluo ] = fromCalciumToFluo( time, calcium, parameters)
% Add noise and baseline to a calcium time series
    fluo = calcium;
    fluo = fluo + whiteNoise(fluo, parameters.SNR); 
    fluo = fluo + baseline(time, parameters.baseline);
% Normalize fluo
    maxFluo = max(fluo(:));
    if maxFluo ~= 0
        fluo = fluo./maxFluo;
    end
end


function timeSeries = whiteNoise(signal, SNR) 
% INPUT:    signal = vector
%           SNR = Signal-to-noise ratio  = variance(signal)/variance(noise)
% OUTPUT:   timesSeries = vector as signal that gives the value of noise at
%                         each time step

    sigma = std(signal(:));
    timeSeries = sigma./sqrt(SNR).*randn(size(signal));
end

function timeSeries = baseline(timeSequence, baselineFunc)
% INPUT:    timeSequence = vector that contains all the time values
%           baselineFunc = function that takes a vector and returns a vector
%           of the same size
% OUTPUT:   timeSeries = vector of the size 
    timeSeries = baselineFunc(timeSequence);
end