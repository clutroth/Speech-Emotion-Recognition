clear all
fs = 44100; % Hz
t = 0:1/fs:5; % seconds
f = 440; % Hz

x = sin(2.*pi.*f.*t).';
dt = 1/fs;
c = cceps(x);
t = 0:dt:length(x)*dt-dt;

trng = t(t>=2e-3 & t<=10e-3);
crng = c(t>=2e-3 & t<=10e-3);

[~,I] = max(crng);
f=1/trng(I);

fprintf('Complex cepstrum F0 estimate is %3.2f Hz.\n',f)

% sound(x,fs,16);
