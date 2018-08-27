% requires spectrumData from scriptCompileSpectra

averageContentLost = zeros(100,1);
spectralContent = cumsum(spectrumData{101}.spectra(:,1:5000),2);
spectralContent = spectralContent./max(spectralContent,[],2);
freq = spectrumData{101}.freq(1:5000);

%% Getting lost spectral content

for i = 1:100
    maxAllowed = max(find(freq <= i/2));
    contentLost = zeros(1000,1);
    for j = 1:1000
        contentLost(j) = 1 - spectralContent(j,maxAllowed);
    end
    averageContentLost(i) = mean(contentLost);
end

%% Cleaning workspace
clear i j maxAllowed freq spectralContent contentLost