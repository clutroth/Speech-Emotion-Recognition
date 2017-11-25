# jak najszybciej wyznaczyć wektory cech MFCC  energii
from os import listdir
from os.path import isfile, join

auio_path = '/home/wdk/uczelnia/mgr/aplikacja_py/audio_sample/'
filenames = [f for f in listdir(auio_path) if isfile(join(auio_path, f))]

import scipy.io.wavfile as wav
import numpy as np
import speechpy

fs, signal = wav.read(join(auio_path, filenames[1]))

############# Extract MFCC features #############
mfcc = speechpy.mfcc(signal, sampling_frequency=fs, frame_length=0.020, frame_stride=0.01,
             num_filters=40, fft_length=512, low_frequency=0, high_frequency=None)
mfcc_feature_cube = speechpy.extract_derivative_feature(mfcc)
print('mfcc feature cube shape=', mfcc_feature_cube.shape)

############# Extract logenergy features #############
logenergy = speechpy.lmfe(signal, sampling_frequency=fs, frame_length=0.020, frame_stride=0.01,
             num_filters=40, fft_length=512, low_frequency=0, high_frequency=None)
logenergy_feature_cube = speechpy.extract_derivative_feature(logenergy)
print('logenergy features=', logenergy.shape)