#!/usr/bin/python
# -*- coding: utf-8 -*-import csv
import csv
import numpy as np

import fnmatch
import os
from python_speech_features import mfcc
from python_speech_features import sigproc
from scipy.io import wavfile

from emo.model import Signal, FeatureDescriptor
from emo.stage import preprocess

def read_file(filename):
    [fs, x] = wavfile.read(filename)
    return Signal(x, fs)


def split(signal, frame_len, frame_step):
    return [Signal(s, signal.fs) for s in sigproc.framesig(signal.signal, frame_len, frame_step)]


def extract_features(frame):
    return Features(
        mfcc=mfcc(frame.signal, frame.fs, float(len(frame.signal)) / frame.fs, winfunc=np.hamming),
        energy=np.sum(frame.signal ** 2)
    )

class Features:
    def __init__(self, mfcc, energy):
        self.mfcc = mfcc
        self.energy = energy


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
        return np.append(features.mfcc, features.energy)

    def toFeatureList(frame_list):
        return np.transpose([featuresToArray(frame) for frame in frame_list])

    features = toFeatureList(frames)
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
        'energy': features[13]
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

korpusFileList=find_file(korpus, '*.wav')

angry_files = ['/home/wdk/uczelnia/mgr/materiały/agh/EmotiveKorpus/RA/AKL_RA_T.wav',
         '/home/wdk/uczelnia/mgr/materiały/agh/EmotiveKorpus/NE/MCH_NE_P.wav']

firstFileName = '/home/wdk/uczelnia/mgr/materiały/agh/EmotiveKorpus/RA/AKL_RA_T.wav'
firstFile = analyse_file(firstFileName)
names = ['filename', 'emotion', 'speaker', 'type']
names.extend(firstFile.keys())

with open("features_analysis.csv", "wb") as file:
    writer = csv.writer(file)
    writer.writerow(names)
    for filename in korpusFileList:
        print "processing " + filename
        firstFile = analyse_file(filename)
        des = FileDescription(filename)

        writer.writerow(values(firstFile, des))
