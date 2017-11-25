import numpy as np

from scipy import stats
import numpy as np

class Signal:
    def __init__(self, signal, fs):
        self.signal = signal
        self.fs = fs

    def __eq__(self, other):
        print self.signal, other.signal
        return (
            self.__class__ == other.__class__ and
            np.array_equal(self.signal, other.signal) and
            self.fs == other.fs
        )
    def __str__(self):
        return "signal length: %d sum value: %f fs: %f" % (len(self.signal), sum(self.signal), self.fs)


class FlatSignalFeature:
    def __init__(self, frames):
        def toFeatureList(frame_list):
            return np.transpose([frame.toArray() for frame in frame_list])

        features = toFeatureList(frames)
        self.mfcc_1 = features[0]
        self.mfcc_2 = features[1]
        self.mfcc_3 = features[2]
        self.mfcc_4 = features[3]
        self.mfcc_5 = features[4]
        self.mfcc_6 = features[5]
        self.mfcc_7 = features[6]
        self.mfcc_8 = features[7]
        self.mfcc_9 = features[8]
        self.mfcc_10 = features[9]
        self.mfcc_11 = features[10]
        self.mfcc_12 = features[11]
        self.mfcc_13 = features[12]
        self.energy = features[13]


class FeatureDescriptor:
    def __init__(self, feature):
        [nobs, [self.min, self.max], self.mean, self.variance, self.skewness, self.kurtosis] = stats.describe(feature)