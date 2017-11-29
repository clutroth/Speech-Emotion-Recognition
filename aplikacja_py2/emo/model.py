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


class FeatureDescriptor:
    def __init__(self, feature):
        [nobs, [self.min, self.max], self.mean, self.variance, self.skewness, self.kurtosis] = stats.describe(feature)