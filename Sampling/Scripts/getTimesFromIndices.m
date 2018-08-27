function occurenceTimes = getTimesFromIndices(indices, time)

    occurenceTimes = zeros(1,length(indices));
    for i = 1:length(indices)
        occurenceTimes(i) = time(indices(i));
    end

end

