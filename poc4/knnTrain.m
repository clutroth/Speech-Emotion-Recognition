%% prepare data
corpus = aghCorpus;
corpusLength = length(corpus);
featureNames = corpus{1}.features.keys();
statisticNames = properties(corpus{1}.features(featureNames{1}).statistics);
features = zeros(corpusLength, length(featureNames) * length(statisticNames));
classes = cell(corpusLength,1);
for j = 1:corpusLength
    for k = 1:length(featureNames)
        for l = 1:length(statisticNames)
            featureIndex = (k-1) * length(statisticNames) + l;
            features(j, featureIndex) = corpus{j}.features(featureNames{k}).statistics.get(statisticNames{l});
        end
    end
    classes{j} = corpus{j}.emotion;
end
%% feature names
measurementNames = cell(1, length(featureNames) * length(statisticNames));
for k = 1:length(featureNames)
    for l = 1:length(statisticNames)
        featureIndex = (k-1) * length(statisticNames) + l;
        measurementNames{featureIndex} = strcat(featureNames{k},'_',statisticNames{l});
    end
end

%% split data
trainRatio = .9;
valRatio = .0;
testRatio = .1;
bestRate = .3;
while(bestRate < 0.9)
    [trainInd,valInd,testInd] = dividerand(corpusLength,trainRatio,valRatio,testRatio);
    selectedFeatures = datasample(1:length(measurementNames), 7);
    selectedMeasurmentNames = measurementNames(selectedFeatures);
    knn=classification.Knn(features(trainInd,selectedFeatures),classes(trainInd));
    %% verify
    verification = zeros(size(testInd));
    for j = 1:length(verification)
        l = knn.predict(features(testInd(j)));
        verification(j) = strcmp(l, classes(testInd(j)));
    end
    rate = sum(verification)/length(verification);
    if(rate > bestRate)
        bestRate,selectedMeasurmentNames,
        save(strcat('working_dir/knn_features_', num2str(rate),'-', datestr(datetime),'.mat'),'selectedMeasurmentNames', 'rate');
        bestRate = rate;
    end
end
