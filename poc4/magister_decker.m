clear all
%% Params
filename = 'korpus/RA/AKA_RA_C.wav';
frameLength = 512;

%% Split to frames
[y,Fs] = audioread(filename);
totalSamplesNumber = size(y,1);
framesNumber = ceil(totalSamplesNumber / frameLength);
frames = zeros(framesNumber, frameLength,1);
h = hamming(frameLength);
for n = 1:framesNumber
    from = (n-1)*frameLength;
    to = min(n*frameLength, totalSamplesNumber-1);
    frames(n,1:to-from) = y(from+1:to,:);
    frames(n,:) = frames(n,:);
end
%% extract features
[lp,g] = lpc(frames(1,:),10)
%sound(frames(1,:),Fs)