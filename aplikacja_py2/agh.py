# -*- coding: utf-8 -*-import csv

import csv
import numpy as np
from sklearn.utils import Bunch


emotions = ['IR','NE','RA','SM','ST','ZD','ZL']

def load_file(filename):

    with open(filename, 'rb') as csvfile:
        data = []
        target = []
        spamreader = csv.reader(csvfile)
        for row in spamreader:
            data.append(row[4:])
            target.append(row[1])
    return Bunch(data=np.array(data[1:], dtype=np.float64),
              target=np.array(map(lambda e:emotions.index(e), target[1:]),dtype=np.int64),
              target_names=emotions,
              DESCR="wertjkljhgfdsadfgh",
              feature_names=data[0])


