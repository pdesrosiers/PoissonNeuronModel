% Requires parameters from scriptGenerateParameters

%% Generating spike times for 1000 processes
[occurrenceTimes, ~, ~] = getPoissonOccurenceTimes(parameters.firingRate,...
                        parameters.numberOfSeries, parameters.totalTime );

%% Collecting samples from 1 to 100 Hz, plus reference samples at 1000 Hz
samplingData = cell(101,1);
for i = 1:100
samplingData{i} = sampleCalcium(i, occurrenceTimes, parameters);
fprintf('%d\n',i);
end
samplingData{101} = sampleCalcium(1000, occurrenceTimes, parameters);

%% Displaying samples
figure(1)
for i = 10:20
plot(samplingData{i}.time,samplingData{i}.samples(1,:))
hold on
end
plot(samplingData{101}.time,samplingData{101}.samples(1,:))
hold off
xlabel('Time (s)')
ylabel('Fluorescence')
title('Sampling From 10 Hz to 20 Hz')

%% Cleaning workspace
clear firingRate i