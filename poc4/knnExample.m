corpus = aghCorpus;
corpusLength = length(corpus);
features = zeros(corpusLength, 7);
classes = cell(corpusLength,1);
for j = 1:corpusLength
    features(j, 1) = corpus{j}.features('mfcc1').statistics.range;
    features(j, 2) = corpus{j}.features('formant2').statistics.mean;
    features(j, 3) = corpus{j}.features('mfcc6').statistics.minimum;
    features(j, 4) = corpus{j}.features('fundamentalFrequency').statistics.range;
    features(j, 5) = corpus{j}.features('mfcc7').statistics.minimum;
    features(j, 6) = corpus{j}.features('mfcc6').statistics.kurtosis;
    features(j, 7) = corpus{j}.features('formant2').statistics.range;
    
    classes{j} = corpus{j}.emotion;
end
%% split data
trainRatio = .9;
valRatio = .0;
testRatio = .1;
bestRate = .3;
[trainInd,valInd,testInd] = dividerand(corpusLength,trainRatio,valRatio,testRatio);
knn=classification.Knn(features(trainInd,:),classes(trainInd));
%% verify
verification = zeros(size(testInd));
for j = 1:length(verification)
    l = knn.predict(features(testInd(j)));
    verification(j) = strcmp(l, classes(testInd(j)));
end
rate = sum(verification)/length(verification)

