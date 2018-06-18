function [lambda] = inferPoissonProcessFromNbEvents( nbEvents, maxTime)
%   Infer the rate lambda of a Poisson process from multiple instances 
%
%%  Fit a Poisson distribution on the empirical distribution of the number of events
    probDensity = fitdist(nbEvents(:),'Poisson');
    lambda = probDensity.lambda/maxTime;
    nbEventsList = min(nbEvents(:)):1:max(nbEvents(:));
    inferedDensity = pdf(probDensity,nbEventsList);
    
%% Display results
    figure()
    histogram(nbEvents,'normalization', 'pdf');
    hold on;
    plot(nbEventsList,inferedDensity, 'LineWidth',3);
    xlabel('Number of events');
    ylabel('Probability density');
    legend({'Empirical density','Infered Poisson density'})
    
    disp(['The infered rate lambda is ', num2str(lambda)]);
    
end

