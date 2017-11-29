#!/usr/bin/python
# -*- coding: utf-8 -*-import csv

from sklearn.neighbors import KNeighborsClassifier
from sklearn.datasets import load_iris
import pandas as pd
from mlxtend.feature_selection import SequentialFeatureSelector as SFS
import csv
import numpy as np
from sklearn.model_selection import train_test_split
from sklearn.preprocessing import scale

emotions = [
    ('IR', 'ironia'),
    ('NE', 'stan neutralny'),
    ('RA', 'radość'),
    ('SM', 'smutek'),
    ('ST', 'strach'),
    ('ZD', 'zdziwienie'),
    ('ZL', 'złość')
]
def load(filename, emotions):

    with open(filename, 'rb') as csvfile:
        data = []
        target = []
        spamreader = csv.reader(csvfile)
        for row in spamreader:
            data.append(row[4:])
            target.append(row[1])
    return np.array( map(lambda e:emotions.index(e), target[1:]), dtype=np.float64),        \
        np.array(data[1:], dtype=np.float64)


y, X = load('features_analysis-cc.csv', map(lambda x:x[0], emotions))
X_scaled = scale(X)

# iris = load_iris()
# X = iris.data
# y = iris.target
X_train, X_test, y_train, y_test = train_test_split(
    X_scaled, y, test_size=0.33, random_state=1)

knn = KNeighborsClassifier(n_neighbors=3)


sfs1 = SFS(knn,
          k_features=10,
          forward=True,
          floating=False,
          scoring='accuracy',
          cv=4,
          n_jobs=-1)
sfs1 = sfs1.fit(X_train, y_train)
print('Selected features:', sfs1.k_feature_idx_)

X_train_sfs = sfs1.transform(X_train)
X_test_sfs = sfs1.transform(X_test)

# Fit the estimator using the new feature subset
# and make a prediction on the test data
knn.fit(X_train_sfs, y_train)
y_pred = knn.predict(X_test_sfs)

# Compute the accuracy of the prediction
acc = float((y_test == y_pred).sum()) / y_pred.shape[0]
print('Test set accuracy: %.2f %%' % (acc * 100))