from sklearn import preprocessing
from sklearn.decomposition import PCA
from sklearn.feature_selection import RFECV
from sklearn.preprocessing import QuantileTransformer, StandardScaler, RobustScaler, Normalizer
import numpy as np
from emo.model import Signal

from scipy.io import wavfile

def preprocess(signal):
    shape = signal.signal.shape
    mono = None
    if len(shape) == 1:
        mono = signal.signal
    elif len(shape) == 2 and shape[1] == 2:
        mono = signal.signal[:,0]+signal.signal[:,1]
    return Signal(preprocessing.scale(mono), signal.fs)


def standardize(A):
    return (A - np.mean(A)) / np.std(A)


def read_file(filename):
    [fs, x] = wavfile.read(filename)
    return Signal(x, fs)

def selectorInfo(selector):
    if type(selector) == PCA:
        return {
            'type': 'PCA',
            'used_components': selector.n_components_
        }
    elif type(selector) == RFECV:
        return {
            'type': 'RFECV',
            'used_components': selector.n_features_
        }
    else: raise UserWarning("unknown type " + str(type(selector)))