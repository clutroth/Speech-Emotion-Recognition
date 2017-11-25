from sklearn import preprocessing

from emo.model import Signal


def preprocess(signal):
    shape = signal.signal.shape
    mono = None
    if len(shape) == 1:
        mono = signal.signal
    elif len(shape) == 2 and shape[1] == 2:
        mono = signal.signal[:,0]+signal.signal[:,1]
    standarized = preprocessing.scale(mono)
    return Signal(preprocessing.scale(standarized), signal.fs)