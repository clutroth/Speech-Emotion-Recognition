function [] = przetwarzanie()
addpath ./lib/voicebox/
files = ['korpus_maly/PKE_ST_P.wav'
    'korpus_maly/PJU_SM_Z.wav'
    'korpus_maly/AKA_ST_C.wav'
    'korpus_maly/MPO_IR_C.wav'
    'korpus_maly/MMA_ZD_T.wav'
    'korpus_maly/HKR_NE_T.wav'
    'korpus_maly/PKE_RA_Z.wav'
    'korpus_maly/MMA_ST_T.wav'
    'korpus_maly/MPO_RA_P.wav'
    'korpus_maly/MGR_SM_Z.wav'];

% for j = 1:size(files, 1)
%     file = preprocess.File(files(1,:));
%     s = preprocess.fileToSignal(file);
%     preprocess.stage(s);
% end
sample = files(2,:);
f=preprocess.File(sample);
s = preprocess.fileToSignal(f);
s = preprocess.stage(s);
feature_extraction.split(s, 500);
%sound(preprocess.stage(s).data,s.fs)
end