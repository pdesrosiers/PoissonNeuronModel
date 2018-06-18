function [ lambda] = ...
       inferPoissonProcessFromOccurrenceIntervals( occurrenceIntervals)
%   Infer the rate lambda of a Poisson process from multiple instances                                                             
%% Fit an exponential distribution on the empirical occurrence intervals
    allIntervals = [occurrenceIntervals{:}]';
    maxInterval = max(allIntervals(:));
    probDensity = fitdist(allIntervals,'Exponential');
    lambda = 1/probDensity.mu ;
    intervalsList = 0:maxInterval/100:maxInterval;
    inferedDensity = pdf(probDensity,intervalsList);
    
%% Display results 
    figure()
    histogram(allIntervals(:),'normalization', 'pdf');
    hold on;
    plot(intervalsList,inferedDensity, 'LineWidth',3);
    xlabel('Occurrence interval');
    ylabel('Probability density');
    legend({'Empirical density','Infered Exponential density'})
    
    disp(['The infered rate lambda is ', num2str(lambda)]);
end

