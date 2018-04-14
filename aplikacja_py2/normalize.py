#!/usr/bin/env python
import sys

from scipy.io import wavfile

from emo.stage import preprocess, read_file


def saveDatFile(s, filename):
    with open(filename, 'w') as f:
        for n in range(s.signal.size):
            f.write('{0}\t{1}\n'.format(float(n) / s.fs, s.signal[n]))

fileNameIn = sys.argv[1]
fileNameOutUnstandarized = sys.argv[2]
fileNameOutStandarized = sys.argv[3]

originaFile = read_file(fileNameIn)
s = preprocess(originaFile)

saveDatFile(originaFile, fileNameOutUnstandarized)
saveDatFile(s, fileNameOutStandarized)

