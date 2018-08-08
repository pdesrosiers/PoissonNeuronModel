%% Assigning necessary parameters
parameters.growthRate = 32;
parameters.decreaseRate = 8;
parameters.totalTime = 10;

%% Generating spike times for 1000 processes
[occurrenceTimes, ~, ~] =...
                                getPoissonOccurenceTimes( 1, 1000, 10 );

%% Collecting samples from 1 to 100 Hz
samplingData = cell(100,1);
for i = 1:100
samplingData{i} = sampleCalcium(i, occurrenceTimes, parameters);
end

%% Displaying samples
for i = 1:10
plot(samplingData{i}.time,samplingData{i}.samples(1,:))
hold on
end