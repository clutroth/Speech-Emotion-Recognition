clear all

addpath ./lib/voicebox/
%% Params
filename = 'korpus/RA/JMI_RA_C.wav';
% filename = 'korpus/RA/AKA_RA_C.wav';

frameLength = 200;

%% Preemphasis

[y,fs] = audioread(filename);
preemphasisFilter = @(x)(filter( [1 -.97], 1, x ));
filtered = preemphasisFilter(y);
%% Split to frames

frames = enframe(y, frameLength);
h = hamming(frameLength);
hamminged= frames .* h.';

%% Extract features

framesNumber = size(hamminged,1);
segmentalFeatures = ObjectArray(framesNumber);
r = zeros(framesNumber,1);
suprasegmentalFeatures = features.SuprasegmentalFeatures(y, fs);
for j = 1:framesNumber
    frame = hamminged(j,:);
    segmentalFeatures(j).Value = features.SegmentalFeatures(frame, fs);
end

%% Map features 

data = createFeatureData(features.DataFeatures(framesNumber),...
    segmentalFeatures,...
    suprasegmentalFeatures);

%% Plot features
stats = stat.StatisticMap(data);
t = (1:framesNumber) * frameLength / fs;
t=t.';
plot(t, zscore(data.energy),...
    t, zscore(data.fundamentalFrequency),...
    t, zscore(data.formant1),...
    t, zscore(data.formant2),...
    t, zscore(data.formant3),...
    t, zscore(data.formant4),...
    t, zscore(data.mfcc1),...
    t, zscore(data.mfcc2),...
    t, zscore(data.mfcc3),...
    t, zscore(data.mfcc4),...
    t, zscore(data.mfcc5),...
    t, zscore(data.mfcc6),...
    t, zscore(data.mfcc7));

legend('energy', 'fundamental frequency', ...
    'formant1', 'formant2', 'formant3', 'formant4', ...
    'mfcc1', 'mfcc2', 'mfcc3', 'mfcc4', 'mfcc5', 'mfcc6', 'mfcc7');