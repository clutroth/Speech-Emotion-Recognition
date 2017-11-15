function [] = przetwarzanie()
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
    function dat = preprocess(signal)
        dat = zscore(signal);
    end
for j = 1:size(files, 1)
    file = preprocess.File(files(1,:));
    preprocess(file.signal);
end
sample = 'korpus_maly/PJU_SM_Z.wav';
f=preprocess.File(sample);
preprocess(f.signal);
sound(preprocess(f.signal),f.fs)
end