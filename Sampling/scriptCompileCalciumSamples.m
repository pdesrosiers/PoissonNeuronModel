%% Assigning necessary parameters
parameters.growthRate = 32;
parameters.decreaseRate = 8;
parameters.totalTime = 10;

%% Generating spike times for 1000 processes
[occurrenceTimes, ~, ~] = getPoissonOccurenceTimes( 1, 1000, 10 );

%% Collecting samples from 1 to 100 Hz, plus reference samples at 1000 Hz
samplingData = cell(101,1);
for i = 1:100
samplingData{i} = sampleCalcium(i, occurrenceTimes, parameters);
end
samplingData{101} = sampleCalcium(1000, occurrenceTimes, parameters);

%% Displaying samples
for i = 10:100
plot(samplingData{i}.time,samplingData{i}.samples(1,:))
hold on
end