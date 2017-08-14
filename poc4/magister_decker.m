clear all

addpath ./lib/voicebox/
%% Params
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
%% extract features
hamminged=h' .* frames;
frame = hamminged(1,:);

features = features.Features(frame, fs);

[lp,g] = lpc(frame,10);
%sound(frames(1,:),Fs)