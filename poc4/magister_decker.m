clear all

addpath ./lib/voicebox/
%% Params
% filename = 'korpus/RA/JMI_RA_C.wav';
filename = 'korpus/RA/AKA_RA_C.wav';

frameLength = 400;

%% Preemphasis
[y,fs] = audioread(filename);
preemphasisFilter = @(x)(filter( [1 -.97], 1, x ));
filtered = preemphasisFilter(y);
%% Split to frames
frames = enframe(y, frameLength);
h = hamming(frameLength);
% hamminged = frames * h';
hamminged= frames .* h.';

%% extract features
framesNumber = size(hamminged,1);
segmentalFeatures = ObjectArray(framesNumber);
r = zeros(framesNumber,1);
for j = 1:framesNumber
frame = hamminged(j,:);

segmentalFeatures(j).Value = features.Features(frame, fs);
r(j)=segmentalFeatures(j).Value.fundamentalFrequency;
end
%  features.fundamentalFrequency
% [lp,g] = lpc(frame,10);
%sound(frames(1,:),Fs)
q = (1:framesNumber)*frameLength/fs;
% plot(q,r);
mode(r), mean(r)
