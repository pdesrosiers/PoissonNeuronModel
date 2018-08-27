% Requires peaksData from scriptCompilePeaks

%% Getting displacements
% NOTE TO SELF
% idx = knnsearch(X',Y','K',1)
% où X est vecteur colonne de référence
%    Y est vecteur colonne sampled
meanDisplacements = zeros(101,1);

for i = 1:101   % 1 to 100 Hz
    meanDisplacementsOfSeries = zeros(1000,1);
   for j = 1:1000   % 1 to 1000 Series
      referenceTimes = peaksData{101}.times{j};
      sampledTimes = peaksData{i}.times{j};
      nnIdx = knnsearch(referenceTimes', sampledTimes','K',1);
      differences = abs(sampledTimes - referenceTimes(nnIdx'));
      meanDisplacementsOfSeries(j) = mean(differences);
   end
   meanDisplacements(i) = mean(meanDisplacementsOfSeries);
   fprintf('%d\n',i);
end

%% Cleaning workspace
clear i j meanDisplacementsOfSeries referenceTimes sampledTimes nnIdx differences