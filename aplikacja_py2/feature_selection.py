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
from sklearn.mixture import GaussianMixture
from sklearn.svm import SVC
import agh

d=agh.load_file('features_analysis-cc.csv')
X = d.data
y=d.target
X_scaled = scale(X)

# iris = load_iris()
# X = iris.data
# y = iris.target
X_train, X_test, y_train, y_test = train_test_split(
    X_scaled, y, test_size=0.33, random_state=1)

classificator = KNeighborsClassifier(n_neighbors=len(d.target_names))
# classificator = GaussianMixture(n_components=len(d.target_names), covariance_type='full')
# classificator=SVC()
# najlepsze wyniki dla KNN !!?

sfs1 = SFS(classificator,
          k_features=5,
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
classificator.fit(X_train_sfs, y_train)
y_pred = classificator.predict(X_test_sfs)

# Compute the accuracy of the prediction
acc = float((y_test == y_pred).sum()) / y_pred.shape[0]
print('Test set accuracy: %.2f %%' % (acc * 100))