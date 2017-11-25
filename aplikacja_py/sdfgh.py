import matplotlib.pyplot as plt
import numpy as np
from pydub import AudioSegment
from pydub.utils import make_chunks

from base_features import freq_from_autocorr

from python_speech_features import mfcc
from python_speech_features import delta
from python_speech_features import logfbank

filename1 = "AKA_NE_Z.wav"
filename2 = "JMI_IR_T.wav"

myaudio = AudioSegment.from_file(filename2 , "wav")
chunk_length_ms = 1000 # pydub calculates in millisec
chunks = make_chunks(myaudio, chunk_length_ms) #Make chunks of one sec

#Convert chunks to raw audio data which you can then feed to HTTP stream
for i, chunk in enumerate(chunks):
    raw_audio_data = chunk.raw_data


signal = np.fromstring(myaudio.raw_data, 'Int16')


#If Stereo

plt.figure(1)
plt.title('Signal Wave...')
plt.plot(signal)

from scipy.stats import stats

sig = np.array(stats.zscore(signal))
fs = myaudio.frame_rate

print('fundamental freuency %f' % freq_from_autocorr(sig, fs))

mfcc_feat = mfcc(sig,fs)
d_mfcc_feat = delta(mfcc_feat, 2)
fbank_feat = logfbank(sig,fs)
print(fbank_feat[1:3,:])
print(d_mfcc_feat)

plt.figure(2)
plt.title('Signal Wave standarized')
plt.plot(sig)

plt.show()