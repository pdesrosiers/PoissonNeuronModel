% Requires peaksData from scriptCompilePeaks

timeIntervals = cell(100,1);
ksDistance = zeros(100,1);
%% Getting reference intervals
refIntervals = [];
for j = 1:1000
    refIntervals = [refIntervals diff(occurrenceTimes{j})];
end

%% Getting sampled intervals and Kolmogorov distance
for i = 1:100
    ints = [];
    for j = 1:1000
        ints = [ints diff(peaksData{i}.times{j})];
    end
    timeIntervals{i} = ints;
    [~, ~, ksDistance(i)] = kstest2(ints, refIntervals);
end

%% Cleaning workspace
clear i j ints refIntervals