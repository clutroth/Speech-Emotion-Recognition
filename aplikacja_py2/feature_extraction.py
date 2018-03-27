#!/usr/bin/python
# -*- coding: utf-8 -*-import csv
import csv
import numpy as np

import fnmatch
import os
from python_speech_features import mfcc
from python_speech_features import sigproc
from scipy.io import wavfile
from python_speech_features import ssc
from emo.model import Signal, FeatureDescriptor
from emo.stage import preprocess
from sklearn.utils import check_array


def read_file(filename):
    [fs, x] = wavfile.read(filename)
    return Signal(x, fs)


def split(signal, frame_len, frame_step):
    return [Signal(s, signal.fs) for s in sigproc.framesig(signal.signal, frame_len, frame_step)]


def extract_features(frame):
    def entrophy(sig, subframes_number=10):
        energy =  [sum(s ** 2) for s in np.array_split(sig, subframes_number)]
        total_energy = sum(energy)
        probabilities=[e/total_energy for e in energy]
        return sum([p+np.log2(p) for p in probabilities if p not in [0]])

    return Features(
        mfcc=mfcc(frame.signal, frame.fs, float(len(frame.signal)) / frame.fs, winfunc=np.hamming)[0],
        ssc=ssc(frame.signal, frame.fs, float(len(frame.signal)) / frame.fs, winfunc=np.hamming)[0],
        energy=np.sum(frame.signal ** 2),
        zero_corssing_rate = ((frame.signal [:-1] * frame.signal [1:]) < 0).sum(),
        entrophy=entrophy(frame.signal)
    )

class Features:
    def __init__(self, mfcc, energy, zero_corssing_rate, entrophy, ssc):
        self.mfcc = mfcc
        self.energy = energy
        self.zero_corssing_rate=zero_corssing_rate
        self.entropy_of_energy=entrophy
        self.ssc=ssc


class FileDescription:
    def __init__(self, fullname):
        filename = fullname[-12:]
        self.name = filename
        self.fullname = fullname
        self.speaker = filename[0:3]
        self.emotion = filename[4:6]
        self.type = filename[7]


def statistical_describe_features(featureMap):
    stats = {}
    for (name, feature) in featureMap.items():
        description = FeatureDescriptor(feature)
        stats.update({
            name + ' min': description.min,
            name + ' max': description.max,
            name + ' kurtosis': description.kurtosis,
            name + ' mean': description.mean,
            name + ' skewness': description.skewness,
            name + ' variance': description.variance
        })
    return stats


def features_to_map(frames):
    def featuresToArray(features):
        return np.concatenate((features.mfcc, [features.energy], [features.zero_corssing_rate], [features.entropy_of_energy], features.ssc))

    def toFeatureList(frame_list):
        return np.transpose([featuresToArray(frame) for frame in frame_list])

    features = toFeatureList(frames)
    check_array(features, "csr")
    return {
        'mfcc 1': features[0],
        'mfcc 2': features[1],
        'mfcc 3': features[2],
        'mfcc 4': features[3],
        'mfcc 5': features[4],
        'mfcc 6': features[5],
        'mfcc 7': features[6],
        'mfcc 8': features[7],
        'mfcc 9': features[8],
        'mfcc 10': features[9],
        'mfcc 11': features[10],
        'mfcc 12': features[11],
        'mfcc 13': features[12],
        'energy': features[13],
        'zero crossing rate': features[14],
        'entropy of energy': features[15],
        'ssc 1': features[16],
        'ssc 2': features[17],
        'ssc 3': features[18],
        'ssc 4': features[19],
        'ssc 5': features[20],
        'ssc 6': features[21],
        'ssc 7': features[22],
        'ssc 8': features[23],
        'ssc 9': features[24],
        'ssc 10': features[25],
        'ssc 11': features[26],
        'ssc 12': features[27],
        'ssc 13': features[28],
        'ssc 14': features[29],
        'ssc 15': features[30],
        'ssc 16': features[31],
        'ssc 17': features[32],
        'ssc 18': features[33],
        'ssc 19': features[34],
        'ssc 20': features[35],
        'ssc 21': features[36],
        'ssc 22': features[37],
        'ssc 23': features[38],
        'ssc 24': features[39],
        'ssc 25': features[40],
        'ssc 26': features[41],
    }


def analyse_file(filename):
    f = read_file(filename)
    p = preprocess(f)
    frames = split(p, 500, 200)
    features = [extract_features(frame) for frame in frames]
    feturesMap = features_to_map(features)
    return statistical_describe_features(feturesMap)


def values(file, description):
    row = [description.fullname, description.emotion, description.speaker, description.type]
    row.extend(file.values())
    return row

def find_file(path, name):
    fileList = []
    # Walk through directory
    for dName, sdName, fList in os.walk(path):
        for fileName in fList:
            if fnmatch.fnmatch(fileName, name):  # Match search string
                fileList.append(os.path.join(dName, fileName))
    return fileList




korpus = '/home/wdk/uczelnia/mgr/materiały/agh/EmotiveKorpus/'

fileList=find_file(korpus, '*.wav')
firstFileName = fileList[0]
featureNames = analyse_file(firstFileName).keys()
names = ['filename', 'emotion', 'speaker', 'type']
names.extend(featureNames)

with open("features_analysis.csv", "wb") as file:
    writer = csv.writer(file)
    writer.writerow(names)
    for filename in fileList:
        print "processing " + filename
        file = analyse_file(filename)
        des = FileDescription(filename)

        writer.writerow(values(file, des))
